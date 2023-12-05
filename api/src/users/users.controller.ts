import { Controller, Get } from '@nestjs/common';
import { UsersMapper } from './users.mapper';
import { Protect } from '../auth/_utils/decorators/protect.decorator';
import { ConnectedUser } from 'src/auth/_utils/decorators/connected-user.decorator';
import { UserDocument } from './users.schema';

@Controller('users')
export class UsersController {
    constructor(private readonly usersMapper: UsersMapper) {}

    @Protect()
    @Get('me')
    getMe(@ConnectedUser() user: UserDocument) {
        return this.usersMapper.toGetUserDto(user);
    }
}
