import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { OmitType } from '@nestjs/swagger';
import { Reaction } from './reactions.schema';
import { ReactionTypeEnum } from '../_utils/enum/reaction-type.enum';
import { HydratedDocument } from 'mongoose';

export type SendSlackMessageDocument = HydratedDocument<SendSlackMessage>;

@Schema()
export class SendSlackMessage extends OmitType(Reaction, ['reactionType'] as const) {
  reactionType: ReactionTypeEnum.SEND_SLACK_MESSAGE;

  @Prop({ required: true })
  channelName: string;

  @Prop({ required: true })
  message: string;
}

export const SendSlackMessageSchema = SchemaFactory.createForClass(SendSlackMessage);
