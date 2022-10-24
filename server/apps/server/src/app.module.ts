import { MiddlewareConsumer, Module, RequestMethod } from '@nestjs/common';
import {
  AppController,
  appControllerRoute,
  appControllerSignupRoute,
} from './app.controller';
import { AppService } from './app.service';
import { MongooseModule } from '@nestjs/mongoose';
import { Config } from './config';
import { User, UserSchema } from './schemas/user.schema';
import { EmailExistsMiddleware } from './email-exists.middleware';
import { JwtModule } from '@nestjs/jwt';
import { jwtConstants } from './constants';

@Module({
  imports: [
    JwtModule.register({
      secret: jwtConstants.secret,
      signOptions: { notBefore: '2h' },
    }),
    MongooseModule.forRoot(Config.getMoonogseConfig()),
    MongooseModule.forFeature([{ name: User.name, schema: UserSchema }]),
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {
  configure(consumer: MiddlewareConsumer) {
    consumer.apply(EmailExistsMiddleware).forRoutes({
      path: appControllerRoute + '/' + appControllerSignupRoute,
      method: RequestMethod.POST,
    });
  }
}
