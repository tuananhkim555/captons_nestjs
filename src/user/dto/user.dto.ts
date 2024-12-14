import { User } from '@prisma/client';
import {
  IsEmail,
  IsNotEmpty,
  IsOptional,
  Matches,
  MinLength,
} from 'class-validator';

export class CreateUserDto {
  @IsNotEmpty()
  name: string;

  @Matches(/^\d+$/)
  phone: string;

  @IsNotEmpty()
  @IsEmail()
  email: string;

  @IsNotEmpty()
  @MinLength(6)
  password: string;

  status: number;
}

export class UpdateUserDto {
  name: string;

  @IsOptional()
  @Matches(/^\d+$/)
  phone: string;

  status: number;
}

// filter search
export interface UserFilterType {
  items_per_page?: number;
  page?: number;
  search?: string;
}

export interface UserPaginationResponseType {
  data: User[];
  total: number;
  currentPage: number;
  itemsPerPage: number;
}
