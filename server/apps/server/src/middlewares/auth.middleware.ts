import { Injectable, NestMiddleware } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { Request, Response, NextFunction } from 'express';
@Injectable()
export class AuthMiddleware implements NestMiddleware {
  constructor(private jwtService: JwtService) {}
  async use(req: Request, res: Response, next: NextFunction) {
    try {
      const token: string = req.header('x-auth-token');

      if (!token)
        res
          .status(401)
          .json({ message: 'Un-Authorize, Please provide token for route' });
      console.log('token:', token);
      const verify = await this.jwtService.verifyAsync<{ id: string }>(token);
      if (!verify)
        res.status(401).json({ message: 'Token verification issue' });
      req.user = verify.id;
      req.token = token;
      next();
    } catch (error) {
      console.log(error);
      res.status(500).json({ error: error });
    }
  }
}
