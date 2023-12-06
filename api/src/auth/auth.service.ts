import { Injectable, UnauthorizedException } from '@nestjs/common';
import { UsersRepository } from '../users/users.repository';
import { compareSync } from 'bcrypt';
import { UsersMapper } from '../users/users.mapper';
import { SignInDto } from './_utils/dto/request/sign-in.dto';
import { isEmail } from 'class-validator';
import { UserDocument } from '../users/users.schema';
import { JwtService } from '@nestjs/jwt';
import { CreateUserDto } from '../users/_utils/dto/request/create-user.dto';
import { SuccesLoginDto } from './_utils/dto/response/succes-login.dto';
import { UsersService } from '../users/users.service';

@Injectable()
export class AuthService {
    constructor(
        private readonly usersService: UsersService,
        private readonly usersRepository: UsersRepository,
        private readonly usersMapper: UsersMapper,
        private readonly jwtService: JwtService,
    ) {}

    async signUp(createUserDto: CreateUserDto): Promise<SuccesLoginDto> {
        const user = await this.usersService.create(createUserDto);

        return {
            user: this.usersMapper.toGetUserDto(user),
            accessToken: await this.createToken(user),
        };
    }

    async signIn(signInDto: SignInDto): Promise<SuccesLoginDto> {
        let user: UserDocument;

        if (isEmail(signInDto.usernameOrEmail)) {
            user = await this.usersRepository.findOneByEmail(
                signInDto.usernameOrEmail,
            );
        } else {
            user = await this.usersRepository.findOneByUsername(
                signInDto.usernameOrEmail,
            );
        }
        if (!user || !compareSync(signInDto.password, user.password))
            throw new UnauthorizedException('Invalid credentials');

        return {
            user: this.usersMapper.toGetUserDto(user),
            accessToken: await this.createToken(user),
        };
    }

    private createToken = (user: UserDocument) =>
        this.jwtService.signAsync({ sub: user._id.toString() });
}
