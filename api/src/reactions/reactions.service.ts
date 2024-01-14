import { BadRequestException, Injectable } from '@nestjs/common';
import { ReactionDocumentType } from './schemas/reactions.schema';
import { UserDocument } from '../users/users.schema';
import { GoogleApiService } from '../google-api/google-api.service';
import { CreateReactionDto } from './_utils/dto/request/create-reaction.dto';
import { ReactionRepository } from './reaction.repository';
import { mergeObjects } from './_utils/functions/use-variable-in-reaction.function';
import { SlackService } from '../slack/slack.service';

@Injectable()
export class ReactionsService {
  private readonly reactions: {
    CREATE_DRAFT: (user: UserDocument, reaction: ReactionDocumentType) => Promise<any>;
    CREATE_SLACK_CHANNEL: (user: UserDocument, reaction: ReactionDocumentType) => Promise<any>;
    SEND_SLACK_MESSAGE: (user: UserDocument, reaction: ReactionDocumentType) => Promise<any>;
    SEND_EMAIL: (user: UserDocument, reaction: ReactionDocumentType) => Promise<any>;
  };

  private readonly bodyNeeded: {
    CREATE_DRAFT: string[];
    CREATE_SLACK_CHANNEL: string[];
    SEND_SLACK_MESSAGE: string[];
    SEND_EMAIL: string[];
  };

  constructor(
    private readonly googleApiService: GoogleApiService,
    private readonly reactionsRepository: ReactionRepository,
    private readonly slackService: SlackService,
  ) {
    this.reactions = {
      CREATE_DRAFT: async (user: UserDocument, reaction: ReactionDocumentType) => {
        return await this.googleApiService.createDraft(user, reaction);
      },
      CREATE_SLACK_CHANNEL: async (user: UserDocument, reaction: ReactionDocumentType) => {
        return await this.slackService.createChannel(user, reaction);
      },
      SEND_SLACK_MESSAGE: async (user: UserDocument, reaction: ReactionDocumentType) => {
        return await this.slackService.sendMessage(user, reaction);
      },
      SEND_EMAIL: async (user: UserDocument, reaction: ReactionDocumentType) => {
        return await this.googleApiService.sendMail(user, reaction);
      },
    };
    this.bodyNeeded = {
      CREATE_DRAFT: ['destinationEmail', 'subject', 'body'],
      CREATE_SLACK_CHANNEL: ['channelName'],
      SEND_SLACK_MESSAGE: ['channelName', 'message'],
      SEND_EMAIL: ['destinationEmail', 'subject', 'body'],
    };
  }

  async executeReaction(user: UserDocument, reaction: ReactionDocumentType, actionVar: any) {
    if (!reaction) return;
    console.log("c'est passe");
    return this.reactions[reaction.reactionType](user, mergeObjects(actionVar, reaction));
  }

  async createReaction(user: UserDocument, data: CreateReactionDto) {
    for (const key of this.bodyNeeded[data.reactionType]) {
      if (!data[key]) {
        throw new BadRequestException(`You need to provide ${key} to create this reaction`);
      }
    }
    switch (data.reactionType) {
      case 'CREATE_DRAFT':
        return this.reactionsRepository.createDraft(data.destinationEmail, data.body, data.subject);
      case 'SEND_SLACK_MESSAGE':
        return this.reactionsRepository.sendSlackMessage(data.channelName, data.message);
      case 'CREATE_SLACK_CHANNEL':
        return this.reactionsRepository.createSlackChannel(data.channelName);
      case 'SEND_EMAIL':
        return this.reactionsRepository.sendEmail(data.destinationEmail, data.body, data.subject);
      default:
        throw new BadRequestException('Y a pas ca ici');
    }
  }
}
