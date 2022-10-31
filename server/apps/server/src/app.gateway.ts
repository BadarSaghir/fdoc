import {
  SubscribeMessage,
  WebSocketGateway,
  OnGatewayInit,
  WebSocketServer,
  OnGatewayConnection,
  OnGatewayDisconnect,
} from '@nestjs/websockets';
import { Logger } from '@nestjs/common';
import { Socket, Server } from 'socket.io';

@WebSocketGateway({
  cors: {
    origin: '*',
  },
})
export class AppGateway
  implements OnGatewayInit, OnGatewayConnection, OnGatewayDisconnect
{
  @WebSocketServer() server: Server;
  private logger: Logger = new Logger('AppGateway');

  afterInit(server: Server) {
    this.logger.log('Init');
    // throw new Error('Method not implemented.');
  }
  handleConnection(client: Socket, ...args: any[]) {
    this.logger.log(`handling connection and connected to:${client.id}`);
  }
  handleDisconnect(client: Socket) {
    // throw new Error('Method not implemented.');
    this.logger.log(`Client disconnected: ${client.id}`);
  }
  @SubscribeMessage('join')
  handleMessage(client: Socket, documentId: string): void {
    this.logger.log(
      `handleMessage-Join client id:${client.id},document join ${documentId}`,
    );
    client.join(documentId);
  }
}
