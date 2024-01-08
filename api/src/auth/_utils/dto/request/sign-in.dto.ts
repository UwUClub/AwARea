import { ApiProperty } from '@nestjs/swagger';
import { IsString } from 'class-validator';

export class SignInDto {
  @IsString()
  @ApiProperty({ example: 'moi' })
  usernameOrEmail: string;

  @IsString()
  @ApiProperty({ example: 'Test1234**' })
  password: string;
}
