import { ApiProperty } from '@nestjs/swagger';

export class UpdateDocumentDto {
  @ApiProperty({
    type: String,
    description: 'This is a required property',
  })
  title: string;
}
