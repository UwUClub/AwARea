import { IsEmail, IsString } from 'class-validator';

export class CreateMvpActionReactionDto {
    @IsString()
    name: string;

    @IsEmail()
    email: string;
}
