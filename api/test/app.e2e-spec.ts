import { Test, TestingModule } from '@nestjs/testing';
import { INestApplication } from '@nestjs/common';
import * as request from 'supertest';
import { AppModule } from './../src/app.module';

describe('AppController (e2e)', () => {
  let app: INestApplication;

  beforeEach(async () => {
    const moduleFixture: TestingModule = await Test.createTestingModule({
      imports: [AppModule],
    }).compile();

    app = moduleFixture.createNestApplication();
    await app.init();
  });

  it('/ (GET)', () => {
    return request(app.getHttpServer()).get('/').expect(200).expect('Hello World!');
  });

  it('/auth/register success (POST)', () => {
    return request(app.getHttpServer())
      .post('/auth/register')
      .send({
        email: 'test@user.com',
        password: 'testpassword',
        username: 'testuser',
        fullname: 'Test User',
      })
      .expect(201);
  });

  it('/auth/register error (POST)', () => {
    return request(app.getHttpServer())
      .post('/auth/register')
      .send({
        email: 'testuser',
        password: 'testpassword',
        username: 'testuser',
        fullname: 'Test User',
      })
      .expect(401);
  });

  it('/auth/login success (POST)', () => {
    request(app.getHttpServer()).post('/auth/register').send({
      email: 'test@user.com',
      password: 'testpassword',
      username: 'testuser',
      fullname: 'Test User',
    });
    return request(app.getHttpServer())
      .post('/auth/login')
      .send({
        email: 'test@user.com',
        password: 'testpassword',
      })
      .expect(201);
  });

  it('/auth/login error (POST)', () => {
    request(app.getHttpServer()).post('/auth/register').send({
      email: 'test@user.com',
      password: 'testpassword',
      username: 'testuser',
      fullname: 'Test User',
    });
    return request(app.getHttpServer())
      .post('/auth/login')
      .send({
        email: 'test',
        password: 'testpassword',
      })
      .expect(401);
  });
});
