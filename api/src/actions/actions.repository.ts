import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { ActionTypeEnum } from './_utils/enums/action-type.enum';
import { Model, Types } from 'mongoose';
import { NasaApodAction } from './schemas/nasa-apod-action.schema';
import { WeatherAction } from './schemas/weather-action.schema';
import { Action } from './schemas/actions.schema';
import { GithubApi } from './schemas/github-api.schema';

@Injectable()
export class ActionsRepository {
  private githubModel: {
    [ActionTypeEnum.BRANCH_DELETED]: Model<GithubApi>;
    [ActionTypeEnum.STAR_REMOVED]: Model<GithubApi>;
    [ActionTypeEnum.ISSUE_OPENED]: Model<GithubApi>;
    [ActionTypeEnum.PULL_REQUEST_CREATED]: Model<GithubApi>;
    [ActionTypeEnum.PULL_REQUEST_REVIEW_REQUESTED]: Model<GithubApi>;
    [ActionTypeEnum.BRANCH_CREATED]: Model<GithubApi>;
    [ActionTypeEnum.PULL_REQUEST_REVIEW_REQUEST_REMOVED]: Model<GithubApi>;
    [ActionTypeEnum.STAR_ADDED]: Model<GithubApi>;
    [ActionTypeEnum.BRANCH_MERGED]: Model<GithubApi>;
  };
  constructor(
    @InjectModel(Action.name) private actionModel: Model<Action>,
    @InjectModel(ActionTypeEnum.NASA_GET_APOD)
    private nasaModel: Model<NasaApodAction>,
    @InjectModel(ActionTypeEnum.WEATHER_GET_CURRENT)
    private weatherModel: Model<WeatherAction>,
    @InjectModel(ActionTypeEnum.BRANCH_CREATED)
    private githubBranchCreationModel: Model<GithubApi>,
    @InjectModel(ActionTypeEnum.BRANCH_DELETED)
    private githubBranchDeletionModel: Model<GithubApi>,
    @InjectModel(ActionTypeEnum.BRANCH_MERGED)
    private githubBranchMergeModel: Model<GithubApi>,
    @InjectModel(ActionTypeEnum.ISSUE_OPENED)
    private githubIssueOpenedModel: Model<GithubApi>,
    @InjectModel(ActionTypeEnum.PULL_REQUEST_CREATED)
    private githubPullRequestCreatedModel: Model<GithubApi>,
    @InjectModel(ActionTypeEnum.PULL_REQUEST_REVIEW_REQUESTED)
    private githubPullRequestReviewRequestedModel: Model<GithubApi>,
    @InjectModel(ActionTypeEnum.PULL_REQUEST_REVIEW_REQUEST_REMOVED)
    private githubPullRequestReviewRequestRemovedModel: Model<GithubApi>,
    @InjectModel(ActionTypeEnum.STAR_ADDED)
    private githubStarAddedModel: Model<GithubApi>,
    @InjectModel(ActionTypeEnum.STAR_REMOVED)
    private githubStarRemovedModel: Model<GithubApi>,
  ) {
    this.githubModel = {
      [ActionTypeEnum.BRANCH_CREATED]: this.githubBranchCreationModel,
      [ActionTypeEnum.BRANCH_DELETED]: this.githubBranchDeletionModel,
      [ActionTypeEnum.BRANCH_MERGED]: this.githubBranchMergeModel,
      [ActionTypeEnum.ISSUE_OPENED]: this.githubIssueOpenedModel,
      [ActionTypeEnum.PULL_REQUEST_CREATED]: this.githubPullRequestCreatedModel,
      [ActionTypeEnum.PULL_REQUEST_REVIEW_REQUESTED]: this.githubPullRequestReviewRequestedModel,
      [ActionTypeEnum.PULL_REQUEST_REVIEW_REQUEST_REMOVED]: this.githubPullRequestReviewRequestRemovedModel,
      [ActionTypeEnum.STAR_ADDED]: this.githubStarAddedModel,
      [ActionTypeEnum.STAR_REMOVED]: this.githubStarRemovedModel,
    };
  }

  createNasaAction = () =>
    this.nasaModel.create({
      actionType: ActionTypeEnum.NASA_GET_APOD,
    });

  createWeatherAction = (city: string) => this.weatherModel.create({ city: city });

  createGithubAction = (repoName: string, actionType: ActionTypeEnum) =>
    this.githubModel[actionType].create({
      repoName,
      actionType,
    });

  getActionById = (id: Types.ObjectId) => this.actionModel.findById(id).orFail(new Error('Action not found')).exec();

  updateWebhookId = (webhookId: string | null, actionId: Types.ObjectId) =>
    this.actionModel
      .findByIdAndUpdate(actionId, { webhookId: webhookId }, { new: true })
      .orFail(new NotFoundException(`Action ${actionId} not found`))
      .exec();
}
