import { Injectable, UnauthorizedException } from '@nestjs/common';
import { OAuth2Client } from 'google-auth-library';
import { ConfigService } from '@nestjs/config';
import { EnvironmentVariables } from '../_utils/config';
import { google } from 'googleapis';
import { GoogleLoginDto } from '../auth/_utils/dto/request/google-login.dto';
import { UserDocument } from '../users/users.schema';
import { ReactionDocumentType } from '../reactions/schemas/reactions.schema';

@Injectable()
export class GoogleApiService {
  private readonly oAuth2Client: OAuth2Client;
  constructor(private readonly configService: ConfigService<EnvironmentVariables, true>) {
    this.oAuth2Client = new google.auth.OAuth2(
      this.configService.get('GOOGLE_CLIENT_ID'),
      this.configService.get('GOOGLE_CLIENT_SECRET'),
      this.configService.get('GOOGLE_CALLBACK_URL'),
    );
  }

  private setAccessToken(accessToken: string) {
    this.oAuth2Client.setCredentials({ access_token: accessToken });
  }

  private async getGoogleProfile(accessToken: string) {
    this.setAccessToken(accessToken);
    try {
      return await google
        .oauth2({
          auth: this.oAuth2Client,
          version: 'v2',
        })
        .userinfo.get();
    } catch {
      throw new UnauthorizedException('Bad access token');
    }
  }

  private createMailFromInfo(to: string, subject: string, body: string) {
    const message = '----\n' + `To: ${to}\n` + `Subject: ${subject}\n` + '\n' + `${body}\n`;
    return Buffer.from(message).toString('base64');
  }

  async createDraft(user: UserDocument, reaction: ReactionDocumentType) {
    if (reaction.reactionType !== 'CREATE_DRAFT') throw new UnauthorizedException('Bad reaction type');
    if (!user.googleAccessToken) throw new UnauthorizedException('Not connected with google');
    this.setAccessToken(user.googleAccessToken);
    const gmail = google.gmail({ version: 'v1', auth: this.oAuth2Client });
    return gmail.users.drafts
      .create({
        userId: 'me',
        requestBody: {
          id: '',
          message: {
            raw: this.createMailFromInfo(reaction.email, reaction.subject, reaction.body),
          },
        },
      })
      .catch(() => {
        throw new UnauthorizedException('Bad access token');
      });
  }

  async loginWithGoogle(googleLogin: GoogleLoginDto) {
    return this.getGoogleProfile(googleLogin.accessToken);
  }
}
