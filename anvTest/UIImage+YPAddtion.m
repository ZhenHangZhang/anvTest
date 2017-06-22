//
//  UIImage+YPAddtion.m
//  ParkingCopy
//
//  Created by zhanghangzhen on 2017/3/11.
//  Copyright © 2017年 summerxx.com. All rights reserved.
//

#import "UIImage+YPAddtion.h"

@implementation UIImage (YPAddtion)
/** 压缩图片到指定的物理大小*/
- (NSData *)compressImageDataWithMaxLimit:(CGFloat)maxLimit {
    
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.2f; // 最大压缩品质
    NSData *imageData = UIImageJPEGRepresentation(self, compression);
    NSInteger imageDataLength = [imageData length];
    while ((imageDataLength <= maxLimit * 1024 * 1024) && (compression >= maxCompression)) {
        compression -= 0.03;
        imageData = UIImageJPEGRepresentation(self, compression);
        imageDataLength = [imageData length];
    }
    return imageData;
}

- (UIImage *)compressImageWithMaxLimit:(CGFloat)maxLimit {
    NSData *imageData = [self compressImageDataWithMaxLimit:maxLimit];
    UIImage *compressedImage = [UIImage imageWithData:imageData];
    return compressedImage;
}

// 头像类型
+ (UIImage *)circleImageWithname:(NSString *)name borderWidth:(CGFloat)borderWidth
                     borderColor:(UIColor *)borderColor {
    
    
    UIImage *oldImage = [UIImage imageNamed:name];
    
    // 1. 开启上下文
    CGFloat imageW = oldImage.size.width + 22 * borderWidth;
    CGFloat imageH = oldImage.size.height + 22 * borderWidth;
    CGSize imageSize = CGSizeMake(imageW, imageH    );
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    // 获取当前上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 花边框，大圆
    [borderColor set];
    
    CGFloat bigRadius = imageW * 0.5f;
    CGFloat centerX = bigRadius;
    CGFloat centerY = bigRadius;
    CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx);
    
    // 小圆
    CGFloat smallRadius = bigRadius - borderWidth;
    CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    CGContextClip(ctx);
    
    [oldImage drawInRect:CGRectMake(borderWidth, borderWidth, oldImage.size.width, oldImage.size.height)];
    
    // 取图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

// 指定大小，要把图显示到多大的区域
+ (UIImage *)sourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0f;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointZero;
    
    if(CGSizeEqualToSize(imageSize, targetSize) == NO){
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
            
        }
        else{
            
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        if(widthFactor > heightFactor){
            
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if (!newImage) {
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

// 指定宽度，按比例缩放
+ (UIImage *)sourceImage:(UIImage *)sourceImage targetWidth:(CGFloat)targetWidth {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if(CGSizeEqualToSize(imageSize, size) == NO){
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        if(widthFactor > heightFactor){
            
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
            
        }else if(widthFactor < heightFactor){
            
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
        
        NSLog(@"scale image fail");
    }
    UIGraphicsEndImageContext();
    
    return newImage;
    
}


+ (UIImage *)resizableImageWithImageName:(NSString *)imageName {
    UIImage *loginImage = [UIImage imageNamed:imageName];
    CGFloat topEdge = loginImage.size.height * 0.5;
    CGFloat leftEdge = loginImage.size.width * 0.5;
    return [loginImage resizableImageWithCapInsets:UIEdgeInsetsMake(topEdge, leftEdge, topEdge, leftEdge)];
}

// 根据指定比例缩放图片
+ (UIImage *)sourceImage:(UIImage *)sourceImage scale:(CGFloat)scale {
    if (scale > 1) {
        return sourceImage;
    }
    
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGPoint targetPoint = CGPointZero;
    targetPoint.x = (imageSize.width - imageSize.width * scale) * 0.5f;
    targetPoint.y = (imageSize.height - imageSize.height * scale) * 0.5f;
    
    CGFloat imageW = imageSize.width;
    CGFloat imageH = imageSize.height;
    CGFloat targetWidth = imageW * scale;
    CGFloat targetHeight = imageH * scale;
    CGRect targetRect = (CGRect){targetPoint, CGSizeMake(targetWidth, targetHeight)};
    [sourceImage drawInRect:targetRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if (!newImage) {
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}
+ (UIImage *)imageResizableNamed:(NSString *)name {
    
    UIImage * image = [UIImage imageNamed:name];
    CGFloat width = image.size.width * 0.5f;
    CGFloat height = image.size.height * 0.5f;
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(height, width, height, width)];
}

+ (UIImage *)imageWatermarkNamed:(NSString *)watermarkName named:(NSString *)name scale:(CGFloat)scale {
    
    UIImage * background = [UIImage imageNamed:name];
    UIGraphicsBeginImageContextWithOptions(background.size, NO, 0.0f);
    [background drawInRect:CGRectMake(0, 0, background.size.width, background.size.height)];
    
    UIImage * watermark = [UIImage imageNamed:watermarkName];
    CGFloat watermarkW = watermark.size.width * scale;
    CGFloat watermarkH = watermark.size.height * scale;
    CGFloat watermarkX = background.size.width - watermarkW - 8;
    CGFloat watermarkY = background.size.height - watermarkH - 8;
    [watermark drawInRect:CGRectMake(watermarkX, watermarkY, watermarkW, watermarkH)];
    
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)imageRoundNamed:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    
    UIImage * original = [UIImage imageNamed:name];
    CGFloat originalW = original.size.width + 2 * borderWidth;
    CGFloat originalH = original.size.height + 2 * borderWidth;
    CGSize originalSize = CGSizeMake(originalW, originalH);
    UIGraphicsBeginImageContextWithOptions(originalSize, NO, 0.0f);
    
    CGContextRef context = UIGraphicsGetCurrentContext(); [borderColor set];
    CGFloat ex_radius = originalW * 0.5f;
    CGFloat centerX = ex_radius;
    CGFloat centerY = ex_radius;
    CGContextAddArc(context, centerX, centerY, ex_radius, 0, M_PI * 2, 0);
    CGContextFillPath(context);
    CGFloat in_radius = ex_radius - borderWidth;
    CGContextAddArc(context, centerX, centerY, in_radius, 0, M_PI * 2, 0);
    
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0, 0, 10, 10);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)imageCaptureWithView:(UIView *)view {
    
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0f);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIColor *)pixelColorAtLocation:(CGPoint)point {
    
    UIColor *color         = nil;
    CGImageRef inImage     = self.CGImage;
    CGContextRef contexRef = [self ARGBBitmapContextFromImage:inImage];
    if (contexRef == NULL) return nil;
    
    size_t w = CGImageGetWidth(inImage);
    size_t h = CGImageGetHeight(inImage);
    CGRect rect = {{0,0},{w,h}};
    
    CGContextDrawImage(contexRef, rect, inImage);
    
    unsigned char * data = CGBitmapContextGetData (contexRef);
    if (data != NULL) {
        
        int offset = 4 * ((w * round(point.y))+round(point.x));
        int alpha  = data[offset];
        int red    = data[offset+1];
        int green  = data[offset+2];
        int blue   = data[offset+3];
        color      = [UIColor colorWithRed:(red/255.0f) green:(green/255.0f) blue:(blue/255.0f) alpha:(alpha/255.0f)];
    }
    CGContextRelease(contexRef);
    if (data) { free(data); }
    
    return color;
}

- (CGContextRef)ARGBBitmapContextFromImage:(CGImageRef) inImage {
    
    CGContextRef    context = NULL;
    CGColorSpaceRef colorSpace;
    void *          bitmapData;
    size_t          bitmapByteCount;
    size_t          bitmapBytesPerRow;
    size_t pixelsWide = CGImageGetWidth(inImage);
    size_t pixelsHigh = CGImageGetHeight(inImage);
    
    bitmapBytesPerRow   = (pixelsWide * 4);
    bitmapByteCount     = (bitmapBytesPerRow * pixelsHigh);
    
    colorSpace = CGColorSpaceCreateDeviceRGB();
    if (colorSpace == NULL) {
        fprintf(stderr, "Error allocating color space\n");
        return NULL;
    }
    
    bitmapData = malloc( bitmapByteCount );
    if (bitmapData == NULL) {
        fprintf (stderr, "Memory not allocated!");
        CGColorSpaceRelease( colorSpace );
        return NULL;
    }
    
    context = CGBitmapContextCreate (bitmapData,
                                     pixelsWide,
                                     pixelsHigh,
                                     8,
                                     bitmapBytesPerRow,
                                     colorSpace,
                                     (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    if (context == NULL) {
        free (bitmapData);
        fprintf (stderr, "Context not created!");
    }
    CGColorSpaceRelease(colorSpace);
    
    return context;
}

@end
