import { IsEmail, IsNotEmpty, Matches, MinLength } from 'class-validator';

export class RegisterDto {
  @IsNotEmpty()
  name: string;

  @Matches(/^\d+$/)
  phone: string;

  @IsEmail()
  email: string;

  @MinLength(6)
  password: string;

  status: number;
}
export class LoginDto {
  @IsEmail()
  email: string;

  @IsNotEmpty()
  @MinLength(6)
  password: string;
}
