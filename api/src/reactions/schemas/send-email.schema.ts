import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { OmitType } from '@nestjs/swagger';
import { Reaction } from './reactions.schema';
import { ReactionTypeEnum } from '../_utils/enum/reaction-type.enum';
import { HydratedDocument } from 'mongoose';

export type SendEmailDocument = HydratedDocument<SendEmail>;

@Schema()
export class SendEmail extends OmitType(Reaction, ['reactionType'] as const) {
  reactionType: ReactionTypeEnum.SEND_EMAIL;

  @Prop({ required: true })
  email: string;

  @Prop({ required: true })
  subject: string;

  @Prop({ required: true })
  body: string;
}

export const SendEmailSchema = SchemaFactory.createForClass(SendEmail);
