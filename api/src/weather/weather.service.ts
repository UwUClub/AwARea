import { HttpService } from '@nestjs/axios';
import { ConfigService } from '@nestjs/config';
import { firstValueFrom } from 'rxjs';
import { EnvironmentVariables } from 'src/_utils/config';
import { Injectable, InternalServerErrorException } from '@nestjs/common';
import { ActionDocument, ActionDocumentType } from '../actions/schemas/actions.schema';
import { WeatherActionDocument } from '../actions/schemas/weather-action.schema';
import { Cron } from '@nestjs/schedule';
import { ActionReactionRepository } from '../action-reaction/action-reaction.repository';
import { createInterface } from './_utils/create-interface.function';
import { ReactionsService } from '../reactions/reactions.service';

@Injectable()
export class WeatherService {
  private readonly apiKey: string;

  constructor(
    private httpService: HttpService,
    private readonly configService: ConfigService<EnvironmentVariables, true>,
    private readonly actionReactionRepository: ActionReactionRepository,
    private readonly reactionService: ReactionsService,
  ) {
    this.apiKey = configService.get('WEATHER_KEY');
  }

  async getWeather(action: ActionDocumentType): Promise<any> {
    if (action.actionType !== 'WEATHER_GET_CURRENT')
      throw new InternalServerErrorException('Action is not a weather action');
    const url = `https://api.openweathermap.org/data/2.5/weather?q=${action.city}&appid=${this.apiKey}&units=metric&lang=fr`;

    try {
      return await firstValueFrom(this.httpService.get(url))
        .then((res) => res.data)
        .catch((err) => {
          throw new Error(err);
        });
    } catch (error) {
      throw new Error(error);
    }
  }

  @Cron('0 * * * *')
  async onWeatherChange() {
    const actionsReactions = await this.actionReactionRepository.getActionReactionByFilter({
      'action.actionType': 'WEATHER_GET_CURRENT',
    });
    for (const actionReaction of actionsReactions) {
      const weather = createInterface(await this.getWeather(actionReaction.action));
      await this.reactionService
        .executeReaction(actionReaction.user, actionReaction.reaction, weather)
        .catch((err) => console.log(err));
    }
  }
}
