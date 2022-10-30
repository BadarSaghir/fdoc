import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class DocumentDto {
  @ApiProperty({
    type: String,
    description: 'This is a required property',
  })
  uid: string;
  @ApiProperty({
    type: String,
    description: 'This is a required property',
  })
  createdAt: number;
  @ApiProperty({
    type: String,
    description: 'This is a required property',
  })
  title: string;
  @ApiPropertyOptional({
    type: String,
    description: 'This is a required property',
  })
  content: Array<string>;
}
