import { Module } from '@nestjs/common';
import { ActionReactionService } from './action-reaction.service';
import { ActionReactionController } from './action-reaction.controller';
import { MongooseModule } from '@nestjs/mongoose';
import { ActionReaction, ActionReactionSchema } from './action-reaction.schema';
import { ActionReactionRepository } from './action-reaction.repository';
import { ActionReactionMapper } from './action-reaction.mapper';
import { ActionsModule } from '../actions/actions.module';
import { ReactionsModule } from '../reactions/reactions.module';
import { WeatherModule } from '../weather/weather.module';
import { GoogleApiModule } from '../google-api/google-api.module';

@Module({
    imports: [
        MongooseModule.forFeature([
            { name: ActionReaction.name, schema: ActionReactionSchema },
        ]),
        ActionsModule,
        ReactionsModule,
        WeatherModule,
        GoogleApiModule,
    ],
    controllers: [ActionReactionController],
    providers: [
        ActionReactionService,
        ActionReactionRepository,
        ActionReactionMapper,
    ],
})
export class ActionReactionModule {}
