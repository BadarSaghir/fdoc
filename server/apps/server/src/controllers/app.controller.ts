import { Body, Controller, Get, Post, Req } from '@nestjs/common';
import { AppService } from '../services/app.service';
import { FdocPostDto } from '../interfaces/fdoc-post-dto.interface';
import { User } from '../schemas/user.schema';

export const appControllerRoute = '/api/v1/fdoc';
export const appControllerSignupRoute = 'signup';
export const appControllerGetFDocRoute = '/';

@Controller(appControllerRoute)
export class AppController {
  constructor(private readonly appService: AppService) {}
  @Get(appControllerGetFDocRoute)
  getFDoc(): string {
    return this.appService.getFDoc();
  }

  @Post(appControllerSignupRoute)
  async SignUp(
    @Body() body: FdocPostDto,
  ): Promise<{ res: string; user?: User }> {
    return await this.appService.signUp(body);
  }
}
