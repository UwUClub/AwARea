import { ApiProperty } from '@nestjs/swagger';
import { IsString } from 'class-validator';

export class SignInDto {
    @ApiProperty({ example: 'moi' })
    @IsString()
    usernameOrEmail: string;

    @IsString()
    @ApiProperty({ example: 'Test1234**' })
    password: string;
}
