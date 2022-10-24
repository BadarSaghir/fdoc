import {
  HttpException,
  HttpStatus,
  Injectable,
  NestMiddleware,
} from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { error } from 'console';
import { Model } from 'mongoose';
import { User, UserDocument } from '../schemas/user.schema';
import { Request, Response, NextFunction } from 'express';
import { FdocPostDto } from '../interfaces/fdoc-post-dto.interface';

@Injectable()
export class EmailExistsMiddleware implements NestMiddleware {
  constructor(@InjectModel(User.name) private userModel: Model<UserDocument>) {}
  async use(
    req: Request<any, any, FdocPostDto>,
    res: Response,
    next: NextFunction,
  ) {
    console.log('middleware');
    let exception: HttpException;
    try {
      const { email, name, profilePic } = req.body;
      if (!email || !name || !profilePic) throw error('Bad Request by client');
      const userExists = await this.userModel.findOne({ email: email });
      if (!userExists) next();
      else
        exception = new HttpException(
          'User already with this email already exists',
          HttpStatus.CONFLICT,
        );
    } catch (e) {
      console.log('middleware Error', e);
      exception = new HttpException('Bad Request', HttpStatus.BAD_REQUEST);
    }
    if (exception) throw exception;
  }
}
