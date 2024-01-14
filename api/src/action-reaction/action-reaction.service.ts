import { BadRequestException, ConflictException, Injectable, InternalServerErrorException } from '@nestjs/common';
import { UserDocument } from '../users/users.schema';
import { CreateActionReactionDto } from './_utils/dto/request/create-action-reaction.dto';
import { ActionReactionRepository } from './action-reaction.repository';
import { ActionReactionMapper } from './action-reaction.mapper';
import { Types } from 'mongoose';
import { UpdateActionReactionDto } from './_utils/dto/request/update-action-reaction.dto';
import { ActionsRepository } from '../actions/actions.repository';
import { ReactionRepository } from '../reactions/reaction.repository';
import { ActionReactionDocument } from './action-reaction.schema';
import { CreateActionDto } from '../actions/_utils/dto/request/create-action.dto';
import { ActionsService } from '../actions/actions.service';
import { ReactionsService } from '../reactions/reactions.service';
import { CreateReactionDto } from '../reactions/_utils/dto/request/create-reaction.dto';
import { GithubApiDocument } from '../actions/schemas/github-api.schema';
import { WebhookService } from '../github-api/services/webhook.service';
import { TimerService } from '../timer/timer.service';
import { ActionDocumentType } from '../actions/schemas/actions.schema';

@Injectable()
export class ActionReactionService {
  constructor(
    private readonly actionReactionRepository: ActionReactionRepository,
    private readonly actionReactionMapper: ActionReactionMapper,
    private readonly actionRepository: ActionsRepository,
    private readonly actionService: ActionsService,
    private readonly reactionRepository: ReactionRepository,
    private readonly reactionService: ReactionsService,
    private readonly webhookService: WebhookService,
    private readonly timerService: TimerService,
  ) {}

  async getActionReactions(user: UserDocument) {
    const actionReactions = await this.actionReactionRepository.getActionReactions(user._id);

    return actionReactions.map((actionReaction) => this.actionReactionMapper.toGetActionReactionDto(actionReaction));
  }

  async getActionReactionById(actionReactionId: string, user: UserDocument) {
    const actionReaction = await this.actionReactionRepository.getActionReactionById(
      new Types.ObjectId(actionReactionId),
      user._id,
    );
    if (!actionReaction) throw new BadRequestException('Action reaction does not exist');

    return this.actionReactionMapper.toGetActionReactionDto(actionReaction);
  }

  async createActionReaction(user: UserDocument, queryDto: CreateActionReactionDto) {
    let actionReaction = await this.actionReactionRepository.getActionReactionByName(queryDto.name);

    if (actionReaction) throw new ConflictException('Action reaction already exists');
    actionReaction = await this.actionReactionRepository.createActionReaction(user, queryDto);

    return this.actionReactionMapper.toGetActionReactionDto(actionReaction);
  }

  async createAction(user: UserDocument, queryDto: CreateActionDto, actionReaction: ActionReactionDocument) {
    if (actionReaction.user._id.toString() !== user._id.toString())
      throw new BadRequestException('You are not the owner of this action reaction');
    const action = await this.actionService.createAction(user, queryDto);
    if (actionReaction.action !== null) await this.actionRepository.removeActionById(actionReaction.action._id);
    await this.actionReactionRepository.updateActionReaction(actionReaction._id, action, null, null);
    return this.actionReactionMapper.toGetActionReactionDto(actionReaction);
  }

  async createReaction(user: UserDocument, queryDto: CreateReactionDto, actionReaction: ActionReactionDocument) {
    if (actionReaction.user._id.toString() !== user._id.toString())
      throw new BadRequestException('You are not the owner of this action reaction');
    const reaction = await this.reactionService.createReaction(user, queryDto);
    if (actionReaction.reaction !== null) await this.reactionRepository.removeReactionById(actionReaction.reaction._id);
    actionReaction = await this.actionReactionRepository.updateActionReaction(actionReaction._id, null, reaction, null);
    return this.actionReactionMapper.toGetActionReactionDto(actionReaction);
  }

  async updateActionReaction(user: UserDocument, actionId: string, queryDto: UpdateActionReactionDto) {
    let actionReaction = await this.actionReactionRepository.getActionReactionById(
      new Types.ObjectId(actionId),
      user._id,
    );

    if (!actionReaction) throw new BadRequestException('Action reaction does not exist');

    actionReaction = await this.actionReactionRepository.updateActionReaction(
      actionReaction._id,
      null,
      null,
      queryDto.isActivated,
    );
    if (actionReaction.action instanceof Types.ObjectId)
      throw new InternalServerErrorException('Action is not populated');

    if (
      actionReaction.action.actionType !== 'NASA_GET_APOD' &&
      actionReaction.action.actionType !== 'WEATHER_GET_CURRENT' &&
      actionReaction.action.actionType !== 'TIMER' &&
      queryDto.isActivated
    ) {
      try {
        const githubAction = actionReaction.action as GithubApiDocument;
        await this.webhookService.createWebhook(user, githubAction.repoName);
      } catch (e) {
        throw new BadRequestException(e.message);
      }
    }
    if (actionReaction.action.actionType === 'TIMER' && queryDto.isActivated) {
      await this.timerService.waitForThisDate(actionReaction.action as ActionDocumentType);
    }

    return this.actionReactionMapper.toGetActionReactionDto(actionReaction);
  }

  async removeActionReaction(actionReactionId: string, user: UserDocument) {
    const actionReaction = await this.actionReactionRepository.getActionReactionById(
      new Types.ObjectId(actionReactionId),
      user._id,
    );
    if (!actionReaction) throw new BadRequestException('Action reaction does not exist');
    if (actionReaction.action) await this.actionRepository.removeActionById(actionReaction.action._id);
    if (actionReaction.reaction) await this.reactionRepository.removeReactionById(actionReaction.reaction._id);
    await this.actionReactionRepository.removeActionReactionById(actionReaction._id, user);
    return { message: 'Action reaction successfully deleted' };
  }
}
