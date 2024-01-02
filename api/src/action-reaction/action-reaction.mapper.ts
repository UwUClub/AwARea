import { Injectable } from '@nestjs/common';
import { ActionReactionDocument } from './action-reaction.schema';
import { GetActionReactionDto } from './_utils/dto/response/get-action-reaction.dto';

@Injectable()
export class ActionReactionMapper {
    toGetActionReactionDto = (
        actionReaction: ActionReactionDocument,
    ): GetActionReactionDto => ({
        id: actionReaction._id.toString(),
        name: actionReaction.actionReactionName,
        action: actionReaction.action,
        reaction: actionReaction.reaction,
    });
}
