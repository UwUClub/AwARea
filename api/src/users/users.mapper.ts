import { Injectable } from '@nestjs/common';
import { UserDocument } from './users.schema';
import { GetUserDto } from './_utils/dto/response/get-user.dto';

@Injectable()
export class UsersMapper {
    toGetUserDto = (user: UserDocument): GetUserDto => ({
        id: user._id.toString(),
        username: user.username,
        fullName: user.fullName ?? undefined,
        email: user.email,
        isLoggedInGoogle: user.googleAccessToken != null,
        isLoggedInGithub: user.githubAccessToken != null,
    });
}
