import { Controller, Get, Query } from '@nestjs/common';
import { ImageService } from './image.service';
import { ImagePaginationResponseType, ImageFilterType } from './dto/image.dto';

@Controller('images')
export class ImageController {
  constructor(private imageService: ImageService) {}

  @Get()
  getAll(
    @Query() params: ImageFilterType,
  ): Promise<ImagePaginationResponseType> {
    return this.imageService.getAll(params);
  }
}
