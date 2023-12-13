import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService, TasksService } from './app.service';
import { UsersModule } from './users/users.module';
import { MongooseModule } from '@nestjs/mongoose';
import { AuthModule } from './auth/auth.module';
import { ScheduleModule } from '@nestjs/schedule';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { EnvironementVariables, validateEnv } from './_utils/config';

@Module({
    imports: [
        ScheduleModule.forRoot(),
        MongooseModule.forRootAsync({
            useFactory: async (
                configService: ConfigService<EnvironementVariables, true>,
            ) => ({
                uri: configService.get('MONGO_URI'),
            }),
            inject: [ConfigService],
        }),
        UsersModule,
        AuthModule,
        ConfigModule.forRoot({ validate: validateEnv, isGlobal: true }),
    ],
    controllers: [AppController],
    providers: [AppService, TasksService],
})
export class AppModule {}
