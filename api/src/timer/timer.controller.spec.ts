import { Test, TestingModule } from '@nestjs/testing';
import { TimerController } from './timer.controller';
import { TimerService } from './timer.service';

describe('TimerController', () => {
  let controller: TimerController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [TimerController],
      providers: [TimerService],
    }).compile();

    controller = module.get<TimerController>(TimerController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
