import { Test, TestingModule } from '@nestjs/testing';
import { ActionReactionController } from './action-reaction.controller';
import { ActionReactionService } from './action-reaction.service';

describe('ActionReactionController', () => {
  let controller: ActionReactionController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [ActionReactionController],
      providers: [ActionReactionService],
    }).compile();

    controller = module.get<ActionReactionController>(ActionReactionController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
