
#import "SDWebImageManager.h"
#import <UIKit/UIKit.h>

@interface AnyImageView : UIView <SDWebImageManagerDelegate> {
    UIImageView* imageView;
    UIActivityIndicatorView* spinner;
}

- (id)initWithFrame:(CGRect)frame picPath:(NSString*)tnPath isWhite:(BOOL)isWhite;
- (void)loadImageFromWeb:(NSString*)tnPath;
- (void)updateImageViewFrame;
- (void)cancelAllDownloadings;

@end
