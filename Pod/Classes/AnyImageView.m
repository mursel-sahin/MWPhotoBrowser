
#import "AnyImageView.h"

@implementation AnyImageView

- (id)initWithFrame:(CGRect)frame picPath:(NSString*)tnPath isWhite:(BOOL)isWhite
{
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
        [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];

        // NSLog(@"tnPath %@",tnPath);
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:imageView];

        if (isWhite) {
            spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        } else {
            spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        }
        spinner.hidesWhenStopped = YES;
        [spinner setCenter:CGPointMake(frame.size.width / 2, frame.size.height / 2)];
        [self addSubview:spinner];
        [self loadImageFromWeb:tnPath];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)loadImageFromWeb:(NSString*)tnPath
{
    [spinner startAnimating];
    SDWebImageManager* manager = [SDWebImageManager sharedManager];
    NSURL* url = [NSURL URLWithString:tnPath];
    [manager downloadWithURL:url
                     options:0
                    progress:nil
                   completed:^(UIImage* image, NSError* error, SDImageCacheType cacheType, BOOL finished) {
                       if (imageView) {
                           imageView.image = image;
                       }
                       [spinner stopAnimating];

                   }];
}

- (void)webImageManager:(SDWebImageManager*)imageManager didFinishWithImage:(UIImage*)image
{
    //memory warning verdiginde imageviewlar nil yapildigindan imageviewi bulamayabilir
    if (imageView) {
        imageView.image = image;
    }
    [spinner stopAnimating];
}

//- (void)imageDownloader:(SDWebImageDownloader *)downloader didFailWithError:(NSError *)error{
//	[spinner stopAnimating];
//}

- (void)updateImageViewFrame
{

    CGRect frame = [imageView frame];
    frame.origin.x = 0;
    frame.origin.y = 0;
    frame.size.width = self.frame.size.width;
    frame.size.height = self.frame.size.height;
    [imageView setFrame:frame];
    if (imageView.image.size.width > self.frame.size.width || imageView.image.size.height > self.frame.size.height) {
        [imageView setContentMode:UIViewContentModeScaleAspectFit];
    } else {
        [imageView setContentMode:UIViewContentModeCenter];
    }
}

@end
