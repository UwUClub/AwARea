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
import { GithubApiSchema } from './schemas/github-api.schema';
import { TimerModule } from '../timer/timer.module';
import { TimerActionSchema } from './schemas/timer.schema';

@Module({
  imports: [
    MongooseModule.forFeature([
      {
        name: Action.name,
        schema: ActionSchema,
        discriminators: Object.entries({
          [ActionTypeEnum.TIMER]: TimerActionSchema,
          [ActionTypeEnum.NASA_GET_APOD]: NasaApodActionSchema,
          [ActionTypeEnum.WEATHER_GET_CURRENT]: WeatherActionSchema,
          [ActionTypeEnum.BRANCH_CREATED]: GithubApiSchema,
          [ActionTypeEnum.BRANCH_DELETED]: GithubApiSchema,
          [ActionTypeEnum.BRANCH_MERGED]: GithubApiSchema,
          [ActionTypeEnum.ISSUE_OPENED]: GithubApiSchema,
          [ActionTypeEnum.PULL_REQUEST_CREATED]: GithubApiSchema,
          [ActionTypeEnum.PULL_REQUEST_REVIEW_REQUEST_REMOVED]: GithubApiSchema,
          [ActionTypeEnum.PULL_REQUEST_REVIEW_REQUESTED]: GithubApiSchema,
          [ActionTypeEnum.STAR_ADDED]: GithubApiSchema,
          [ActionTypeEnum.STAR_REMOVED]: GithubApiSchema,
        }).map(([name, schema]) => ({
          name,
          schema,
        })),
      },
    ]),
    WeatherModule,
    NasaModule,
    TimerModule,
  ],
  controllers: [ActionsController],
  providers: [ActionsService, ActionsRepository],
  exports: [ActionsRepository, ActionsService],
})
export class ActionsModule {}
