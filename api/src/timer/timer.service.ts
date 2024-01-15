import { Injectable } from '@nestjs/common';
import { SchedulerRegistry } from '@nestjs/schedule';
import { CronJob } from 'cron';
import { ActionDocumentType } from '../actions/schemas/actions.schema';
import { ActionReactionRepository } from '../action-reaction/action-reaction.repository';
import { ReactionsService } from '../reactions/reactions.service';

@Injectable()
export class TimerService {
  constructor(
    private schedulerRegistry: SchedulerRegistry,
    private readonly actionReactionRepository: ActionReactionRepository,
    private readonly reactionService: ReactionsService,
  ) {}

  private dateToCron(date: Date) {
    return `${date.getSeconds()} ${date.getMinutes()} ${date.getHours() - 1} ${date.getDate()} ${
      date.getMonth() + 1
    } *`;
  }

  private executeCron(cronName: string, date: Date, callback: () => void) {
    const job = this.schedulerRegistry.getCronJob(cronName);
    if (!job) return;
    if (new Date().getFullYear() === date.getFullYear()) {
      callback();
      job.stop();
      this.schedulerRegistry.deleteCronJob(cronName);
    }
  }

  async waitForThisDate(action: ActionDocumentType) {
    if (action.actionType !== 'TIMER') return;
    const cronName = `timer-${action._id}`;

    console.log(this.dateToCron(action.date));
    const job = new CronJob(this.dateToCron(action.date), () => {
      this.executeCron(cronName, action.date, async () => {
        const actionsReactions = await this.actionReactionRepository.getActionReactionByFilter({
          'action._id': action._id,
        });
        for (const actionReaction of actionsReactions)
          await this.reactionService.executeReaction(
            actionReaction.user[0],
            actionReaction.reaction,
            actionReaction.action,
          );
      });
    });
    this.schedulerRegistry.addCronJob(cronName, job);
    job.start();
  }
}
