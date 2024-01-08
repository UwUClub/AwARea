export interface IssueInterface {
  repoName: string;
  repoUrl: string;
  number: number;
  title: string;
  body: string;
  created_at: string;
  creator: string;
}

export function toIssueInterface(githubResponse: any): IssueInterface {
  const repoName = githubResponse.repository.name;
  const repoUrl = githubResponse.repository.html_url;
  const number = githubResponse.issue.number;
  const title = githubResponse.issue.title;
  const body = githubResponse.issue.body;
  const created_at = githubResponse.issue.created_at;
  const creator = githubResponse.sender.login;

  return {
    repoName,
    repoUrl,
    number,
    title,
    body,
    created_at,
    creator,
  };
}
