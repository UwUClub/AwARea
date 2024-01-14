import { IsString } from 'class-validator';

export class UpdateGoogleTokenDto {
  @IsString()
  googleToken: string;
}
