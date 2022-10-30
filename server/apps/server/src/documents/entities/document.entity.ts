import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document as doc } from 'mongoose';

export type DocumentDocument = Document & doc;

@Schema()
export class Document {
  @Prop({ required: true, type: String })
  uid: string;

  @Prop({ required: true, type: Number })
  createdAt: number;

  @Prop({ required: true, type: String, trim: true })
  title: string;

  @Prop({ type: Array, default: [String] })
  content: Array<string>;
}

export const DocumentSchema = SchemaFactory.createForClass(Document);
