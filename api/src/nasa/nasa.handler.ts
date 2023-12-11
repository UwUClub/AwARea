import { HttpService } from '@nestjs/axios';
import { AxiosResponse } from 'axios';
import { Observable, firstValueFrom } from 'rxjs';

export class NasaHandler {
    private apiKey: string;
    private latestPhoto: any;

    constructor(private httpService: HttpService) {
        this.apiKey = process.env.NASA_API_KEY;
    }

    private getPhotoOfTheDay(): Observable<AxiosResponse<any>> {
        const url = `https://api.nasa.gov/planetary/apod?api_key=${this.apiKey}&thumbs=true`;
        return this.httpService.get(url);
    }

    public async fetchPhotoOfTheDay() {
        try {
            if (this.latestPhoto) {
                const today = new Date();
                const latestPhotoDate = new Date(this.latestPhoto.date);
                if (today.getDate() === latestPhotoDate.getDate()) {
                    return this.latestPhoto;
                }
            }
            const response = await firstValueFrom(this.getPhotoOfTheDay())
                .then((res) => res.data)
                .catch((err) => {
                    throw new Error(err);
                });
            this.latestPhoto = response;
            return response;
        } catch (error) {
            throw new Error(error);
        }
    }
}
