import { Injectable } from '@nestjs/common';

@Injectable()
export class AboutService {
    getAbout(ipAddress: string) {
        return {
            client: {
                host: ipAddress,
            },
            server: {
                current_time: new Date().getTime(),
                services: [
                    {
                        name: 'weather',
                        actions: [
                            {
                                name: 'Get Meteo',
                                description: 'Get the meteo of the location',
                            },
                        ],
                    },
                    {
                        name: 'Naza',
                        actions: [
                            {
                                name: 'Get photo of the day',
                                description:
                                    'Get the photo of the day posted every day by Naza',
                            },
                        ],
                    },
                ],
            },
        };
    }
}
