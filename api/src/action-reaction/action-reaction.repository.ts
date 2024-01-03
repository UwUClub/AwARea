import {
    ConflictException,
    Injectable,
    NotFoundException,
} from '@nestjs/common';
import {
    ActionReaction,
    ActionReactionDocument,
} from './action-reaction.schema';
import { Model, Types } from 'mongoose';
import { UserDocument } from '../users/users.schema';
import { CreateActionReactionDto } from './_utils/dto/request/create-action-reaction.dto';
import { InjectModel } from '@nestjs/mongoose';
import { ActionDocument } from '../actions/schemas/actions.schema';
import { ReactionDocument } from '../reactions/schemas/reactions.schema';

@Injectable()
export class ActionReactionRepository {
    constructor(
        @InjectModel(ActionReaction.name)
        private actionReactionModel: Model<ActionReactionDocument>,
    ) {}

    createActionReaction = (
        user: UserDocument,
        queryDto: CreateActionReactionDto,
    ) =>
        this.actionReactionModel
            .create({
                user: user,
                actionReactionName: queryDto.name,
            })
            .catch((err) => {
                throw new ConflictException(err.message);
            });

    getActionReactions = (userId: Types.ObjectId) =>
        this.actionReactionModel.find({ user: userId }).exec();

    getActionReactionByName = (name: string) =>
        this.actionReactionModel.findOne({ actionReactionName: name }).exec();

    updateActionReaction = (
        id: Types.ObjectId,
        action: ActionDocument | null,
        reaction: ReactionDocument | null,
    ) =>
        this.actionReactionModel
            .findByIdAndUpdate(
                id,
                {
                    ...(action ? { action: action } : {}),
                    ...(reaction ? { reaction: reaction } : {}),
                },
                { new: true },
            )
            .populate('user')
            .exec();

    getActionReactionById = (id: Types.ObjectId, userId: Types.ObjectId) =>
        this.actionReactionModel.findOne({ _id: id, user: userId }).exec();

    getActionReactionByIdNotConnected = (id: string) =>
        this.actionReactionModel.findOne({ _id: id }).exec();
}
