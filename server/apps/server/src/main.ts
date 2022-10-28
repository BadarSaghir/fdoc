import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.enableCors();
  console.log('running', process.env.PORT || 45415);
  await app.listen(process.env.PORT || 45415, () => {
    console.log('running in port http://localhost:45415');
  });
}
bootstrap();
