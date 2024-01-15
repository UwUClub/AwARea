import { IsString } from 'class-validator';

export class UpdateSlackBotDto {
  @IsString()
  botToken: string;
}
