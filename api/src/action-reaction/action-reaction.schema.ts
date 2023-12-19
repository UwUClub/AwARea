import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { HydratedDocument, Types } from 'mongoose';
import { User, UserDocument } from '../users/users.schema';
import { Action, ActionDocument } from '../actions/schemas/actions.schema';

export type ActionReactionDocument = HydratedDocument<ActionReaction>;

@Schema()
export class ActionReaction {
    @Prop({
        default: null,
        ref: Action.name,
        type: Types.ObjectId,
    })
    action: Types.ObjectId | ActionDocument | null;

    @Prop({ default: null })
    reaction: Types.ObjectId | null;

    @Prop({ required: true, ref: User.name, type: Types.ObjectId })
    user: Types.ObjectId | UserDocument;

    @Prop({ required: true, unique: true })
    actionReactionName: string;

    @Prop({ default: null })
    actionReactionSchedule: string | null;
}

export const ActionReactionSchema =
    SchemaFactory.createForClass(ActionReaction);
