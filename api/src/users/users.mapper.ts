import { Injectable } from '@nestjs/common';
import { UserDocument } from './users.schema';
import { GetUserDto } from './_utils/dto/response/get-user.dto';
import { GoogleApiService } from '../google-api/google-api.service';

@Injectable()
export class UsersMapper {
  constructor(private readonly googleApiService: GoogleApiService) {}

  async toGetUserDto(user: UserDocument): Promise<GetUserDto> {
    const googleConnected =
      user.googleAccessToken !== null ? await this.googleApiService.testConnection(user.googleAccessToken) : false;
    const slackConnected = user.slackBotToken !== null;
    return {
      id: user._id.toString(),
      username: user.username ?? '',
      fullName: user.fullName ?? undefined,
      email: user.email,
      isLoggedInGoogle: googleConnected,
      isLoggedInGithub: user.githubAccessToken != null,
      slackConnected,
    };
  }
}
