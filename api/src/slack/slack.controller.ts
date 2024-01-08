import { Body, Controller, Patch } from "@nestjs/common";
import { ApiTags } from "@nestjs/swagger";
import { ConnectedUser } from "src/auth/_utils/decorators/connected-user.decorator";
import { Protect } from "src/auth/_utils/decorators/protect.decorator";
import { UpdateSlackBotDto } from "src/slack/_utils/dto/update-slack-bot.dto";
import { UsersRepository } from "src/users/users.repository";
import { UserDocument } from "src/users/users.schema";

@ApiTags('Slack')
@Controller('slack')
export class SlackController {

    constructor(
        private readonly usersRepository: UsersRepository,
    ) { }

    @Protect()
    @Patch('update-slack-bot')
    updateSlackBot(@ConnectedUser() user: UserDocument, @Body() updateSlackBotDto: UpdateSlackBotDto) {
        this.usersRepository.updateOneById(user._id, { slackBotToken: updateSlackBotDto.botToken });
        return { message: 'Slack bot token updated successfully' };
    }
}