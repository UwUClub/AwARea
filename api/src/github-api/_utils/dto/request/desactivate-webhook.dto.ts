import { ApiProperty } from '@nestjs/swagger';
import { IsString } from 'class-validator';

export class DeactivateWebhookDto {
  @ApiProperty()
  @IsString()
  webhookId: string;
}
