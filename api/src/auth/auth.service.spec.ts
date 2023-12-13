import { Test, TestingModule } from '@nestjs/testing';
import { AuthService } from './auth.service';
import { UsersRepository } from '../users/users.repository';
import { UsersMapper } from '../users/users.mapper';
import { JwtService } from '@nestjs/jwt';
import { UsersService } from '../users/users.service';
import { Model } from 'mongoose';

describe('AuthService', () => {
    let service: AuthService;

    beforeEach(async () => {
        const module: TestingModule = await Test.createTestingModule({
            providers: [
                AuthService,
                UsersRepository,
                {
                    provide: 'UserModel',
                    useValue: Model,
                },
                UsersMapper,
                JwtService,
                UsersService,
            ],
        }).compile();

        service = module.get<AuthService>(AuthService);
    });

    it('should be defined', () => {
        expect(service).toBeDefined();
    });
});
