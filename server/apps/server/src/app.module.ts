import { MiddlewareConsumer, Module, RequestMethod } from '@nestjs/common';
import {
  AppController,
  appControllerRoute,
  appControllerSignupRoute,
} from './controllers/app.controller';
import { AppService } from './services/app.service';
import { MongooseModule } from '@nestjs/mongoose';
import { Config } from './config';
import { User, UserSchema } from './schemas/user.schema';
import { EmailExistsMiddleware } from './middlewares/email-exists.middleware';
import { JwtModule } from '@nestjs/jwt';
import { jwtConstants } from './constants';
import { AuthMiddleware } from './middlewares/auth.middleware';

@Module({
  imports: [
    JwtModule.register({
      secret: jwtConstants.secret,
      signOptions: { expiresIn: '2d' },
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
    consumer.apply(AuthMiddleware).forRoutes({
      path: appControllerRoute,
      method: RequestMethod.GET,
    });
  }
}
