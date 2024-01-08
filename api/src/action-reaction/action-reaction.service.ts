import {
    BadRequestException,
    ConflictException,
    Injectable,
    InternalServerErrorException,
} from '@nestjs/common';
import { UserDocument } from '../users/users.schema';
import { CreateActionReactionDto } from './_utils/dto/request/create-action-reaction.dto';
import { ActionReactionRepository } from './action-reaction.repository';
import { ActionReactionMapper } from './action-reaction.mapper';
import { Types } from 'mongoose';
import { SchedulerRegistry } from '@nestjs/schedule';
import { CronJob } from 'cron';
import { UpdateActionReactionDto } from './_utils/dto/request/update-action-reaction.dto';
import { ActionsRepository } from '../actions/actions.repository';
import { ReactionRepository } from '../reactions/reaction.repository';
import { ActionReactionDocument } from './action-reaction.schema';
import { WeatherService } from '../weather/weather.service';
import { GoogleApiService } from '../google-api/google-api.service';
import { CreateActionDto } from '../actions/_utils/dto/request/create-action.dto';
import { ActionsService } from '../actions/actions.service';
import { ReactionsService } from '../reactions/reactions.service';
import { CreateReactionDto } from '../reactions/_utils/dto/request/create-reaction.dto';

@Injectable()
export class ActionReactionService {
    constructor(
        private readonly actionReactionRepository: ActionReactionRepository,
        private readonly actionReactionMapper: ActionReactionMapper,
        private readonly actionRepository: ActionsRepository,
        private readonly actionService: ActionsService,
        private readonly reactionRepository: ReactionRepository,
        private readonly reactionService: ReactionsService,
        private schedulerRegistry: SchedulerRegistry,
    ) {}

    async getActionReactions(user: UserDocument) {
        const actionReactions =
            await this.actionReactionRepository.getActionReactions(user._id);

        return actionReactions.map((actionReaction) =>
            this.actionReactionMapper.toGetActionReactionDto(actionReaction),
        );
    }

    async getActionReactionById(actionReactionId: string, user: UserDocument) {
        const actionReaction =
            await this.actionReactionRepository.getActionReactionById(
                new Types.ObjectId(actionReactionId),
                user._id,
            );
        if (!actionReaction)
            throw new BadRequestException('Action reaction does not exist');

        return this.actionReactionMapper.toGetActionReactionDto(actionReaction);
    }

    async createActionReaction(
        user: UserDocument,
        queryDto: CreateActionReactionDto,
    ) {
        let actionReaction =
            await this.actionReactionRepository.getActionReactionByName(
                queryDto.name,
            );

        if (actionReaction)
            throw new ConflictException('Action reaction already exists');
        actionReaction =
            await this.actionReactionRepository.createActionReaction(
                user,
                queryDto,
            );

        return this.actionReactionMapper.toGetActionReactionDto(actionReaction);
    }

    async createAction(
        user: UserDocument,
        queryDto: CreateActionDto,
        actionReaction: ActionReactionDocument,
    ) {
        if (actionReaction.user._id.toString() !== user._id.toString())
            throw new BadRequestException(
                'You are not the owner of this action reaction',
            );
        const action = await this.actionService.createAction(user, queryDto);
        actionReaction =
            await this.actionReactionRepository.updateActionReaction(
                actionReaction._id,
                action,
                null,
            );
        return this.actionReactionMapper.toGetActionReactionDto(actionReaction);
    }

    async createReaction(
        user: UserDocument,
        queryDto: CreateReactionDto,
        actionReaction: ActionReactionDocument,
    ) {
        if (actionReaction.user._id.toString() !== user._id.toString())
            throw new BadRequestException(
                'You are not the owner of this action reaction',
            );
        const reaction = await this.reactionService.createReaction(
            user,
            queryDto,
        );
        actionReaction =
            await this.actionReactionRepository.updateActionReaction(
                actionReaction._id,
                null,
                reaction,
            );
        return this.actionReactionMapper.toGetActionReactionDto(actionReaction);
    }

    /* async createMvpActionReaction(
        user: UserDocument,
        queryDto: CreateActionReactionDto,
    ) {
        let actionReaction =
            await this.actionReactionRepository.createActionReaction(user, {
                name: queryDto.name,
            });
        const action =
            await this.actionRepository.createWeatherAction('Toulouse');
        const reaction = await this.reactionRepository.createDraft(
            queryDto.name,
        );
        actionReaction =
            await this.actionReactionRepository.updateActionReaction(
                actionReaction._id,
                action,
                reaction,
            );
        const newJob = new CronJob('* * * * *', async () => {
            console.log('You will see this message every second');
            await this.applyActionReactionWeatherDraft(actionReaction);
        });

        console.log('newJob', newJob);
        this.schedulerRegistry.addCronJob(
            actionReaction.actionReactionName,
            newJob,
        );
        newJob.start();
        console.log('newJob', newJob);
        return this.actionReactionMapper.toGetActionReactionDto(actionReaction);
    } */

    async updateActionReaction(
        user: UserDocument,
        actionId: string,
        queryDto: UpdateActionReactionDto,
    ) {
        let actionReaction =
            await this.actionReactionRepository.getActionReactionById(
                new Types.ObjectId(actionId),
                user._id,
            );

        if (!actionReaction)
            throw new BadRequestException('Action reaction does not exist');
        const action = queryDto.actionId
            ? await this.actionRepository.getActionById(
                  new Types.ObjectId(queryDto.actionId),
              )
            : null;

        const reaction = queryDto.reactionId
            ? await this.reactionRepository.getReactionById(
                  queryDto.reactionId,
                  user,
              )
            : null;

        actionReaction =
            await this.actionReactionRepository.updateActionReaction(
                actionReaction._id,
                action,
                reaction,
            );

        return this.actionReactionMapper.toGetActionReactionDto(actionReaction);
    }

    async addNewJob(actionReactionId: Types.ObjectId, user: UserDocument) {
        const actionReaction =
            await this.actionReactionRepository.getActionReactionById(
                actionReactionId,
                user._id,
            );

        if (!actionReaction.actionReactionSchedule)
            throw new BadRequestException(
                'Action reaction does not have a schedule',
            );

        try {
            const newJob = new CronJob(
                actionReaction.actionReactionSchedule,
                () => console.log('Hello World'),
            );

            this.schedulerRegistry.addCronJob(
                actionReaction.actionReactionName,
                newJob,
            );
            newJob.start();
        } catch (error) {
            throw new BadRequestException('Invalid schedule');
        }
        return this.actionReactionMapper.toGetActionReactionDto(actionReaction);
    }
}
