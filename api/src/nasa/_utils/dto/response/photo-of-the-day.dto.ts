import { Url } from 'url';

export class NasaPhoto {
  date: Date;
  explanation: string;
  hdurl: string | null;
  media_type: string;
  title: string;
  url: Url | null;
  thumbnail_url: Url | null;
}
