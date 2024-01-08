import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { User, UserDocument } from './users.schema';
import { Model, Types } from 'mongoose';
import { CreateUserDto } from './_utils/dto/request/create-user.dto';
import { hashSync } from 'bcrypt';
import { GoogleUserCreationInterface } from './_utils/google-user-creation.interface';

@Injectable()
export class UsersRepository {
  constructor(@InjectModel(User.name) private userModel: Model<UserDocument>) {}

  create = (userDto: CreateUserDto) =>
    this.userModel.create({
      username: userDto.username,
      fullName: userDto.fullName,
      email: userDto.email,
      password: hashSync(userDto.password, 10),
    });

  createOAuthUser = (userInfo: GoogleUserCreationInterface) =>
    this.userModel.create({
      fullName: userInfo.fullName,
      email: userInfo.email,
      password: null,
      username: null,
      googleId: userInfo.googleId,
      googleAccessToken: userInfo.googleAccessToken,
    });

  findOneByGoogleId = (googleId: string) => this.userModel.findOne({ googleId: googleId }).exec();

  findOneByGithubId = (githubId: string) => this.userModel.find({ githubId: githubId }).exec();

  findOneByEmail = (email: string) => this.userModel.findOne({ email: email }).exec();

  findOneByUsername = (username: string) => this.userModel.findOne({ username: username }).exec();

  findById = (id: string) => this.userModel.findById(id).orFail(new NotFoundException('User not found')).exec();

  updateOneById = (id: Types.ObjectId, update: Partial<UserDocument>) =>
    this.userModel.findByIdAndUpdate(id, update, { new: true }).exec();
}
