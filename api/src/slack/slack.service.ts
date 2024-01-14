import { Injectable } from '@nestjs/common';
import { UserDocument } from '../users/users.schema';
import { ReactionDocumentType } from '../reactions/schemas/reactions.schema';
import { WebClient } from '@slack/web-api';

@Injectable()
export class SlackService {
  constructor() {}

  async sendMessage(user: UserDocument, reaction: ReactionDocumentType) {
    if (reaction.reactionType !== 'SEND_SLACK_MESSAGE') return;
    const token = user.slackBotToken;
    const web = new WebClient(token);
    try {
      await web.chat.postMessage({
        channel: reaction.channelName,
        text: reaction.message,
      });
    } catch (e) {
      console.log(e);
    }
  }

  async createChannel(user: UserDocument, reaction: ReactionDocumentType) {
    if (reaction.reactionType !== 'CREATE_SLACK_CHANNEL') return;
    const token = user.slackBotToken;
    const web = new WebClient(token);
    try {
      await web.conversations.create({
        name: reaction.channelName,
      });
    } catch (e) {
      console.log(e);
    }
  }
}
