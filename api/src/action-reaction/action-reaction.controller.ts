import { Body, Controller, Get, Param, Patch, Post } from '@nestjs/common';
import { ActionReactionService } from './action-reaction.service';
import { Protect } from '../auth/_utils/decorators/protect.decorator';
import { ConnectedUser } from '../auth/_utils/decorators/connected-user.decorator';
import { UserDocument } from '../users/users.schema';
import { CreateActionReactionDto } from './_utils/dto/request/create-action-reaction.dto';
import { ApiTags } from '@nestjs/swagger';
import { UpdateActionReactionDto } from './_utils/dto/request/update-action-reaction.dto';
import { CreateMvpActionReactionDto } from './_utils/dto/request/create-mvp-action-reaction.dto';

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
    @Post('mvp')
    createMvpActionReaction(
        @ConnectedUser() user: UserDocument,
        @Body() body: CreateMvpActionReactionDto,
    ) {
        return this.actionReactionService.createMvpActionReaction(user, body);
    }

    @Protect()
    @Get(':action_reaction_id')
    getActionReaction(
        @Param('action_reaction_id') id: string,
        @ConnectedUser() user: UserDocument,
    ) {
        return this.actionReactionService.getActionReactionById(id, user);
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
