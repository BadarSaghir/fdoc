import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  Req,
} from '@nestjs/common';
import { appControllerRoute } from '../controllers/app.controller';
import { DocumentsService } from './documents.service';
import { DocumentDto } from './dto/document.dto';
import { UpdateDocumentDto } from './dto/update-document.dto';
import { Request } from 'express';
const docControllerRoute = appControllerRoute + '/documents';

@Controller(docControllerRoute)
export class DocumentsController {
  constructor(private readonly documentsService: DocumentsService) {}

  @Post('/create')
  create(@Req() req: Request) {
    return this.documentsService.create(req);
  }

  @Get('/me')
  async findMe(@Req() req: Request) {
    return this.documentsService.findMe(req);
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.documentsService.findOne(+id);
  }

  @Patch('/title/:id')
  update(
    @Param('id') id: string,
    @Body() updateDocumentDto: UpdateDocumentDto,
  ) {
    return this.documentsService.update(+id, updateDocumentDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.documentsService.remove(+id);
  }
}
