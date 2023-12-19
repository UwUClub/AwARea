import { Module } from '@nestjs/common';
import { ReactionsService } from './reactions.service';
import { ReactionsController } from './reactions.controller';
import { MongooseModule } from '@nestjs/mongoose';
import { Reaction, ReactionSchema } from './schemas/reactions.schema';
import { ReactionTypeEnum } from './_utils/enum/reaction-type.enum';
import { CreateDraftSchema } from './schemas/create-draft.schema';
import { ReactionRepository } from './reaction.repository';

@Module({
    imports: [
        MongooseModule.forFeature([
            {
                name: Reaction.name,
                schema: ReactionSchema,
                discriminators: [
                    {
                        name: ReactionTypeEnum.CREATE_DRAFT,
                        schema: CreateDraftSchema,
                    },
                ],
            },
        ]),
    ],
    controllers: [ReactionsController],
    providers: [ReactionsService, ReactionRepository],
    exports: [ReactionRepository],
})
export class ReactionsModule {}
