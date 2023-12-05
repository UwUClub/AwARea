import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService, TasksService } from './app.service';
import { UsersModule } from './users/users.module';
import { MongooseModule } from '@nestjs/mongoose';
import { AuthModule } from './auth/auth.module';
import { ScheduleModule } from '@nestjs/schedule';

@Module({
    imports: [
        ScheduleModule.forRoot(),
        MongooseModule.forRoot('mongodb://localhost/awarea'),
        UsersModule,
        AuthModule,
    ],
    controllers: [AppController],
    providers: [AppService, TasksService],
})
export class AppModule {}
