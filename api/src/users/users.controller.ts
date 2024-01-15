import { Body, Controller, Get, Post, Put } from '@nestjs/common';
import { UsersMapper } from './users.mapper';
import { Protect } from '../auth/_utils/decorators/protect.decorator';
import { ConnectedUser } from '../auth/_utils/decorators/connected-user.decorator';
import { UserDocument } from './users.schema';
import { UsersService } from './users.service';
import { ApiTags } from '@nestjs/swagger';
import { AddGithubTokenDto } from './_utils/dto/request/add-github-token.dto';
import { UpdateUserDto } from './_utils/dto/request/update-user.dto';
import { UpdateGoogleTokenDto } from './_utils/dto/request/update-google-token.dto';

@ApiTags('users')
@Controller('users')
export class UsersController {
  constructor(
    private readonly usersMapper: UsersMapper,
    private readonly usersService: UsersService,
  ) {}

  @Protect()
  @Get('me')
  getMe(@ConnectedUser() user: UserDocument) {
    return this.usersMapper.toGetUserDto(user);
  }

  @Protect()
  @Post('github-token')
  async updateGithubToken(@ConnectedUser() user: UserDocument, @Body() body: AddGithubTokenDto) {
    if (body.githubToken == 'none') {
      await this.usersService.removeGithubToken(user);
      return this.usersMapper.toGetUserDto(user);
    }
    const updatedUser = await this.usersService.updateGithubToken(user, body.githubToken);
    return this.usersMapper.toGetUserDto(updatedUser);
  }

  @Protect()
  @Post('google-token')
  updateGoogleToken(@ConnectedUser() user: UserDocument, @Body() body: UpdateGoogleTokenDto) {
    return this.usersService.updateGoogleToken(user, body.googleToken);
  }

  @Protect()
  @Put()
  update(@ConnectedUser() user: UserDocument, @Body() body: UpdateUserDto) {
    return this.usersService.update(user, body);
  }
}
