import { Module } from '@nestjs/common';
import { TasksService } from './task.service';
import { UsersModule } from './users/users.module';
import { MongooseModule } from '@nestjs/mongoose';
import { AuthModule } from './auth/auth.module';
import { ScheduleModule } from '@nestjs/schedule';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { EnvironmentVariables, validateEnv } from './_utils/config';
import { WeatherModule } from './weather/weather.module';
import { NasaModule } from './nasa/nasa.module';
import { AboutModule } from './about/about.module';

@Module({
    imports: [
        ScheduleModule.forRoot(),
        MongooseModule.forRootAsync({
            useFactory: async (
                configService: ConfigService<EnvironmentVariables, true>,
            ) => ({
                uri: configService.get('MONGO_URI'),
            }),
            inject: [ConfigService],
        }),
        UsersModule,
        AuthModule,
        ConfigModule.forRoot({ validate: validateEnv, isGlobal: true }),
        WeatherModule,
        NasaModule,
        AboutModule,
    ],
    providers: [TasksService],
})
export class AppModule {}
