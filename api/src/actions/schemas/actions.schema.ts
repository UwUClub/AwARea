import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { ActionTypeEnum } from '../_utils/enums/action-type.enum';
import { HydratedDocument } from 'mongoose';
import { NasaApodActionDocument } from './nasa-apod-action.schema';
import { WeatherActionDocument } from './weather-action.schema';

export type ActionDocument = HydratedDocument<Action>;

export type ActionDocumentType = NasaApodActionDocument | WeatherActionDocument;

@Schema({ discriminatorKey: 'actionType' })
export class Action {
    @Prop({ required: true, enum: ActionTypeEnum, type: String })
    actionType: ActionTypeEnum;
}

export const ActionSchema = SchemaFactory.createForClass(Action);
