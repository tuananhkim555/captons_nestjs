import { IsNotEmpty } from 'class-validator';
import { Image as PrismaImage } from '@prisma/client';

export class CreateImageDto {
  @IsNotEmpty()
  title: string;

  @IsNotEmpty()
  url: string;

  status: number;
}

export class CreateCommentDto {
  @IsNotEmpty()
  content: string;

  @IsNotEmpty()
  imageId: number; // Reference to the image
}

export interface ImageFilterType {
  items_per_page?: number;
  page?: number;
  search?: string;
}

export interface ImagePaginationResponseType {
  data: PrismaImage[];
  total: number;
  currentPage: number;
  itemsPerPage: number;
}
