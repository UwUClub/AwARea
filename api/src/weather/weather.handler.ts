import { HttpService } from '@nestjs/axios';
import { firstValueFrom } from 'rxjs';

export class WeatherHandler {
    private apiKey: string;

    constructor(private httpService: HttpService) {
        this.apiKey = process.env.METEO_KEY;
    }

    private async getWeather(city: string): Promise<any> {
        const url = `https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${this.apiKey}&units=metric&lang=fr`;

        try {
            const response = await firstValueFrom(this.httpService.get(url))
                .then((res) => res.data)
                .catch((err) => {
                    throw new Error(err);
                });
            return response;
        } catch (error) {
            throw new Error(error);
        }
    }
}
