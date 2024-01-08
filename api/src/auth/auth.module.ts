import { Module } from '@nestjs/common';
import { AuthService } from './auth.service';
import { UsersModule } from '../users/users.module';
import { AuthController } from './auth.controller';
import { PassportModule } from '@nestjs/passport';
import { JwtModule } from '@nestjs/jwt';
import { JwtStrategy } from './jwt/jwt.startegy';
import { ConfigService } from '@nestjs/config';
import { EnvironmentVariables } from 'src/_utils/config';
import { GoogleApiModule } from '../google-api/google-api.module';

@Module({
  imports: [
    UsersModule,
    PassportModule,
    GoogleApiModule,
    JwtModule.registerAsync({
      useFactory: async (configService: ConfigService<EnvironmentVariables, true>) => ({
        global: true,
        secret: configService.get('JWT_SECRET'),
        signOptions: { expiresIn: '1d' },
      }),
      inject: [ConfigService],
    }),
  ],
  controllers: [AuthController],
  providers: [AuthService, JwtStrategy],
})
export class AuthModule {}
