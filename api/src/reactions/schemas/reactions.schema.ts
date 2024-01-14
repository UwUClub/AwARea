import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { ReactionTypeEnum } from '../_utils/enum/reaction-type.enum';
import { HydratedDocument } from 'mongoose';
import { CreateDraftDocument } from './create-draft.schema';
import { SendSlackMessageDocument } from './send-slack-message.schema';
import { CreateSlackChannelDocument } from './create-slack-channel.schema';
import { SendEmailDocument } from './send-email.schema';

export type ReactionDocument = HydratedDocument<Reaction>;

export type ReactionDocumentType =
  | CreateDraftDocument
  | SendSlackMessageDocument
  | CreateSlackChannelDocument
  | SendEmailDocument;

@Schema({ discriminatorKey: 'reactionType' })
export class Reaction {
  @Prop({ required: true, enum: ReactionTypeEnum, type: String })
  reactionType: ReactionTypeEnum;
}

export const ReactionSchema = SchemaFactory.createForClass(Reaction);
