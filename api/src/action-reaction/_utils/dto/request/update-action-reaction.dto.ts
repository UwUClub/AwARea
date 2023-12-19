import { IsOptional, IsString } from 'class-validator';
import { Optional } from '@nestjs/common';

export class UpdateActionReactionDto {
    @IsOptional()
    @IsString()
    actionId?: string;

    @IsOptional()
    @IsString()
    reactionId?: string;
}
