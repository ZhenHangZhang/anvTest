//
//  UIImage+YPAddtion.h
//  ParkingCopy
//
//  Created by zhanghangzhen on 2017/3/11.
//  Copyright © 2017年 summerxx.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YPAddtion)

+ (UIImage *)circleImageWithname:(NSString *)name
                     borderWidth:(CGFloat)borderWidth
                     borderColor:(UIColor *)borderColor;

/**
 *  保持宽高比设置图片在多大区域显示
 */
+ (UIImage *)sourceImage:(UIImage *)sourceImage
              targetSize:(CGSize)targetSize;

/**
 *  指定宽度按比例缩放
 */
+ (UIImage *)sourceImage:(UIImage *)sourceImage
             targetWidth:(CGFloat)targetWidth;

/**
 *  等比例缩放
 */
+ (UIImage *)sourceImage:(UIImage *)sourceImage
                   scale:(CGFloat)scale;


+ (UIImage *)resizableImageWithImageName:(NSString *)imageName;





/** 压缩图片到指定的物理大小*/
- (NSData *)compressImageDataWithMaxLimit:(CGFloat)maxLimit;

- (UIImage *)compressImageWithMaxLimit:(CGFloat)maxLimit;


+ (UIImage *)imageResizableNamed:(NSString *)name;

+ (UIImage *)imageWatermarkNamed:(NSString *)watermarkName named:(NSString *)name scale:(CGFloat)scale;

+ (UIImage *)imageRoundNamed:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

+ (UIImage *)imageCaptureWithView:(UIView *)view;

+ (UIImage *)imageWithColor:(UIColor *)color;

- (UIColor *)pixelColorAtLocation:(CGPoint)point;




@end
