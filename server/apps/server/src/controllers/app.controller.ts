import { Body, Controller, Get, Post, Req } from '@nestjs/common';
import { AppService } from '../services/app.service';
import { FdocPostDto } from '../interfaces/fdoc-post-dto.interface';
import { User } from '../schemas/user.schema';
import { Request } from 'express';
import { ApiTags } from '@nestjs/swagger';
export const appControllerRoute = '/api/v1/fdoc';
export const appControllerSignupRoute = 'signup';
export const appControllerIndexRoute = '/';
@ApiTags('Authentication')
@Controller(appControllerRoute)
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get(appControllerIndexRoute)
  async index(@Req() req: Request): Promise<{
    user?: User;
    token?: string;
  }> {
    return await this.appService.index(req);
  }

  @Post(appControllerSignupRoute)
  async signUp(
    @Body() body: FdocPostDto,
  ): Promise<{ res: string; user?: User }> {
    return await this.appService.signUp(body);
  }
}
