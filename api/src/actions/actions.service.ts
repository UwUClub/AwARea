import {
    BadRequestException,
    Injectable,
    NotImplementedException,
} from '@nestjs/common';
import { WeatherService } from '../weather/weather.service';
import { NasaService } from '../nasa/nasa.service';
import { NasaPhoto } from 'src/nasa/_utils/dto/response/photo-of-the-day.dto';
import { ActionDocumentType } from './schemas/actions.schema';
import { UserDocument } from '../users/users.schema';
import { CreateActionDto } from './_utils/dto/request/create-action.dto';
import { ActionsRepository } from './actions.repository';

@Injectable()
export class ActionsService {
    private readonly actions: {
        NASA_GET_APOD: (action: ActionDocumentType) => Promise<NasaPhoto>;
        WEATHER_GET_CURRENT: (action: ActionDocumentType) => Promise<any>;
    };

    private readonly bodyNeeded = {
        NASA_GET_APOD: [],
        WEATHER_GET_CURRENT: [],
    };

    constructor(
        private readonly weatherService: WeatherService,
        private readonly nasaService: NasaService,
        private readonly actionsRepository: ActionsRepository,
    ) {
        this.actions = {
            NASA_GET_APOD: async (action: ActionDocumentType) => {
                return await this.nasaService.fetchPhotoOfTheDay(action);
            },
            WEATHER_GET_CURRENT: async (action: ActionDocumentType) => {
                return await this.weatherService.getWeather(action);
            },
        };
        this.bodyNeeded = {
            NASA_GET_APOD: [],
            WEATHER_GET_CURRENT: ['location'],
        };
    }

    async executeAction(action: ActionDocumentType) {
        return this.actions[action.actionType](action);
    }

    createAction(user: UserDocument, data: CreateActionDto) {
        if (this.bodyNeeded[data.actionType].some((key) => !data[key])) {
            throw new BadRequestException(
                `You need to provide ${this.bodyNeeded[data.actionType].join(
                    ', ',
                )} to create this action`,
            );
        }
        switch (data.actionType) {
            case 'NASA_GET_APOD':
                return this.actionsRepository.createNasaAction();
            case 'WEATHER_GET_CURRENT':
                return this.actionsRepository.createWeatherAction(
                    data.location,
                );
            default:
                throw new BadRequestException('Y pas ca ici');
        }
    }
}
