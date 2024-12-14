import { Module, ValidationPipe } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AuthModule } from './auth/auth.module';
import { APP_PIPE } from '@nestjs/core';
import { UserModule } from './user/user.module';
import { PostModule } from './post/post.module';
import { ImageModule } from './image/image.module';

@Module({
  imports: [AuthModule, UserModule, PostModule, ImageModule],
  controllers: [AppController],
  providers: [
    AppService,
    {
      provide: APP_PIPE,
      useClass: ValidationPipe,
    },
  ],
})
export class AppModule {}
