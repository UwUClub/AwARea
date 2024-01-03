import { Module } from '@nestjs/common';
import { ActionsService } from './actions.service';
import { ActionsController } from './actions.controller';
import { MongooseModule } from '@nestjs/mongoose';
import { Action, ActionSchema } from './schemas/actions.schema';
import { ActionTypeEnum } from './_utils/enums/action-type.enum';
import { NasaApodActionSchema } from './schemas/nasa-apod-action.schema';
import { WeatherActionSchema } from './schemas/weather-action.schema';
import { ActionsRepository } from './actions.repository';
import { WeatherModule } from '../weather/weather.module';
import { NasaModule } from '../nasa/nasa.module';

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
        WeatherModule,
        NasaModule,
    ],
    controllers: [ActionsController],
    providers: [ActionsService, ActionsRepository],
    exports: [ActionsRepository, ActionsService],
})
export class ActionsModule {}
