import {
  Body,
  Controller,
  Post,
  Get,
  Query,
  Param,
  ParseIntPipe,
  Put,
  Delete,
} from '@nestjs/common';
import { UserService } from './user.service';
import { User } from '@prisma/client';
import {
  CreateUserDto,
  UpdateUserDto,
  UserFilterType,
  UserPaginationResponseType,
} from './dto/user.dto';

@Controller('users')
export class UserController {
  constructor(private userService: UserService) {}

  @Post()
  create(@Body() body: CreateUserDto): Promise<User> {
    console.log('create user api =>', body);
    return this.userService.create(body);
  }

  @Get()
  getAll(@Query() params: UserFilterType): Promise<UserPaginationResponseType> {
    console.log('get all user api', params);
    return this.userService.getAll(params);
  }
  @Get(':id')
  async getUser(@Param('id') id: string): Promise<User | null> {
    const userId = parseInt(id, 10);
    return this.userService.getUserById(userId);
  }
  @Get(':id/saved-images')
  async getSavedImages(@Param('id') id: string) {
    const userId = parseInt(id, 10);
    return this.userService.getSavedImagesByUserId(userId);
  }
  @Get(':id/created-images')
  async getCreatedImages(@Param('id') id: string) {
    const userId = parseInt(id, 10);
    return this.userService.getCreatedImagesByUserId(userId);
  }
  @Delete(':id/images/:imageId')
  async deleteImage(@Param('imageId') imageId: string) {
    const imgId = parseInt(imageId, 10);
    return this.userService.deleteImageById(imgId);
  }
  @Put(':id')
  update(
    @Param('id', ParseIntPipe) id: number,
    @Body() data: UpdateUserDto,
  ): Promise<User> {
    console.log('update user api=>', id);
    return this.userService.update(id, data);
  }
}
