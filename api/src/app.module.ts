import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService, TasksService } from './app.service';
import { ScheduleModule } from '@nestjs/schedule';

@Module({
    imports: [ScheduleModule.forRoot()],
    controllers: [AppController],
    providers: [AppService, TasksService],
})
export class AppModule {}