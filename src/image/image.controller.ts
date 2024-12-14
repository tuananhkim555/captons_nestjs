import { Controller, Get, Post, Body, Param, Query } from '@nestjs/common';
import { ImageService } from './image.service';
import {
  ImagePaginationResponseType,
  ImageFilterType,
  CreateCommentDto,
} from './dto/image.dto';

@Controller('images')
export class ImageController {
  constructor(private imageService: ImageService) {}

  @Get()
  getAll(
    @Query() params: ImageFilterType,
  ): Promise<ImagePaginationResponseType> {
    return this.imageService.getAll(params);
  }

  @Get(':id')
  getImageDetail(@Param('id') id: number) {
    return this.imageService.getImageDetail(id);
  }

  @Get(':id/comments')
  getComments(@Param('id') id: number) {
    return this.imageService.getCommentsByImageId(id);
  }

  @Get(':id/saved')
  isImageSaved(@Param('id') id: number, @Query('userId') userId: number) {
    return this.imageService.isImageSavedByUser(id, userId);
  }

  @Post(':id/comments')
  saveComment(@Param('id') id: number, @Body() commentData: CreateCommentDto) {
    return this.imageService.saveComment({ ...commentData, imageId: id });
  }
}
