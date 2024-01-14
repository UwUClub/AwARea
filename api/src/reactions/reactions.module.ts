import { Module } from '@nestjs/common';
import { ReactionsService } from './reactions.service';
import { ReactionsController } from './reactions.controller';
import { MongooseModule } from '@nestjs/mongoose';
import { Reaction, ReactionSchema } from './schemas/reactions.schema';
import { ReactionTypeEnum } from './_utils/enum/reaction-type.enum';
import { CreateDraftSchema } from './schemas/create-draft.schema';
import { ReactionRepository } from './reaction.repository';
import { GoogleApiModule } from '../google-api/google-api.module';
import { SendSlackMessageSchema } from './schemas/send-slack-message.schema';
import { CreateSlackChannelSchema } from './schemas/create-slack-channel.schema';
import { SlackModule } from '../slack/slack.module';
import { SendEmailSchema } from './schemas/send-email.schema';

@Module({
  imports: [
    MongooseModule.forFeature([
      {
        name: Reaction.name,
        schema: ReactionSchema,
        discriminators: [
          {
            name: ReactionTypeEnum.CREATE_DRAFT,
            schema: CreateDraftSchema,
          },
          {
            name: ReactionTypeEnum.SEND_SLACK_MESSAGE,
            schema: SendSlackMessageSchema,
          },
          {
            name: ReactionTypeEnum.CREATE_SLACK_CHANNEL,
            schema: CreateSlackChannelSchema,
          },
          {
            name: ReactionTypeEnum.SEND_EMAIL,
            schema: SendEmailSchema,
          },
        ],
      },
    ]),
    GoogleApiModule,
    SlackModule,
  ],
  controllers: [ReactionsController],
  providers: [ReactionsService, ReactionRepository],
  exports: [ReactionRepository, ReactionsService],
})
export class ReactionsModule {}
