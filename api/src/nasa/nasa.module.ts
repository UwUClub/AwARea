import { Module } from '@nestjs/common';
import { NasaService } from './nasa.service';
import { NasaMapper } from './nasa.mapper';
import { HttpModule } from '@nestjs/axios';

@Module({
    imports: [HttpModule],
    providers: [NasaService, NasaMapper],
    exports: [NasaService],
})
export class NasaModule {}
