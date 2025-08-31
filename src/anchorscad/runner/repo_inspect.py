import os
import re
from dataclasses import dataclass
from typing import Optional

try:
    import pygit2
except ImportError:
    raise ImportError("pygit2 is not installed. Please install it with 'pip install pygit2'")

from anchorscad.runner.runner_status import SourceRepo


def get_git_info(file_path: str) -> Optional[SourceRepo]:
    """
    Given a full path to a file, finds its Git repository information using pygit2.

    This function uses the pygit2 library to determine the repository root,
    current commit ID, and the remote origin URL. It also checks if the
    current commit has been pushed to the origin remote.

    Args:
        file_path (str): The absolute path to the file you want to inspect.

    Returns:
        SourceRepo: A dataclass instance containing the git information if the
                    file is in a git repository with a configured remote origin.
        None: If the file is not in a Git repository, or if any of the git
              operations fail.
    """
    if not os.path.isfile(file_path):
        raise FileNotFoundError(f"File not found: {file_path}")

    try:
        file_dir = os.path.dirname(os.path.abspath(file_path))
        repo_path = pygit2.discover_repository(file_dir)
        if repo_path is None:
            return None

        repo = pygit2.Repository(repo_path)
        repo_root = repo.workdir

        if repo.head_is_unborn:
            return None
        commit_oid = repo.head.target
        commit_id = str(commit_oid)

        # Check if the commit is on the remote 'origin'
        is_on_origin = False
        try:
            origin_remote_refs = [r for r in repo.references if r.startswith('refs/remotes/origin/')]
            for ref_name in origin_remote_refs:
                ref = repo.references[ref_name]
                # Ensure it's a direct reference, not symbolic
                if ref.type == pygit2.GIT_OBJECT_COMMIT:
                    # Check if our local commit is an ancestor of this remote branch
                    merge_base = repo.merge_base(commit_oid, ref.target)
                    if merge_base and merge_base == commit_oid:
                        is_on_origin = True
                        break # Found it, no need to check other remote branches
        except pygit2.GitError:
            # If there is any error checking remote status (e.g., no fetch has occurred),
            # conservatively assume the commit is not confirmed to be on origin.
            is_on_origin = False


        file_abs_path = os.path.abspath(file_path)
        file_path_in_repo = os.path.relpath(file_abs_path, repo_root)
        file_path_in_repo = file_path_in_repo.replace(os.path.sep, '/')

        remote_url = repo.remotes['origin'].url

        repo_name = None
        service = None
        ssh_match = re.search(r'git@([\w\.-]+):([\w.-]+/[\w.-]+?)(?:\.git)?$', remote_url)
        if ssh_match:
            host = ssh_match.group(1).lower()
            repo_name = ssh_match.group(2)
            if 'github' in host: service = 'github'
            elif 'gitlab' in host: service = 'gitlab'
            elif 'bitbucket' in host: service = 'bitbucket'
        else:
            https_match = re.search(r'https?://([\w.-]+)/([\w.-]+/[\w.-]+?)(?:\.git)?$', remote_url)
            if https_match:
                host = https_match.group(1).lower()
                repo_name = https_match.group(2)
                if 'github' in host: service = 'github'
                elif 'gitlab' in host: service = 'gitlab'
                elif 'bitbucket' in host: service = 'bitbucket'

        if not repo_name or not service:
            return None

        return SourceRepo(
            repo_name=repo_name,
            commit_id=commit_id,
            file_path_in_repo='/' + file_path_in_repo,
            service=service,
            origin=remote_url,
            is_on_origin=is_on_origin,
        )
    except (KeyError, pygit2.GitError):
        # KeyError for when remote 'origin' does not exist
        # pygit2.GitError for general git issues
        return None

if __name__ == '__main__':
    current_directory = os.getcwd()
    test_file_name = 'anchorscad-core/src/anchorscad_models/components/terminal_blocks/terminal_kf301.py'
    test_file_path = os.path.join(current_directory, test_file_name)

    with open(test_file_path, 'w') as f:
        f.write('This is a test file for the git_repo_inspector script.')
    
    print(f"Attempting to get Git info for: {test_file_path}\n")
    git_data = get_git_info(test_file_path)

    if git_data:
        print("--- Git Information Found ---")
        print(f"Repository Name:   {git_data.repo_name}")
        print(f"Commit ID:         {git_data.commit_id}")
        print(f"File Path in Repo: {git_data.file_path_in_repo}")
        print(f"Hosting Service:   {git_data.service}")
        print(f"Origin URL:        {git_data.origin}")
        print(f"Commit on Origin:  {git_data.is_on_origin}")
        
        print("\n--- Generated URLs ---")
        print(f"URL to file:       {git_data.get_url()}")
        print(f"URL to line 15:    {git_data.get_url(line_number=15)}")
        print(f"Raw content URL:   {git_data.get_raw_url()}")

        # if requests:
        #     print("\n--- Fetching Remote Content ---")
        #     # Note: This will only succeed if the commit has actually been pushed.
        #     if git_data.is_on_origin:
        #         content = git_data.fetch_contents()
        #         if content:
        #             print(f"Successfully fetched content. First 50 chars:\n'{content[:50].strip()}...'")
        #         else:
        #             print("Failed to fetch content (the file might be new or URL is incorrect).")
        #     else:
        #         print("Skipping content fetch: commit is not on origin.")
    else:
        print("--- No Git Information Found ---")
        print("This script is likely not running from within a Git repository,")
        print("or the repository does not have a remote 'origin' configured.")

    os.remove(test_file_path)
