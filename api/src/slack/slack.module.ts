import { forwardRef, Module } from '@nestjs/common';
import { SlackController } from './slack.controller';
import { UsersModule } from 'src/users/users.module';
import { SlackService } from './slack.service';

@Module({
  imports: [forwardRef(() => UsersModule)],
  controllers: [SlackController],
  providers: [SlackService],
  exports: [SlackService],
})
export class SlackModule {}
