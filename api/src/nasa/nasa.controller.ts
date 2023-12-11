import { Controller, Get, Res } from '@nestjs/common';
import { Response } from 'express';
import { ApiTags } from '@nestjs/swagger';
import { NasaHandler } from './nasa.handler';
import { HttpService } from '@nestjs/axios';

@ApiTags('Nasa')
@Controller('nasa')
export class NasaController {
    private nasaHandler: NasaHandler;
    constructor(private readonly httpService: HttpService) {
        this.nasaHandler = new NasaHandler(httpService);
    }

    @Get('photo')
    async getPhotoOfTheDay(@Res() res: Response) {
        try {
            const response = await this.nasaHandler.fetchPhotoOfTheDay();
            return res.status(200).send(response);
        } catch (error) {
            return res
                .status(500)
                .send('Error fetching data from NASA API: ' + error);
        }
    }
}
