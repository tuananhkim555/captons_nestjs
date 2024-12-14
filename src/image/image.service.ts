import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/prisma.service';
import { ImageFilterType, ImagePaginationResponseType } from './dto/image.dto';

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
}
