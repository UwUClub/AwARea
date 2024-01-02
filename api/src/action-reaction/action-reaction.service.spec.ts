import { Test, TestingModule } from '@nestjs/testing';
import { ActionReactionService } from './action-reaction.service';

describe('ActionReactionService', () => {
  let service: ActionReactionService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [ActionReactionService],
    }).compile();

    service = module.get<ActionReactionService>(ActionReactionService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
