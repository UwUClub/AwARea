import { ActionTypeEnum } from '../../enums/action-type.enum';
import { ApiProperty } from '@nestjs/swagger';
import { IsEnum, IsOptional, IsString } from 'class-validator';

export class CreateActionDto {
  @ApiProperty({ enum: ActionTypeEnum })
  @IsEnum(ActionTypeEnum)
  actionType: ActionTypeEnum;

  @IsString()
  @IsOptional()
  location?: string;

  @IsString()
  @IsOptional()
  githubRepoName?: string;

  @IsString()
  @IsOptional()
  date?: Date;
}
