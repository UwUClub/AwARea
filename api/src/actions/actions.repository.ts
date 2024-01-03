import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { ActionTypeEnum } from './_utils/enums/action-type.enum';
import { Model, Types } from 'mongoose';
import { NasaApodAction } from './schemas/nasa-apod-action.schema';
import { WeatherAction } from './schemas/weather-action.schema';
import { Action } from './schemas/actions.schema';

@Injectable()
export class ActionsRepository {
    constructor(
        @InjectModel(Action.name) private actionModel: Model<Action>,
        @InjectModel(ActionTypeEnum.NASA_GET_APOD)
        private nasaModel: Model<NasaApodAction>,
        @InjectModel(ActionTypeEnum.WEATHER_GET_CURRENT)
        private weatherModel: Model<WeatherAction>,
    ) {}

    createNasaAction = () =>
        this.nasaModel.create({
            actionType: ActionTypeEnum.NASA_GET_APOD,
        });

    createWeatherAction = (city: string) =>
        this.weatherModel.create({ city: city });

    getActionById = (id: Types.ObjectId) =>
        this.actionModel
            .findById(id)
            .orFail(new Error('Action not found'))
            .exec();
}
