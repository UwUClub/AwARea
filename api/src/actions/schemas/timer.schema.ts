import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { OmitType } from '@nestjs/swagger';
import { ActionTypeEnum } from '../_utils/enums/action-type.enum';
import { Action } from './actions.schema';
import { HydratedDocument } from 'mongoose';

export type TimerActionDocument = HydratedDocument<TimerAction>;

@Schema()
export class TimerAction extends OmitType(Action, ['actionType'] as const) {
  actionType: ActionTypeEnum.TIMER;

  @Prop({ required: true, type: Date })
  date: Date;
}

export const TimerActionSchema = SchemaFactory.createForClass(TimerAction);
