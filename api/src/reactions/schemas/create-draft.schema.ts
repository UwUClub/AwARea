import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { OmitType } from '@nestjs/swagger';
import { Reaction } from './reactions.schema';
import { ReactionTypeEnum } from '../_utils/enum/reaction-type.enum';
import { HydratedDocument } from 'mongoose';

export type CreateDraftDocument = HydratedDocument<CreateDraft>;

@Schema()
export class CreateDraft extends OmitType(Reaction, ['reactionType'] as const) {
    reactionType: ReactionTypeEnum.CREATE_DRAFT;

    @Prop({ required: true })
    email: string;

    @Prop({ required: true })
    subject: string;

    @Prop({ required: true })
    body: string;
}

export const CreateDraftSchema = SchemaFactory.createForClass(CreateDraft);
