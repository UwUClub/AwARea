import { IsString, validateSync } from 'class-validator';
import { plainToInstance } from 'class-transformer';
import { Logger } from '@nestjs/common';
import { exit } from 'process';

export class EnvironmentVariables {
    @IsString()
    JWT_SECRET: string = 'secret';

    @IsString()
    MONGO_URI: string = 'mongodb://mongo/awarea';

    @IsString()
    WEATHER_KEY: string = 'c4b';

    @IsString()
    NASA_API_KEY: string = 'c4b';

    @IsString()
    GITHUB_CLIENT_ID: string = 'c4b';

    @IsString()
    GITHUB_CLIENT_SECRET: string = 'c4b';

    @IsString()
    GOOGLE_CLIENT_ID: string = 'c4b';

    @IsString()
    GOOGLE_CLIENT_SECRET: string = 'c4b';

    @IsString()
    GOOGLE_CALLBACK_URL: string = 'c4b';
}

export function validateEnv(config: Record<string, unknown>) {
    const validatedConfig = plainToInstance(EnvironmentVariables, config, {
        enableImplicitConversion: true,
    });
    const errors = validateSync(validatedConfig, {
        skipMissingProperties: false,
    });

    if (errors.length) {
        new Logger(validateEnv.name).error(errors.toString());
        exit();
    }
    return validatedConfig;
}
