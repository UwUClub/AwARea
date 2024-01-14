import { applyDecorators } from '@nestjs/common';
import { ApiProperty } from '@nestjs/swagger';
import { IsStrongPassword } from 'class-validator';

export function IsSecurePassword() {
  return applyDecorators(
    ApiProperty({
      example: 'Test1234**',
      description: 'Minimum ten characters, at least one letter, two numbers and one special character.',
    }),
    IsStrongPassword({
      minLowercase: 1,
      minLength: 10,
      minNumbers: 2,
      minUppercase: 1,
      minSymbols: 1,
    }),
  );
}
