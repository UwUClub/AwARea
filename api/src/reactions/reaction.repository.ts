import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { ReactionTypeEnum } from './_utils/enum/reaction-type.enum';
import { Model } from 'mongoose';
import { CreateDraft } from './schemas/create-draft.schema';
import { Reaction } from './schemas/reactions.schema';

@Injectable()
export class ReactionRepository {
    constructor(
        @InjectModel(Reaction.name) private reactionModel: Model<Reaction>,
        @InjectModel(ReactionTypeEnum.CREATE_DRAFT)
        private createDraftModel: Model<CreateDraft>,
    ) {}

    createDraft = (email: string) =>
        this.createDraftModel.create({
            email: email,
            reactionType: ReactionTypeEnum.CREATE_DRAFT,
        });

    getReactionById = (id: string) =>
        this.reactionModel
            .findById(id)
            .orFail(new NotFoundException('Reaction not found'))
            .exec();
}
