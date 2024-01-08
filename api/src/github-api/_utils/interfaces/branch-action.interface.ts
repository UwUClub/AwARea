export interface BranchActionInterface {
  branchName: string;
  repoName: string;
  repoOwner: string;
  repoUrl: string;
  ownerName: string;
}

export function toBranchActionInterface(githubResponse: any): BranchActionInterface {
  const branchName = githubResponse.ref.replace('refs/heads/', '');
  const repoName = githubResponse.repository.name;
  const repoOwner = githubResponse.repository.owner.login;
  const repoUrl = githubResponse.repository.html_url;
  const ownerName = githubResponse.sender.login;

  return {
    branchName,
    repoName,
    repoOwner,
    repoUrl,
    ownerName,
  };
}
