import {
  Controller,
  Post,
  Body,
  Get,
  Query,
  Param,
  ParseIntPipe,
  Put,
} from '@nestjs/common';
import { Post as PostModel } from '@prisma/client';
import {
  CreatePostDto,
  PostFilterType,
  PostPaginationResponseType,
  UpdatePostDto,
} from './dto/post.dto';
import { PostService } from './post.service';

@Controller('posts')
export class PostController {
  constructor(private postService: PostService) {}

  @Post()
  create(@Body() data: CreatePostDto): Promise<PostModel> {
    return this.postService.create(data);
  }
  @Get()
  getAll(@Query() params: PostFilterType): Promise<PostPaginationResponseType> {
    console.log('get all post => ', params);
    return this.postService.getAll(params);
  }
  @Get(':id')
  getDetail(@Param('id', ParseIntPipe) id: number): Promise<PostModel> {
    return this.postService.getDetail(id);
  }

  @Put(':id')
  update(
    @Param('id', ParseIntPipe) id: number,
    @Body() data: UpdatePostDto,
  ): Promise<PostModel> {
    return this.postService.update(id, data);
  }
}
