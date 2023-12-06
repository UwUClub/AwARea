import { ConflictException, Injectable } from '@nestjs/common';
import { UsersRepository } from './users.repository';
import { CreateUserDto } from './_utils/dto/request/create-user.dto';

@Injectable()
export class UsersService {
    constructor(private readonly usersRepository: UsersRepository) {}

    async create(userDto: CreateUserDto) {
        if (await this.usersRepository.findOneByEmail(userDto.email))
            throw new ConflictException('Email already exists');
        if (await this.usersRepository.findOneByUsername(userDto.username))
            throw new ConflictException('Username already exists');

        return this.usersRepository.create(userDto);
    }
}
