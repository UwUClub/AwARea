import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { ReactionTypeEnum } from '../_utils/enum/reaction-type.enum';
import { HydratedDocument } from 'mongoose';

export type ReactionDocument = HydratedDocument<Reaction>;

@Schema({ discriminatorKey: 'actionType' })
export class Reaction {
    @Prop({ required: true, enum: ReactionTypeEnum, type: String })
    reactionType: ReactionTypeEnum;
}

export const ReactionSchema = SchemaFactory.createForClass(Reaction);
