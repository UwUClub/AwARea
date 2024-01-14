import { forwardRef, Module } from '@nestjs/common';
import { GithubApiService } from './services/github-api.service';
import { GithubApiController } from './github-api.controller';
import { ActionReactionModule } from '../action-reaction/action-reaction.module';
import { ReactionsModule } from '../reactions/reactions.module';
import { UsersModule } from '../users/users.module';
import { MongooseModule } from '@nestjs/mongoose';
import { Webhook, WebhookSchema } from './webhook.schema';
import { WebhookService } from './services/webhook.service';
import { GithubWebhookRepository } from './github-webhook.repository';

@Module({
  imports: [
    ReactionsModule,
    forwardRef(() => ActionReactionModule),
    forwardRef(() => UsersModule),
    MongooseModule.forFeature([{ name: Webhook.name, schema: WebhookSchema }]),
  ],
  controllers: [GithubApiController],
  providers: [GithubApiService, WebhookService, GithubWebhookRepository],
  exports: [GithubApiService, WebhookService],
})
export class GithubApiModule {}
