import { Module } from '@nestjs/common';
import { UsersService } from './users.service';
import { UsersController } from './users.controller';
import { MongooseModule } from '@nestjs/mongoose';
import { User, UserSchema } from './users.schema';
import { UsersRepository } from './users.repository';
import { UsersMapper } from './users.mapper';
import { GithubApiModule } from '../github-api/github-api.module';
import { GoogleApiModule } from '../google-api/google-api.module';

@Module({
  imports: [MongooseModule.forFeature([{ name: User.name, schema: UserSchema }]), GithubApiModule, GoogleApiModule],
  controllers: [UsersController],
  providers: [UsersService, UsersRepository, UsersMapper],
  exports: [UsersService, UsersRepository, UsersMapper],
})
export class UsersModule {}
