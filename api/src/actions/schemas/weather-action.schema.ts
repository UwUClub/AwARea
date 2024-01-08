import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { ActionTypeEnum } from '../_utils/enums/action-type.enum';
import { Action } from './actions.schema';
import { OmitType } from '@nestjs/swagger';
import { HydratedDocument } from 'mongoose';

export type WeatherActionDocument = HydratedDocument<WeatherAction>;

@Schema()
export class WeatherAction extends OmitType(Action, ['actionType'] as const) {
  actionType: ActionTypeEnum.WEATHER_GET_CURRENT;

  @Prop({ required: true })
  city: string;
}

export const WeatherActionSchema = SchemaFactory.createForClass(WeatherAction);
