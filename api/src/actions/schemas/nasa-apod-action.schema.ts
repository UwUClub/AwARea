import { Schema, SchemaFactory } from '@nestjs/mongoose';
import { OmitType } from '@nestjs/swagger';
import { Action } from './actions.schema';
import { ActionTypeEnum } from '../_utils/enums/action-type.enum';
import { HydratedDocument } from 'mongoose';

export type NasaApodActionDocument = HydratedDocument<NasaApodAction>;

@Schema()
export class NasaApodAction extends OmitType(Action, ['actionType'] as const) {
  actionType: ActionTypeEnum.NASA_GET_APOD;
}

export const NasaApodActionSchema = SchemaFactory.createForClass(NasaApodAction);
