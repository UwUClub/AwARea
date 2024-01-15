import { IsEmail, IsNotEmpty, IsString } from 'class-validator';
import { IsSecurePassword } from '../../../../_utils/decorators/is-secure-password.decorator';
import { ApiProperty } from '@nestjs/swagger';

export class CreateUserDto {
  @IsString()
  @IsNotEmpty()
  username: string;

  @IsString()
  @IsNotEmpty()
  fullName: string;

  @ApiProperty({ example: 'email@person.com' })
  @IsEmail()
  @IsNotEmpty()
  email: string;

  @IsSecurePassword()
  password: string;
}
