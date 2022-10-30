import { NestFactory } from '@nestjs/core';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.enableCors();

  const config = new DocumentBuilder()
    .setTitle('Fdoc Api')
    .setDescription('The Fdoc api build for the creating documents for flutter')
    .setVersion('1.0')
    .addTag('fdoc')
    .build();
  const document = SwaggerModule.createDocument(app, config);
  SwaggerModule.setup('apis', app, document);
  console.log('running', process.env.PORT || 45415);
  await app.listen(process.env.PORT || 45415, () => {
    console.log('running in port http://localhost:45415');
    console.log('swagger doc in port http://localhost:45415/apis');
  });
}
bootstrap();
