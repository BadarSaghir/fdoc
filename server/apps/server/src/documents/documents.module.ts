import { MiddlewareConsumer, Module, RequestMethod } from '@nestjs/common';
import { DocumentsService } from './documents.service';
import { DocumentsController } from './documents.controller';
import { MongooseModule } from '@nestjs/mongoose';
import { AuthMiddleware } from '../middlewares/auth.middleware';
import { JwtModule } from '@nestjs/jwt';
import { jwtConstants } from '../constants';
import { Document, DocumentSchema } from './entities/document.entity';

@Module({
  imports: [
    MongooseModule.forFeature([
      { name: Document.name, schema: DocumentSchema },
    ]),
    JwtModule.register({
      secret: jwtConstants.secret,
      signOptions: { expiresIn: '2d' },
    }),
  ],
  controllers: [DocumentsController],
  providers: [DocumentsService],
  exports: [DocumentsService],
})
export class DocumentsModule {
  configure(consumer: MiddlewareConsumer) {
    consumer
      .apply(AuthMiddleware)
      .exclude({ path: DocumentsController.docById, method: RequestMethod.GET })
      .forRoutes(DocumentsController);
    consumer.apply(AuthMiddleware).forRoutes({
      path: DocumentsController.docsByMe,
      method: RequestMethod.GET,
    });
  }
}
