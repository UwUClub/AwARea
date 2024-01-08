import { IsBoolean, IsOptional, IsString } from 'class-validator';

export class UpdateActionReactionDto {
  @IsOptional()
  @IsString()
  actionId?: string;

  @IsOptional()
  @IsString()
  reactionId?: string;

  @IsOptional()
  @IsBoolean()
  isActivated?: boolean;
}
