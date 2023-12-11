import { Module } from '@nestjs/common';
import { NasaController } from './nasa.controller';
import { HttpModule } from '@nestjs/axios';

@Module({
    imports: [HttpModule],
    controllers: [NasaController],
})
export class NasaModule {}
