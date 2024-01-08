import { BadRequestException, Injectable } from '@nestjs/common';
import { WeatherService } from '../weather/weather.service';
import { NasaService } from '../nasa/nasa.service';
import { NasaPhoto } from 'src/nasa/_utils/dto/response/photo-of-the-day.dto';
import { ActionDocumentType } from './schemas/actions.schema';
import { UserDocument } from '../users/users.schema';
import { CreateActionDto } from './_utils/dto/request/create-action.dto';
import { ActionsRepository } from './actions.repository';
import { ActionTypeEnum } from './_utils/enums/action-type.enum';

@Injectable()
export class ActionsService {
  private readonly actions: {
    NASA_GET_APOD: (action: ActionDocumentType) => Promise<{ photo: NasaPhoto; hasChanged: boolean }>;
    WEATHER_GET_CURRENT: (action: ActionDocumentType) => Promise<any>;
  };

  private readonly bodyNeeded: Map<ActionTypeEnum, string[]>;

  constructor(
    private readonly weatherService: WeatherService,
    private readonly nasaService: NasaService,
    private readonly actionsRepository: ActionsRepository,
  ) {
    this.actions = {
      NASA_GET_APOD: async (action: ActionDocumentType) => {
        return await this.nasaService.fetchPhotoOfTheDay(action);
      },
      WEATHER_GET_CURRENT: async (action: ActionDocumentType) => {
        return await this.weatherService.getWeather(action);
      },
    };
    this.bodyNeeded = new Map([
      [ActionTypeEnum.NASA_GET_APOD, []],
      [ActionTypeEnum.WEATHER_GET_CURRENT, ['location']],
    ]);
    for (const key in ActionTypeEnum) {
      if (!this.bodyNeeded.has(ActionTypeEnum[key])) this.bodyNeeded.set(ActionTypeEnum[key], ['githubRepoName']);
    }
  }

  async executeAction(action: ActionDocumentType) {
    return this.actions[action.actionType](action);
  }

  createAction(user: UserDocument, data: CreateActionDto) {
    if (this.bodyNeeded.get(data.actionType).some((key) => !data[key])) {
      throw new BadRequestException(
        `You need to provide ${this.bodyNeeded[data.actionType].join(', ')} to create this action`,
      );
    }
    switch (data.actionType) {
      case 'NASA_GET_APOD':
        return this.actionsRepository.createNasaAction();
      case 'WEATHER_GET_CURRENT':
        return this.actionsRepository.createWeatherAction(data.location);
      default:
        return this.actionsRepository.createGithubAction(data.githubRepoName, data.actionType);
    }
  }
}
