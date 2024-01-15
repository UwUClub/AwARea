export interface StarInterface {
  starred_at: string;
  repoName: string;
  repoOwner: string;
  repoUrl: string;
  ownerName: string;
  starCount: number;
  starUserName: string;
}

export function toStarInterface(githubResponse: any): StarInterface {
  const starred_at = githubResponse.starred_at ?? 'No date';
  const repoName = githubResponse.repository.name;
  const repoOwner = githubResponse.repository.owner.login;
  const repoUrl = githubResponse.repository.html_url;
  const ownerName = githubResponse.sender.login;
  const starCount = githubResponse.repository.stargazers_count;
  const starUserName = githubResponse.sender.login;

  return {
    starred_at,
    repoName,
    repoOwner,
    repoUrl,
    ownerName,
    starCount,
    starUserName,
  };
}
