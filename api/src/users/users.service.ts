import { ConflictException, Injectable, InternalServerErrorException, UnauthorizedException } from '@nestjs/common';
import { UsersRepository } from './users.repository';
import { CreateUserDto } from './_utils/dto/request/create-user.dto';
import { UserDocument } from './users.schema';
import { GithubApiService } from '../github-api/services/github-api.service';
import { UpdateUserDto } from './_utils/dto/request/update-user.dto';
import { UsersMapper } from './users.mapper';
import { GoogleApiService } from '../google-api/google-api.service';

@Injectable()
export class UsersService {
  constructor(
    private readonly usersRepository: UsersRepository,
    private readonly githubApiService: GithubApiService,
    private readonly userMapper: UsersMapper,
    private readonly googleService: GoogleApiService,
  ) {}

  async create(userDto: CreateUserDto) {
    if (await this.usersRepository.findOneByEmail(userDto.email)) throw new ConflictException('Email already exists');
    if (await this.usersRepository.findOneByUsername(userDto.username))
      throw new ConflictException('Username already exists');

    return this.usersRepository.create(userDto);
  }

  async updateGithubToken(user: UserDocument, githubToken: string) {
    const myGithubProfile = await this.githubApiService.getGithubUser(githubToken);

    return this.usersRepository.updateOneById(user._id, {
      githubAccessToken: githubToken,
      githubId: myGithubProfile.id,
      githubName: myGithubProfile.login,
    });
  }

  async updateGoogleToken(user: UserDocument, googleToken: string) {
    if (googleToken === 'none')
      return await this.usersRepository
        .updateOneById(user._id, { googleAccessToken: null })
        .then(this.userMapper.toGetUserDto);

    if (!(await this.googleService.testConnection(googleToken))) throw new UnauthorizedException('Bad access token');
    const newUser = await this.usersRepository.updateOneById(user._id, { googleAccessToken: googleToken });
    if (!newUser) throw new InternalServerErrorException('Fail to update user');
    return this.userMapper.toGetUserDto(newUser);
  }

  async removeGithubToken(user: UserDocument) {
    return this.usersRepository.updateOneById(user._id, {
      githubAccessToken: null,
      githubId: null,
      githubName: null,
    });
  }

  async update(user: UserDocument, body: UpdateUserDto) {
    user = await this.usersRepository.updateOneById(user._id, body);

    return this.userMapper.toGetUserDto(user);
  }
}
