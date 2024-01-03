import { BadRequestException, Injectable } from '@nestjs/common';
import { ReactionDocumentType } from './schemas/reactions.schema';
import { UserDocument } from '../users/users.schema';
import { GoogleApiService } from '../google-api/google-api.service';
import { CreateReactionDto } from './_utils/dto/request/create-reaction.dto';
import { ReactionRepository } from './reaction.repository';

@Injectable()
export class ReactionsService {
    private readonly reactions: {
        CREATE_DRAFT: (
            user: UserDocument,
            reaction: ReactionDocumentType,
        ) => Promise<any>;
    };

    private readonly bodyNeeded: { CREATE_DRAFT: string[] };

    constructor(
        private readonly googleApiService: GoogleApiService,
        private readonly reactionsRepository: ReactionRepository,
    ) {
        this.reactions = {
            CREATE_DRAFT: async (
                user: UserDocument,
                reaction: ReactionDocumentType,
            ) => {
                return await this.googleApiService.createDraft(user, reaction);
            },
        };
        this.bodyNeeded = {
            CREATE_DRAFT: ['destinationEmail', 'subject', 'body'],
        };
    }

    async executeReaction(user: UserDocument, reaction: ReactionDocumentType) {
        return this.reactions[reaction.reactionType](user, reaction);
    }

    async createReaction(user: UserDocument, data: CreateReactionDto) {
        if (this.bodyNeeded[data.reactionType].some((key) => !data[key])) {
            throw new BadRequestException(
                `You need to provide ${this.bodyNeeded[data.reactionType].join(
                    ', ',
                )} to create this reaction`,
            );
        }
        switch (data.reactionType) {
            case 'CREATE_DRAFT':
                return this.reactionsRepository.createDraft(
                    data.destinationEmail,
                    data.body,
                    data.subject,
                );
            default:
                throw new BadRequestException('Y a pas ca ici');
        }
    }
}
