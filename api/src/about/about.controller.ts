import { Controller, Req } from '@nestjs/common';
import { AboutService } from './about.service';
import { ApiTags } from '@nestjs/swagger';
import { Get } from '@nestjs/common';
import { Request } from 'express';

@ApiTags('About')
@Controller('about.json')
export class AboutController {
  constructor(private readonly aboutService: AboutService) { }

  @Get()
  async getAbout(@Req() request: Request) {
    return this.aboutService.getAbout(request.ip);
  }
}
