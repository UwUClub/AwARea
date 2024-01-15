export interface PullRequestInterface {
  number: number;
  title: string;
  body: string;
  created_at: string;
  creator: string;
}

export function toPullRequestInterface(githubResponse: any): PullRequestInterface {
  const number = githubResponse.pull_request.number;
  const title = githubResponse.pull_request.title;
  const body = githubResponse.pull_request.body;
  const created_at = githubResponse.pull_request.created_at;
  const creator = githubResponse.sender.login;

  return {
    number,
    title,
    body,
    created_at,
    creator,
  };
}
