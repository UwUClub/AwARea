import { ConflictException, Injectable } from '@nestjs/common';
import { UsersRepository } from './users.repository';
import { CreateUserDto } from './_utils/dto/request/create-user.dto';
import { UserDocument } from './users.schema';
import axios from 'axios';
import { GithubApiService } from '../github-api/services/github-api.service';
import { UpdateUserDto } from './_utils/dto/request/update-user.dto';
import { UsersMapper } from './users.mapper';

@Injectable()
export class UsersService {
  constructor(
    private readonly usersRepository: UsersRepository,
    private readonly githubApiService: GithubApiService,
    private readonly userMapper: UsersMapper,
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
