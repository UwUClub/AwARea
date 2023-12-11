import { HttpService } from '@nestjs/axios';
import { AxiosResponse } from 'axios';
import { NasaPhoto } from './_utils/dto/photoOfTheDay.dto';
import { Observable, firstValueFrom } from 'rxjs';

export class NasaHandler {
    private apiKey: string;
    private latestPhoto: NasaPhoto;

    constructor(private httpService: HttpService) {
        this.apiKey = process.env.NASA_API_KEY;
    }

    private getPhotoOfTheDay(): Observable<AxiosResponse<any>> {
        const url = `https://api.nasa.gov/planetary/apod?api_key=${this.apiKey}&thumbs=true`;
        return this.httpService.get(url);
    }

    public async fetchPhotoOfTheDay(): Promise<NasaPhoto> {
        try {
            if (this.latestPhoto) {
                const today = new Date();
                if (today.getDate() === this.latestPhoto.date.getDate()) {
                    return this.latestPhoto;
                }
            }
            const response = await firstValueFrom(this.getPhotoOfTheDay())
                .then((res) => res.data)
                .catch((err) => {
                    throw new Error(err);
                });
            this.latestPhoto = response;
            this.latestPhoto.date = new Date(this.latestPhoto.date);
            return this.latestPhoto;
        } catch (error) {
            throw new Error(error);
        }
    }
}
