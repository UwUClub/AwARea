import { Injectable } from '@nestjs/common';
import { NasaPhoto } from './_utils/dto/response/photo-of-the-day.dto';

@Injectable()
export class NasaMapper {
    constructor() {}

    toNasaPhotoDto(nasaPhoto): NasaPhoto {
        return {
            date: new Date(nasaPhoto.date),
            explanation: nasaPhoto.explanation,
            hdurl: nasaPhoto.hdurl ? nasaPhoto.hdurl : null,
            media_type: nasaPhoto.media_type,
            title: nasaPhoto.title,
            url: nasaPhoto.url ? nasaPhoto.url : null,
            thumbnail_url: nasaPhoto.thumbnail_url
                ? nasaPhoto.thumbnail_url
                : null,
        };
    }
}
