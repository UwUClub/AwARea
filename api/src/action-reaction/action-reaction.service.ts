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

@Injectable()
export class ActionReactionService {
    constructor(
        private readonly actionReactionRepository: ActionReactionRepository,
        private readonly actionReactionMapper: ActionReactionMapper,
        private readonly actionRepository: ActionsRepository,
        private readonly reactionRepository: ReactionRepository,
        private readonly weatherService: WeatherService,
        private readonly googleService: GoogleApiService,
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

    async createMvpActionReaction(
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
    }

    private async applyActionReactionWeatherDraft(
        actionReaction: ActionReactionDocument,
    ) {
        if (actionReaction.user instanceof Types.ObjectId)
            throw new InternalServerErrorException('USER_IS_NOT_POPULATED');
        const weather = await this.weatherService.getWeather('Toulouse');

        console.log('weather', weather);
        return this.googleService.createDraft(
            actionReaction.user,
            "it's " + weather.weather[0].main,
        );
    }

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
            ? await this.reactionRepository.getReactionById(queryDto.reactionId)
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
