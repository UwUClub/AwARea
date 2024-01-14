import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { OmitType } from '@nestjs/swagger';
import { Action } from './actions.schema';
import { ActionTypeEnum } from '../_utils/enums/action-type.enum';
import { HydratedDocument } from 'mongoose';

export type GithubApiDocument = HydratedDocument<GithubApi>;

@Schema()
export class GithubApi extends OmitType(Action, ['actionType'] as const) {
  actionType:
    | ActionTypeEnum.BRANCH_CREATED
    | ActionTypeEnum.BRANCH_DELETED
    | ActionTypeEnum.BRANCH_MERGED
    | ActionTypeEnum.ISSUE_OPENED
    | ActionTypeEnum.PULL_REQUEST_CREATED
    | ActionTypeEnum.PULL_REQUEST_REVIEW_REQUESTED
    | ActionTypeEnum.PULL_REQUEST_REVIEW_REQUEST_REMOVED
    | ActionTypeEnum.STAR_ADDED
    | ActionTypeEnum.STAR_REMOVED;

  @Prop({ required: true })
  repoName: string;
}

export const GithubApiSchema = SchemaFactory.createForClass(GithubApi);
