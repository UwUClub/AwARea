import { forwardRef, Module } from '@nestjs/common';
import { WeatherService } from './weather.service';
import { HttpModule } from '@nestjs/axios';
import { ActionReactionModule } from '../action-reaction/action-reaction.module';
import { ReactionsModule } from '../reactions/reactions.module';

@Module({
    imports: [
        HttpModule,
        forwardRef(() => ActionReactionModule),
        ReactionsModule,
    ],
    providers: [WeatherService],
    exports: [WeatherService],
})
export class WeatherModule {}
