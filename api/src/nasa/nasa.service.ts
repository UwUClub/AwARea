import { HttpService } from '@nestjs/axios';
import { AxiosResponse } from 'axios';
import { NasaPhoto } from './_utils/dto/response/photo-of-the-day.dto';
import { firstValueFrom, Observable } from 'rxjs';
import { ConfigService } from '@nestjs/config';
import { EnvironmentVariables } from '../_utils/config';
import { Injectable } from '@nestjs/common';
import { NasaMapper } from './nasa.mapper';

@Injectable()
export class NasaService {
    private readonly apiKey: string;
    private latestPhoto: NasaPhoto;

    constructor(
        private httpService: HttpService,
        private readonly configService: ConfigService<
            EnvironmentVariables,
            true
        >,
        private readonly nasaMapper: NasaMapper,
    ) {
        this.apiKey = this.configService.get('NASA_API_KEY');
    }

    private getPhotoOfTheDay(): Observable<AxiosResponse<any>> {
        const url = `https://api.nasa.gov/planetary/apod?api_key=${this.apiKey}&thumbs=true`;
        return this.httpService.get(url);
    }

    async fetchPhotoOfTheDay() {
        try {
            if (this.latestPhoto) {
                const today = new Date();
                if (today.getDate() === this.latestPhoto.date.getDate()) {
                    return this.latestPhoto;
                }
            }
            const request = this.getPhotoOfTheDay();
            const photo = await firstValueFrom(request);
            this.latestPhoto = this.nasaMapper.toNasaPhotoDto(photo.data);
            return this.latestPhoto;
        } catch (error) {
            throw new Error(error);
        }
    }
}
