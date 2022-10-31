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

import { DocumentsService } from './documents/documents.service';

@WebSocketGateway({
  cors: {
    origin: '*',
  },
})
export class AppGateway
  implements OnGatewayInit, OnGatewayConnection, OnGatewayDisconnect
{
  constructor(private documentService: DocumentsService) {}
  @WebSocketServer() server: Server;
  private logger: Logger = new Logger('AppGateway');

  afterInit(server: Server) {
    this.logger.log('Init' + server.eventNames.toString());
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
  @SubscribeMessage('typing')
  handleTyping(client: Socket, data: { room: string; delta: string }): void {
    this.logger.log(`handleTyping client id:${client.id},document join `);
    client.broadcast.to(data.room).emit('changes', data);
  }
  @SubscribeMessage('save')
  async handleSave(
    client: Socket,
    data: { room: string; delta: string[] },
  ): Promise<void> {
    this.logger.log(`handleSave client id:${client.id},document join `);
    await this.documentService.getDocumentDelta(data.delta, data.room);
  }
}
