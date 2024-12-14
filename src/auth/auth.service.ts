import { PrismaService } from './../prisma.service';
import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { RegisterDto } from './dtos/auth.dto';
import { User } from '@prisma/client';
import { hash, compare } from 'bcrypt';
import { JwtService } from '@nestjs/jwt';

@Injectable()
export class AuthService {
  constructor(
    private prismaService: PrismaService,
    private jwtService: JwtService,
  ) {}
  register = async (userData: RegisterDto): Promise<User> => {
    //bước 1: kiểm tra xem email đã được sử dụng chưa
    const user = await this.prismaService.user.findUnique({
      where: {
        email: userData.email,
      },
    });
    if (user) {
      throw new HttpException(
        { message: 'Email này đã được sử dụng.' },
        HttpStatus.BAD_REQUEST,
      );
    }

    // bước 2: mã hóa mật khẩu và lưu vào db

    const hashPassword = await hash(userData.password, 10);

    const res = await this.prismaService.user.create({
      data: { ...userData, password: hashPassword },
    });
    return res;
  };

  login = async (data: { email: string; password: string }): Promise<any> => {
    // bước 1: kiểm tra xem tài khoản này có tồn tại không?
    const user = await this.prismaService.user.findUnique({
      where: {
        email: data.email,
      },
    });
    if (!user) {
      throw new HttpException(
        { message: 'Tài khoản không tồn tại' },
        HttpStatus.UNAUTHORIZED,
      );
    }

    // bước 2: kiểm tra mật khẩu
    const verify = await compare(data.password, user.password);

    if (!verify) {
      throw new HttpException(
        { message: 'Mật khẩu không đúng.' },
        HttpStatus.UNAUTHORIZED,
      );
    }

    // bước 3: tạo token truy cập và token làm mới

    const payload = { id: user.id, name: user.name, email: user.email };

    const accessToken = await this.jwtService.signAsync(payload, {
      secret: process.env.ACCESS_TOKEN_KEY,
      expiresIn: '1h',
    });

    const refreshToken = await this.jwtService.signAsync(payload, {
      secret: process.env.REFRESH_TOKEN_KEY,
      expiresIn: '7d',
    });
    return { accessToken, refreshToken };
  };
}
