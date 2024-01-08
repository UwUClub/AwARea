import { ApiProperty } from '@nestjs/swagger';
import { IsEnum, IsOptional, IsString } from 'class-validator';
import { ReactionTypeEnum } from '../../enum/reaction-type.enum';

export class CreateReactionDto {
  @ApiProperty({ enum: ReactionTypeEnum })
  @IsEnum(ReactionTypeEnum)
  reactionType: ReactionTypeEnum;

  /*
   * For Gmail draft
   */
  @IsOptional()
  @IsString()
  destinationEmail?: string;

  /*
   * For Gmail draft
   */
  @IsOptional()
  @IsString()
  subject?: string;

  /*
   * For Gmail draft
   */
  @IsOptional()
  @IsString()
  body?: string;
}
