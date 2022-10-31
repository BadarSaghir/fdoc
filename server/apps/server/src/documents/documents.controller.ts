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
import { DocumentCreatedDto } from './dto/document-created.dto';
import {
  ApiForbiddenResponse,
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiProperty,
  ApiTags,
} from '@nestjs/swagger';
export const docControllerRoute = appControllerRoute + '/documents';
class UidI {
  @ApiProperty({
    type: String,
    description: 'This is a required property',
  })
  uid: string;
}
@ApiTags('Document Managing')
@Controller(docControllerRoute)
export class DocumentsController {
  constructor(private readonly documentsService: DocumentsService) {}

  @Post('/create')
  create(
    @Req() req: Request,
    @Body()
    documentCreatedDtomentDto: DocumentCreatedDto,
  ) {
    return this.documentsService.create(req);
  }

  @Get('/me')
  @ApiOkResponse({
    description: 'Sucessfull get documents',
  })
  @ApiForbiddenResponse({ description: 'Unauthorized Request' })
  @ApiNotFoundResponse({ description: 'Resource not found' })
  async findMe(
    @Req()
    req: Request,
    @Body()
    body: UidI,
  ) {
    return this.documentsService.findMe(req);
  }
  static docById = docControllerRoute + '/:id';
  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.documentsService.findOne(id);
  }

  @Patch('/title/:id')
  update(
    @Param('id') id: string,
    @Body() updateDocumentDto: UpdateDocumentDto,
  ) {
    return this.documentsService.update(id, updateDocumentDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.documentsService.remove(id);
  }
}
