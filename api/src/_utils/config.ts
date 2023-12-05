import { IsString, validateSync } from "class-validator";
import { plainToInstance } from 'class-transformer';
import { Logger } from '@nestjs/common';
import { exit } from 'process';

export class EnvironementVariables {
    @IsString()
    JWT_SECRET: string = 'secret';
}

export function validateEnv(config: Record<string, unknown>) {
    const validatedConfig = plainToInstance(EnvironementVariables, config, {
        enableImplicitConversion: true,
    });
    const errors = validateSync(validatedConfig, { skipMissingProperties: false });

    if (errors.length) {
        new Logger(validateEnv.name).error(errors.toString());
        exit();
    }
    return validatedConfig;
}
