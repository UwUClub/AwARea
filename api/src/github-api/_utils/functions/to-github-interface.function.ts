import { ActionTypeEnum } from '../../../actions/_utils/enums/action-type.enum';
import { toBranchActionInterface } from '../interfaces/branch-action.interface';
import { toIssueInterface } from '../interfaces/issue.interface';
import { toPullRequestInterface } from '../interfaces/pull-request.interface';
import { toStarInterface } from '../interfaces/star.interface';

export function toGithubInterface(githubAction: any, type: ActionTypeEnum) {
  switch (type) {
    case ActionTypeEnum.BRANCH_CREATED:
    case ActionTypeEnum.BRANCH_DELETED:
    case ActionTypeEnum.BRANCH_MERGED:
      return toBranchActionInterface(githubAction);
    case ActionTypeEnum.ISSUE_OPENED:
      return toIssueInterface(githubAction);
    case ActionTypeEnum.PULL_REQUEST_CREATED:
    case ActionTypeEnum.PULL_REQUEST_REVIEW_REQUESTED:
    case ActionTypeEnum.PULL_REQUEST_REVIEW_REQUEST_REMOVED:
      return toPullRequestInterface(githubAction);
    case ActionTypeEnum.STAR_ADDED:
    case ActionTypeEnum.STAR_REMOVED:
      return toStarInterface(githubAction);
    default:
      return null;
  }
}
