import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { ReactionTypeEnum } from './_utils/enum/reaction-type.enum';
import { Model, Types } from 'mongoose';
import { CreateDraft } from './schemas/create-draft.schema';
import { Reaction } from './schemas/reactions.schema';
import { UserDocument } from 'src/users/users.schema';
import { SendSlackMessage } from './schemas/send-slack-message.schema';
import { CreateSlackChannel } from './schemas/create-slack-channel.schema';
import { SendEmail } from './schemas/send-email.schema';

@Injectable()
export class ReactionRepository {
  constructor(
    @InjectModel(Reaction.name) private reactionModel: Model<Reaction>,
    @InjectModel(ReactionTypeEnum.CREATE_DRAFT)
    private createDraftModel: Model<CreateDraft>,
    @InjectModel(ReactionTypeEnum.SEND_SLACK_MESSAGE)
    private sendSlackMessageModel: Model<SendSlackMessage>,
    @InjectModel(ReactionTypeEnum.CREATE_SLACK_CHANNEL)
    private createSlackChannelModel: Model<CreateSlackChannel>,
    @InjectModel(ReactionTypeEnum.SEND_EMAIL)
    private sendEmailModel: Model<SendEmail>,
  ) {}

  createDraft = (email: string, body: string, subject: string) =>
    this.createDraftModel.create({
      email: email,
      body: body,
      subject: subject,
    });

  createSlackChannel = (channelName: string) =>
    this.createSlackChannelModel.create({
      channelName: channelName,
    });

  sendSlackMessage = (channelName: string, message: string) =>
    this.sendSlackMessageModel.create({
      channelName: channelName,
      message: message,
    });

  sendEmail = (email: string, body: string, subject: string) =>
    this.sendEmailModel.create({
      email: email,
      body: body,
      subject: subject,
    });

  getReactionById = (id: string, user: UserDocument) =>
    this.reactionModel.findOne({ _id: id }).orFail(new NotFoundException('Reaction not found')).exec();

  removeReactionById = (id: Types.ObjectId) =>
    this.reactionModel.findOneAndDelete({ _id: id }).orFail(new NotFoundException('Reaction not found')).exec();
}
