import { forwardRef, Module } from '@nestjs/common';
import { TimerService } from './timer.service';
import { TimerController } from './timer.controller';
import { ActionReactionModule } from '../action-reaction/action-reaction.module';
import { ReactionsModule } from '../reactions/reactions.module';

@Module({
  imports: [forwardRef(() => ActionReactionModule), ReactionsModule],
  controllers: [TimerController],
  providers: [TimerService],
  exports: [TimerService],
})
export class TimerModule {}
