import { JwtService } from '@nestjs/jwt';
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
  constructor(
    @InjectModel(User.name) private userModel: Model<UserDocument>,
    private jwtService: JwtService,
  ) {}
  async use(
    req: Request<
      any,
      any,
      FdocPostDto & { googleToken?: string; idT?: string }
    >,
    res: Response,
    next: NextFunction,
  ) {
    console.log('middleware');
    let exception: HttpException;
    try {
      console.log('middleware in try');

      const { email, name, profilePic, googleToken, idT } = req.body;
      console.log('middleware body');

      console.log(googleToken);
      if (idT) console.log(idT);
      if (googleToken) {
        const response = await fetch(
          'https://oauth2.googleapis.com/tokeninfo?id_token=' + googleToken,
          {
            method: 'GET', // *GET, POST, PUT, DELETE, etc.
            // mode: 'cors', // no-cors, *cors, same-origin
            // cache: 'no-cache', // *default, no-cache, reload, force-cache, only-if-cached
            // headers: {
            //   'Content-Type': 'application/json',
            //   // 'Content-Type': 'application/x-www-form-urlencoded',
            // },
            // redirect: 'follow', // manual, *follow, error
            // referrerPolicy: 'no-referrer', // no-referrer, *no-referrer-when-downgrade, origin, origin-when-cross-origin, same-origin, strict-origin, strict-origin-when-cross-origin, unsafe-url
            // body: JSON.stringify({
            //   grant_type: 'authorization_code',
            //   redirect_url: 'http://localhost:3000',
            //   scope: '',
            // }), // body data type must match "Content-Type" header
          },
        );
        console.log(response.json());
      }

      if (!email || !name || !profilePic) throw error('Bad Request by client');
      const user = await this.userModel.findOne({ email: email });
      if (!user) next();
      else {
        const token = await this.jwtService.signAsync({ id: user._id });
        res.status(200).json({ res: 'user sign successfully', user, token });
      }
    } catch (e) {
      console.log('middleware Error', e);
      exception = new HttpException('Bad Request', HttpStatus.BAD_REQUEST);
    }
    if (exception) throw exception;
  }
}
