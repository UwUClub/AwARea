import { BadRequestException, Injectable, PipeTransform } from '@nestjs/common';
import { ActionReactionRepository } from '../../action-reaction.repository';

@Injectable()
export class GetActionReaction implements PipeTransform {
  constructor(private readonly actionReactionRepository: ActionReactionRepository) {}

  async transform(actionReactionId: string) {
    const actionReaction = await this.actionReactionRepository.getActionReactionByIdNotConnected(actionReactionId);
    if (!actionReaction) throw new BadRequestException('Action reaction does not exist');

    return actionReaction;
  }
}
