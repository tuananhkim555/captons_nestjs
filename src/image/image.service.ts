import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/prisma.service';
import {
  CreateCommentDto,
  ImageFilterType,
  ImagePaginationResponseType,
} from './dto/image.dto';
import { Image, CommentImage } from '@prisma/client';

@Injectable()
export class ImageService {
  constructor(private prismaService: PrismaService) {}

  async getAll(filters: ImageFilterType): Promise<ImagePaginationResponseType> {
    const items_per_page = Number(filters.items_per_page) || 10;
    const page = Number(filters.page) || 1;
    const search = filters.search || '';
    const skip = page > 1 ? (page - 1) * items_per_page : 0;

    const images = await this.prismaService.image.findMany({
      take: items_per_page,
      skip: skip,
      where: {
        title: {
          contains: search,
        },
      },
    });

    const total = await this.prismaService.image.count({
      where: {
        title: {
          contains: search,
        },
      },
    });

    return {
      data: images,
      total,
      currentPage: page,
      itemsPerPage: items_per_page,
    };
  }

  async getImageDetail(id: number): Promise<Image | null> {
    return this.prismaService.image.findUnique({
      where: { id },
      include: { owner: true }, // Ensure 'owner' is a valid relation in your schema
    });
  }

  async getCommentsByImageId(imageId: number): Promise<CommentImage[]> {
    return this.prismaService.commentImage.findMany({
      where: { imageId }, // Ensure imageId is correctly referenced
    });
  }

  async isImageSavedByUser(imageId: number, userId: number): Promise<boolean> {
    const savedImage = await this.prismaService.savedImage.findUnique({
      where: {
        imageId_userId: {
          imageId,
          userId,
        },
      },
    });
    return savedImage !== null; // Return true if saved, false otherwise
  }

  async saveComment(data: CreateCommentDto): Promise<CommentImage> {
    return this.prismaService.commentImage.create({
      data: {
        content: data.content,
        imageId: data.imageId, // Ensure this is included
      },
    });
  }
}
