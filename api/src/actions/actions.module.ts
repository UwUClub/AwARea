import { Module } from '@nestjs/common';
import { ActionsService } from './actions.service';
import { ActionsController } from './actions.controller';
import { MongooseModule } from '@nestjs/mongoose';
import { Action, ActionSchema } from './schemas/actions.schema';
import { ActionTypeEnum } from './_utils/enums/action-type.enum';
import { NasaApodActionSchema } from './schemas/nasa-apod-action.schema';
import { WeatherActionSchema } from './schemas/weather-action.schema';
import { ActionsRepository } from './actions.repository';

@Module({
    imports: [
        MongooseModule.forFeature([
            {
                name: Action.name,
                schema: ActionSchema,
                discriminators: [
                    {
                        name: ActionTypeEnum.NASA_GET_APOD,
                        schema: NasaApodActionSchema,
                    },
                    {
                        name: ActionTypeEnum.WEATHER_GET_CURRENT,
                        schema: WeatherActionSchema,
                    },
                ],
            },
        ]),
    ],
    controllers: [ActionsController],
    providers: [ActionsService, ActionsRepository],
    exports: [ActionsRepository],
})
export class ActionsModule {}
