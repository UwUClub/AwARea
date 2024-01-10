import { forwardRef, Module } from '@nestjs/common';
import { NasaService } from './nasa.service';
import { NasaMapper } from './nasa.mapper';
import { HttpModule } from '@nestjs/axios';
import { ActionReactionModule } from '../action-reaction/action-reaction.module';
import { ReactionsModule } from '../reactions/reactions.module';

@Module({
  imports: [HttpModule, forwardRef(() => ActionReactionModule), ReactionsModule],
  providers: [NasaService, NasaMapper],
  exports: [NasaService],
})
export class NasaModule {}
