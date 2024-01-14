import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Webhook } from './webhook.schema';
import { Model } from 'mongoose';

@Injectable()
export class GithubWebhookRepository {
  constructor(@InjectModel(Webhook.name) private webhookModel: Model<Webhook>) {}

  getWebhookByParams = (params: { repoName: string; userName: string }) => this.webhookModel.findOne(params).exec();

  createWebhook = (params: { repoName: string; userName: string; repoId: string }) =>
    this.webhookModel.create(params).catch((err) => {
      throw new Error(err.message);
    });

  removeWebhook = (params: { repoName: string; userName: string }) => this.webhookModel.deleteOne(params).exec();
}
