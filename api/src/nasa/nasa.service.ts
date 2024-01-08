import { HttpService } from '@nestjs/axios';
import { AxiosResponse } from 'axios';
import { NasaPhoto } from './_utils/dto/response/photo-of-the-day.dto';
import { firstValueFrom, Observable } from 'rxjs';
import { ConfigService } from '@nestjs/config';
import { EnvironmentVariables } from '../_utils/config';
import { Injectable } from '@nestjs/common';
import { NasaMapper } from './nasa.mapper';
import { ActionDocument } from '../actions/schemas/actions.schema';
import { Cron } from '@nestjs/schedule';
import { ActionReactionRepository } from '../action-reaction/action-reaction.repository';
import { ReactionsService } from '../reactions/reactions.service';

@Injectable()
export class NasaService {
  private readonly apiKey: string;
  private latestPhoto: NasaPhoto;

  constructor(
    private httpService: HttpService,
    private readonly configService: ConfigService<EnvironmentVariables, true>,
    private readonly nasaMapper: NasaMapper,
    private readonly actionReactionRepository: ActionReactionRepository,
    private readonly reactionService: ReactionsService,
  ) {
    this.apiKey = this.configService.get('NASA_API_KEY');
  }

  private getPhotoOfTheDay(): Observable<AxiosResponse<any>> {
    const url = `https://api.nasa.gov/planetary/apod?api_key=${this.apiKey}&thumbs=true`;
    return this.httpService.get(url);
  }

  async fetchPhotoOfTheDay(action: ActionDocument) {
    try {
      if (this.latestPhoto) {
        const today = new Date();
        if (today.getDate() === this.latestPhoto.date.getDate()) {
          return { photo: this.latestPhoto, hasChanged: false };
        }
      }
      const request = this.getPhotoOfTheDay();
      const photo = await firstValueFrom(request);
      this.latestPhoto = this.nasaMapper.toNasaPhotoDto(photo.data);
      return { photo: this.latestPhoto, hasChanged: true };
    } catch (error) {
      throw new Error(error);
    }
  }

  @Cron('0 * * * *')
  async fetchPhotoOfTheDayCron() {
    const photo = await this.fetchPhotoOfTheDay(null);
    if (!photo.hasChanged) return;
    const actions = await this.actionReactionRepository.getActionReactionByFilter({
      'action.actionType': 'NASA_GET_APOD',
    });
    for (const action of actions) {
      const user = action.user;
      await this.reactionService.executeReaction(user, action.reaction, photo).catch((err) => console.log(err));
    }
  }
}
