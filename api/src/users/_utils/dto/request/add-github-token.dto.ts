import { ApiProperty } from '@nestjs/swagger';

export class AddGithubTokenDto {
    @ApiProperty()
    githubToken: string;
}
