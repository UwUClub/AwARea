import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { SwaggerModule, DocumentBuilder } from '@nestjs/swagger';
import { ValidationPipe } from '@nestjs/common';

async function main() {
    const app = await NestFactory.create(AppModule);
    app.useGlobalPipes(new ValidationPipe());
    app.enableCors();

    const config = new DocumentBuilder()
        .setTitle('MakerAPI')
        .setDescription(
            'This is the API used by the server of Maker AREA project. It should show you all the endpoints available to use.',
        )
        .setVersion('0.2')
        .addBearerAuth()
        .build();
    const document = SwaggerModule.createDocument(app, config);
    SwaggerModule.setup('api', app, document);
    await app.listen(8080);
}

main();
