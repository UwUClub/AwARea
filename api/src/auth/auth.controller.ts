import { Body, Controller, Post } from '@nestjs/common';
import { AuthService } from './auth.service';
import { SignInDto } from './_utils/dto/request/sign-in.dto';
import { CreateUserDto } from '../users/_utils/dto/request/create-user.dto';
import { ApiTags } from '@nestjs/swagger';
import { GoogleLoginDto } from './_utils/dto/request/google-login.dto';

@ApiTags('Auth')
@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  /**
   * Endpoint for user login.
   * @param signInDto - The sign-in data transfer object.
   * @returns The result of the sign-in operation.
   */
  @Post('login')
  signIn(@Body() signInDto: SignInDto) {
    return this.authService.signIn(signInDto);
  }

  @Post('register')
  signUp(@Body() signUpDto: CreateUserDto) {
    return this.authService.signUp(signUpDto);
  }

  @Post('google-login')
  googleLogin(@Body() googleLoginDto: GoogleLoginDto) {
    return this.authService.connectWithGoogle(googleLoginDto);
  }
}
