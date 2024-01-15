import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { OmitType } from '@nestjs/swagger';
import { ReactionTypeEnum } from '../_utils/enum/reaction-type.enum';
import { Reaction } from './reactions.schema';
import { HydratedDocument } from 'mongoose';

export type CreateSlackChannelDocument = HydratedDocument<CreateSlackChannel>;

@Schema()
export class CreateSlackChannel extends OmitType(Reaction, ['reactionType'] as const) {
  reactionType: ReactionTypeEnum.CREATE_SLACK_CHANNEL;

  @Prop({ required: true })
  channelName: string;
}

export const CreateSlackChannelSchema = SchemaFactory.createForClass(CreateSlackChannel);
