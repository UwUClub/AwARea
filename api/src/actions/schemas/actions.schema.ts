import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { ActionTypeEnum } from '../_utils/enums/action-type.enum';
import { HydratedDocument } from 'mongoose';

export type ActionDocument = HydratedDocument<Action>;

@Schema({ discriminatorKey: 'actionType' })
export class Action {
    @Prop({ required: true, enum: ActionTypeEnum, type: String })
    actionType: ActionTypeEnum;
}

export const ActionSchema = SchemaFactory.createForClass(Action);
