import { IsString } from 'class-validator';

export class GoogleLoginDto {
    @IsString()
    accessToken: string;

    @IsString()
    completeName: string;

    @IsString()
    email: string;
}
