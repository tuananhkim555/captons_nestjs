import {
  Body,
  Controller,
  Post,
  Get,
  Query,
  Param,
  ParseIntPipe,
  Put,
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
  getDetail(@Param('id', ParseIntPipe) id: number): Promise<User> {
    console.log('get detail user ap=>', id);
    return this.userService.getDetail(id);
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
