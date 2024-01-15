import { Body, Controller, Get, Headers, Post } from '@nestjs/common';
import { GithubApiService } from './services/github-api.service';
import { Protect } from '../auth/_utils/decorators/protect.decorator';
import { ConnectedUser } from '../auth/_utils/decorators/connected-user.decorator';
import { UserDocument } from '../users/users.schema';

@Controller('github-api')
export class GithubApiController {
  constructor(private readonly githubApiService: GithubApiService) {}

  @Protect()
  @Get()
  async getGithubWebhooks(@ConnectedUser() user: UserDocument) {
    return this.githubApiService.getGithubWebhooks('global-game-jam', user.githubName, user.githubAccessToken);
  }

  @Post('callback')
  handleWebhook(
    @Headers('x-hub-signature') signature: string,
    @Headers('x-github-event') event: string,
    @Body() payload: any,
  ) {
    this.githubApiService.handleWebhook(payload, signature, event);
  }
}
