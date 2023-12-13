import { HttpService } from '@nestjs/axios';
import { ConfigService } from '@nestjs/config';
import { firstValueFrom } from 'rxjs';
import { EnvironmentVariables } from 'src/_utils/config';
import { Injectable } from '@nestjs/common';

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

    private async getWeather(city: string): Promise<any> {
        const url = `https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${this.apiKey}&units=metric&lang=fr`;

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
