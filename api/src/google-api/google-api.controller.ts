import { Controller, Get } from '@nestjs/common';
import { Protect } from '../auth/_utils/decorators/protect.decorator';
import { ConnectedUser } from '../auth/_utils/decorators/connected-user.decorator';
import { UserDocument } from '../users/users.schema';
import { GoogleApiService } from './google-api.service';

@Controller('google')
export class GoogleApiController {
    constructor(private readonly googleService: GoogleApiService) {}

    @Protect()
    @Get()
    generate(@ConnectedUser() user: UserDocument) {
        return this.googleService.createDraft(user, 'test');
    }
}
