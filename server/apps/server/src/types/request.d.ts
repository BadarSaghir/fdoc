import { Request } from 'express';
type TRequest = Request;
export declare module 'express' {
  export interface Request extends TRequest {
    user?: string;
    token?: string;
    get(name: 'set-cookie'): string[] | undefined;
    get(name: string): string | undefined;

    header(name: 'set-cookie'): string[] | undefined;
    header(name: string): string | undefined;
    header(name: 'x-auth-token'): string | undefined;
  }
  Header;
}
