import { Injectable } from '@nestjs/common';
import { GithubWebhookRepository } from '../github-webhook.repository';
import axios from 'axios';
import { EnvironmentVariables } from '../../_utils/config';
import { ConfigService } from '@nestjs/config';
import { UserDocument } from '../../users/users.schema';

@Injectable()
export class WebhookService {
  constructor(
    private readonly webhookRepo: GithubWebhookRepository,
    private readonly configService: ConfigService<EnvironmentVariables, true>,
  ) {}

  async createWebhook(user: UserDocument, repoName: string) {
    const repo = await this.webhookRepo.getWebhookByParams({
      repoName,
      userName: user.githubName,
    });
    if (repo) return false;

    const url = `https://api.github.com/repos/${user.githubName}/${repoName}/hooks`;
    const config = {
      headers: {
        Authorization: `Bearer ${user.githubAccessToken}`,
        'X-GitHub-Api-Version': '2022-11-28',
      },
    };
    const data = {
      name: 'web',
      active: true,
      events: ['*'],
      config: {
        url: this.configService.get('GITHUB_CALLBACK_URL'),
        content_type: 'json',
        insecure_ssl: '0',
      },
    };
    const response = await axios.post(url, data, config);

    if (response.status !== 201) return false;
    await this.webhookRepo.createWebhook({
      repoId: response.data.id,
      repoName,
      userName: user.githubName,
    });
    return true;
  }

  getWebhook = (userName: string, repoName: string) =>
    this.webhookRepo.getWebhookByParams({
      repoName,
      userName,
    });

  async removeWebhook(user: UserDocument, repoName: string) {
    const webhook = await this.webhookRepo.getWebhookByParams({
      repoName,
      userName: user.githubName,
    });

    if (!webhook) return false;
    const url = `https://api.github.com/repos/${user.githubName}/${repoName}/hooks/${webhook.repoId}`;
    const config = {
      headers: {
        Authorization: `Bearer ${user.githubAccessToken}`,
        'X-GitHub-Api-Version': '2022-11-28',
      },
    };
    const deletedWebhook = await axios.delete(url, config);
    if (deletedWebhook.status !== 204) return false;
    await this.webhookRepo.removeWebhook({
      repoName,
      userName: user.githubName,
    });
    return true;
  }
}
