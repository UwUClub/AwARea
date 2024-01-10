import { BadRequestException, Injectable } from '@nestjs/common';
import { UserDocument } from '../users/users.schema';
import { CreateActionDto } from './_utils/dto/request/create-action.dto';
import { ActionsRepository } from './actions.repository';
import { ActionTypeEnum } from './_utils/enums/action-type.enum';

@Injectable()
export class ActionsService {
  private readonly bodyNeeded: Map<ActionTypeEnum, string[]>;

  constructor(private readonly actionsRepository: ActionsRepository) {
    this.bodyNeeded = new Map([
      [ActionTypeEnum.NASA_GET_APOD, []],
      [ActionTypeEnum.WEATHER_GET_CURRENT, ['location']],
      [ActionTypeEnum.TIMER, ['date']],
    ]);
    for (const key in ActionTypeEnum) {
      if (!this.bodyNeeded.has(ActionTypeEnum[key])) this.bodyNeeded.set(ActionTypeEnum[key], ['githubRepoName']);
    }
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
      case 'TIMER':
        return this.actionsRepository.createTimerAction(data.date);
      default:
        return this.actionsRepository.createGithubAction(data.githubRepoName, data.actionType);
    }
  }
}
