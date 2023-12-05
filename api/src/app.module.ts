import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService, TasksService } from './app.service';
import { MongooseModule } from '@nestjs/mongoose';
import { ScheduleModule } from '@nestjs/schedule';

@Module({
    imports: [
        ScheduleModule.forRoot(),
        MongooseModule.forRoot('mongodb://localhost/awarea'),
    ],
    controllers: [AppController],
    providers: [AppService, TasksService],
})
export class AppModule {}
