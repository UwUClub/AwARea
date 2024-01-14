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
                description: 'Get the photo of the day posted every day by Naza',
              },
            ],
          },
          {
            name: 'Github',
            actions: [
              {
                name: 'Pull request creation',
                description: 'Create a pull request on a specific repository',
              },
              {
                name: 'Issue creation',
                description: 'Create an issue on a specific repository',
              },
              {
                name: 'Star added',
                description: 'Add a star on a specific repository',
              },
              {
                name: 'Star removed',
                description: 'Trigger when a star is remove on a specific repository',
              },
              {
                name: 'branch merged',
                description: 'Trigger when a branch is merge on a specific repository',
              },
              {
                name: 'Pull request review requested',
                description: 'Trigger when a pull request is review requested on a specific repository',
              },
              {
                name: 'Pull request review removed',
                description: 'Trigger when a pull request is review removed on a specific repository',
              },
              {
                name: 'Branch created',
                description: 'Trigger when a branch is created on a specific repository',
              },
              {
                name: 'Branch deleted',
                description: 'Trigger when a branch is deleted on a specific repository',
              },
            ],
          },
          {
            name: 'Timer',
            actions: [
              {
                name: 'On this date',
                description: 'Trigger when the date is reached',
              },
            ],
          },
          {
            name: 'slack',
            reactions: [
              {
                name: 'Send message',
                description: 'Send a message on slack',
              },
              {
                name: 'Create channel',
                description: 'Create a channel on slack',
              },
            ],
          },
          {
            name: 'Google',
            reactions: [
              {
                name: 'Create draft',
                description: 'Create a draft on gmail',
              },
              {
                name: 'Send email',
                description: 'Create and send an email with gmail',
              },
            ],
          },
        ],
      },
    };
  }
}
