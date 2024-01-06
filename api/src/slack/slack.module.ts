import { Module } from '@nestjs/common';
import { SlackController } from './slack.controller';
import { UsersModule } from 'src/users/users.module';

@Module({
    imports: [UsersModule],
    controllers: [SlackController],
    providers: [],
    exports: [],
})
export class SlackModule { }
