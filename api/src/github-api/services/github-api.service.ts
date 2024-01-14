import { Injectable } from '@nestjs/common';
import axios from 'axios';
import { ActionTypeEnum } from '../../actions/_utils/enums/action-type.enum';
import { ActionReactionRepository } from '../../action-reaction/action-reaction.repository';
import { ReactionsService } from '../../reactions/reactions.service';
import { UsersRepository } from '../../users/users.repository';
import { toGithubInterface } from '../_utils/functions/to-github-interface.function';

@Injectable()
export class GithubApiService {
  constructor(
    private readonly actionReactionRepository: ActionReactionRepository,
    private readonly reactionService: ReactionsService,
    private readonly usersRepository: UsersRepository,
  ) {}

  async getGithubUser(token: string) {
    const url = 'https://api.github.com/user';
    const config = {
      headers: {
        Authorization: `Bearer ${token}`,
        'X-GitHub-Api-Version': '2022-11-28',
      },
    };
    const response = await axios.get(url, config);
    return response.data;
  }

  async getGithubWebhooks(repoName: string, userName: string, token: string) {
    const url = `https://api.github.com/repos/${userName}/${repoName}/hooks`;
    const config = {
      headers: {
        Authorization: `Bearer ${token}`,
        'X-GitHub-Api-Version': '2022-11-28',
      },
    };
    const response = await axios.get(url, config);
    return response.data;
  }

  defineActionType(event: string, action: any): ActionTypeEnum | null {
    switch (event) {
      case 'push':
        if (action?.created === true) return ActionTypeEnum.BRANCH_CREATED;
        if (action?.deleted === true) return ActionTypeEnum.BRANCH_DELETED;
        return null;
      case 'issues':
        if (action?.action === 'opened') return ActionTypeEnum.ISSUE_OPENED;
        return null;
      case 'pull_request':
        if (action?.action === 'opened') return ActionTypeEnum.PULL_REQUEST_CREATED;
        if (action?.action === 'review_requested') return ActionTypeEnum.PULL_REQUEST_REVIEW_REQUESTED;
        if (action?.action === 'review_request_removed') return ActionTypeEnum.PULL_REQUEST_REVIEW_REQUEST_REMOVED;
        if (action?.action === 'closed' && action?.merged === true) return ActionTypeEnum.BRANCH_MERGED;
        return null;
      case 'star':
        if (action?.action === 'created') return ActionTypeEnum.STAR_ADDED;
        if (action?.action === 'deleted') return ActionTypeEnum.STAR_REMOVED;
        return null;
      default:
        return null;
    }
  }

  async handleWebhook(payload: any, signature: string, event: string) {
    const { sender, repository, ...rest } = payload;
    const actionType = this.defineActionType(event, rest);
    if (!actionType) return;

    const users = await this.usersRepository.findOneByGithubId(sender.id);
    const action = toGithubInterface(payload, actionType);
    const actionReactions = await this.actionReactionRepository.getActionReactionByFilter({
      'user._id': { $in: users.map((user) => user._id) },
      'action.actionType': actionType,
      'action.repoName': repository.name,
    });
    for (const actionReaction of actionReactions) {
      for (const user of users)
        if (actionReaction.user[0]._id.toString() === user._id.toString())
          await this.reactionService
            .executeReaction(user, actionReaction.reaction, action)
            .catch((err) => console.log(err));
    }
  }
}
