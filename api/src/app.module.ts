import { Module } from '@nestjs/common';
import { UsersModule } from './users/users.module';
import { MongooseModule } from '@nestjs/mongoose';
import { AuthModule } from './auth/auth.module';
import { ScheduleModule } from '@nestjs/schedule';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { EnvironmentVariables, validateEnv } from './_utils/config';
import { WeatherModule } from './weather/weather.module';
import { NasaModule } from './nasa/nasa.module';
import { AboutModule } from './about/about.module';
import { ActionReactionModule } from './action-reaction/action-reaction.module';
import { ActionsModule } from './actions/actions.module';
import { ReactionsModule } from './reactions/reactions.module';
import { GoogleApiModule } from './google-api/google-api.module';
import { SlackModule } from './slack/slack.module';
import { GithubApiModule } from './github-api/github-api.module';

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
        ActionReactionModule,
        ActionsModule,
        ReactionsModule,
        GoogleApiModule,
        SlackModule,
        GithubApiModule,
    ],
})
export class AppModule { }
