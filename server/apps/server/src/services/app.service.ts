import { Request } from 'express';
import { Injectable } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { FdocPostDto } from '../interfaces/fdoc-post-dto.interface';
import { User, UserDocument } from '../schemas/user.schema';

@Injectable()
export class AppService {
  constructor(
    @InjectModel(User.name) private userModel: Model<UserDocument>,
    private jwtService: JwtService,
  ) {}

  async signUp(
    body: FdocPostDto,
  ): Promise<{ res: string; user?: User; token?: string }> {
    try {
      const { email, name, profilePic } = body;
      const userSave = new this.userModel({
        name: name,
        email: email,
        profilePic: profilePic,
      });

      const user = await userSave.save();
      console.log('User Created Successfully');
      const token = await this.jwtService.signAsync({ id: user._id });
      return { res: 'user created successfully', user, token };
    } catch (error) {
      console.log('An Error Occur');
      return { res: 'Error Occur!' };
    }
  }

  async index(req: Request): Promise<{ user?: User; token?: string }> {
    const user = await this.userModel.findById(req.user);
    const token = req.token;
    return { user, token };
  }
}
