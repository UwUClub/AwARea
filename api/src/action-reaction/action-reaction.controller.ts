import {
    Body,
    Controller,
    Get,
    NotImplementedException,
    Param,
    Patch,
    Post,
} from '@nestjs/common';
import { ActionReactionService } from './action-reaction.service';
import { Protect } from '../auth/_utils/decorators/protect.decorator';
import { ConnectedUser } from '../auth/_utils/decorators/connected-user.decorator';
import { UserDocument } from '../users/users.schema';
import { CreateActionReactionDto } from './_utils/dto/request/create-action-reaction.dto';
import { ApiParam, ApiTags } from '@nestjs/swagger';
import { UpdateActionReactionDto } from './_utils/dto/request/update-action-reaction.dto';
import { CreateMvpActionReactionDto } from './_utils/dto/request/create-mvp-action-reaction.dto';
import { CreateActionDto } from '../actions/_utils/dto/request/create-action.dto';
import { ActionsService } from '../actions/actions.service';
import { GetActionReaction } from './_utils/pipes/get-action-reaction.pipe';
import { ActionReactionDocument } from './action-reaction.schema';
import { CreateReactionDto } from '../reactions/_utils/dto/request/create-reaction.dto';

@ApiTags('Action Reaction')
@Controller('action-reaction')
export class ActionReactionController {
    constructor(
        private readonly actionReactionService: ActionReactionService,
    ) {}

    @Protect()
    @Get()
    getActionReactions(@ConnectedUser() user: UserDocument) {
        return this.actionReactionService.getActionReactions(user);
    }

    @Protect()
    @Post()
    createActionReaction(
        @ConnectedUser() user: UserDocument,
        @Body() body: CreateActionReactionDto,
    ) {
        return this.actionReactionService.createActionReaction(user, body);
    }

    @Protect()
    @Get(':action_reaction_id')
    @ApiParam({ name: 'action_reaction_id', type: String })
    getActionReaction(
        @Param('action_reaction_id') id: string,
        @ConnectedUser() user: UserDocument,
    ) {
        return this.actionReactionService.getActionReactionById(id, user);
    }

    @Protect()
    @Post(':action_reaction_id/action')
    @ApiParam({ name: 'action_reaction_id', type: String })
    createAction(
        @Param('action_reaction_id', GetActionReaction)
        actionReaction: ActionReactionDocument,
        @ConnectedUser() user: UserDocument,
        @Body() body: CreateActionDto,
    ) {
        return this.actionReactionService.createAction(
            user,
            body,
            actionReaction,
        );
    }

    @Protect()
    @Post(':action_reaction_id/reaction')
    @ApiParam({ name: 'action_reaction_id', type: String })
    createReaction(
        @Param('action_reaction_id', GetActionReaction)
        actionReaction: ActionReactionDocument,
        @ConnectedUser() user: UserDocument,
        @Body() body: CreateReactionDto,
    ) {
        return this.actionReactionService.createReaction(
            user,
            body,
            actionReaction,
        );
    }

    @Protect()
    @Patch(':action_reaction_id')
    updateActionReaction(
        @Param('action_reaction_id') id: string,
        @Body() body: UpdateActionReactionDto,
        @ConnectedUser() user: UserDocument,
    ) {
        return this.actionReactionService.updateActionReaction(user, id, body);
    }
}
