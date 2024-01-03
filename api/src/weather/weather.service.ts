import { HttpService } from '@nestjs/axios';
import { ConfigService } from '@nestjs/config';
import { firstValueFrom } from 'rxjs';
import { EnvironmentVariables } from 'src/_utils/config';
import { Injectable, InternalServerErrorException } from '@nestjs/common';
import {
    ActionDocument,
    ActionDocumentType,
} from '../actions/schemas/actions.schema';
import { WeatherActionDocument } from '../actions/schemas/weather-action.schema';

@Injectable()
export class WeatherService {
    private readonly apiKey: string;

    constructor(
        private httpService: HttpService,
        private readonly configService: ConfigService<
            EnvironmentVariables,
            true
        >,
    ) {
        this.apiKey = configService.get('WEATHER_KEY');
    }

    async getWeather(action: ActionDocumentType): Promise<any> {
        if (action.actionType !== 'WEATHER_GET_CURRENT')
            throw new InternalServerErrorException(
                'Action is not a weather action',
            );
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
}
