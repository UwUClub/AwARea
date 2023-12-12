import { Url } from 'url';

export interface NasaPhoto {
    date: Date;
    explanation: string;
    hdurl: string;
    media_type: string;
    service_version: string;
    title: string;
    url: Url;
    thumbnail_url: Url;
}
