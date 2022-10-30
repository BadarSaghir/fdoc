import { PartialType } from '@nestjs/mapped-types';
import { DocumentDto } from './document.dto';

export class UpdateDocumentDto {
  title: string;
}
