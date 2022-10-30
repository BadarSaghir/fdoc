import { ApiProperty } from '@nestjs/swagger';

export class DocumentCreatedDto {
  @ApiProperty({
    type: String,
    description: 'This is a required property which create document',
  })
  createdAt: string;
}
