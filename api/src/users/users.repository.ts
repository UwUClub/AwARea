import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { User, UserDocument } from './users.schema';
import { Model } from 'mongoose';
import { CreateUserDto } from './_utils/dto/request/create-user.dto';
import { hashSync } from 'bcrypt';

@Injectable()
export class UsersRepository {
    constructor(
        @InjectModel(User.name) private userModel: Model<UserDocument>,
    ) {}

    create = (userDto: CreateUserDto) =>
        this.userModel.create({
            username: userDto.username,
            fullName: userDto.fullName,
            email: userDto.email,
            password: hashSync(userDto.password, 10),
        });

    findOneByEmail = (email: string) =>
        this.userModel.findOne({ email: email }).exec();

    findOneByUsername = (username: string) =>
        this.userModel.findOne({ username: username }).exec();

    findById = (id: string) =>
        this.userModel
            .findById(id)
            .orFail(new NotFoundException('User not found'))
            .exec();
}
