import { GetUserDto } from '../../../../users/_utils/dto/response/get-user.dto';

export class SuccesLoginDto {
  user: Promise<GetUserDto>;
  accessToken: string;
}
