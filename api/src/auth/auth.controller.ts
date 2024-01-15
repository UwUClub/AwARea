import { Body, Controller, Post, Headers, UnauthorizedException } from '@nestjs/common';
import { AuthService } from './auth.service';
import { SignInDto } from './_utils/dto/request/sign-in.dto';
import { CreateUserDto } from '../users/_utils/dto/request/create-user.dto';
import { ApiHeader, ApiTags } from '@nestjs/swagger';
import { GoogleLoginDto } from './_utils/dto/request/google-login.dto';
import { UsersService } from '../users/users.service';
import * as jwt from 'jsonwebtoken';
import { ConfigService } from '@nestjs/config';
import { EnvironmentVariables } from '../_utils/config';
import { JwtStrategy } from './jwt/jwt.startegy';

@ApiTags('Auth')
@Controller('auth')
export class AuthController {
  constructor(
    private readonly authService: AuthService,
    private readonly usersService: UsersService,
    private readonly configService: ConfigService<EnvironmentVariables, true>,
    private readonly jwtStrategy: JwtStrategy,
  ) {}

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
  async googleLogin(@Headers('Authorization') authorizationHeader: string, @Body() googleLoginDto: GoogleLoginDto) {
    if (authorizationHeader) {
      const token = authorizationHeader.split(' ')[1];
      const decodeToken = jwt.verify(token, this.configService.get('JWT_SECRET'));
      if (!decodeToken) throw new UnauthorizedException('Bad token');
      const user = await this.jwtStrategy.validate(decodeToken);
      console.log(user);
      return this.usersService.updateGoogleToken(user, googleLoginDto.accessToken);
    }
    return this.authService.connectWithGoogle(googleLoginDto);
  }
}
