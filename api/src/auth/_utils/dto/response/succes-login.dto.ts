import { GetUserDto } from '../../../../users/_utils/dto/response/get-user.dto';

export class SuccesLoginDto {
    user: GetUserDto;
    accessToken: string;
}
