import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { UpdateDocumentDto } from './dto/update-document.dto';
import { Request } from 'express';
import { Document, DocumentDocument } from './entities/document.entity';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { DocumentCreatedDto } from './dto/document-created.dto';

@Injectable()
export class DocumentsService {
  constructor(
    @InjectModel(Document.name) private documentModel: Model<DocumentDocument>,
  ) {}

  async create(req: Request<any, any, DocumentCreatedDto>) {
    try {
      const { createdAt } = req.body;
      const document = new this.documentModel({
        uid: req.user,
        title: 'Untitled Document',
        createdAt: createdAt,
      });
      const documents = await document.save();
      return { documents };
    } catch (e) {
      throw new HttpException(
        { 'Internal Server  Error ': e.message },
        HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }

  async findMe(req: Request) {
    try {
      const documents = await this.documentModel.find({ uid: req.user });
      return { documents };
    } catch (e) {
      throw new HttpException(
        { 'Internal Server  Error ': e.message },
        HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }

  async findOne(id: number) {
    try {
      const document = await this.documentModel.findById(id);
      return { document };
    } catch (e) {
      throw new HttpException(
        { 'Internal Server  Error ': e.message },
        HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }

  async update(id: number, updateDocumentDto: UpdateDocumentDto) {
    try {
      const { title } = updateDocumentDto;
      const document = await this.documentModel.findByIdAndUpdate(id, {
        title,
      });
      return { document };
    } catch (e) {
      throw new HttpException(
        { 'Internal Server  Error ': e.message },
        HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }

  async remove(id: number) {
    try {
      const document = await this.documentModel.findByIdAndRemove(id);
      return { document };
    } catch (e) {
      throw new HttpException(
        { 'Internal Server  Error ': e.message },
        HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }
}