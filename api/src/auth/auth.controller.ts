import { Body, Controller, Post } from '@nestjs/common';
import { AuthService } from './auth.service';
import { SignInDto } from './_utils/dto/request/sign-in.dto';
import { CreateUserDto } from '../users/_utils/dto/request/create-user.dto';
import { ApiTags } from '@nestjs/swagger';

@ApiTags('Auth')
@Controller('auth')
export class AuthController {
    constructor(private readonly authService: AuthService) {}

    @Post('login')
    signIn(@Body() signInDto: SignInDto) {
        return this.authService.signIn(signInDto);
    }

    @Post('register')
    signUp(@Body() signUpDto: CreateUserDto) {
        return this.authService.signUp(signUpDto);
    }
}