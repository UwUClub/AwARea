export class GetUserDto {
  id: string;
  username: string;
  fullName?: string;
  email: string;
  isLoggedInGoogle: boolean;
  isLoggedInGithub: boolean;
  slackConnected: boolean;
}
