import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { HydratedDocument } from 'mongoose';

export type WebhookDocument = HydratedDocument<Webhook>;

@Schema()
export class Webhook {
  @Prop({ required: true })
  repoName: string;

  @Prop({ required: true })
  userName: string;

  @Prop({ required: true })
  repoId: string;
}

export const WebhookSchema = SchemaFactory.createForClass(Webhook);
