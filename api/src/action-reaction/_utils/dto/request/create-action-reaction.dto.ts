import { IsString } from 'class-validator';

export class CreateActionReactionDto {
  @IsString()
  name: string;
}
