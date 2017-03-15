# UIImage tips


 #### - **Capture a view and save as UIImage.**

```
#import <QuartzCore/QuartzCore.h>

+ (UIImage *) imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];

    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
```

#### - **Set UIColor for UIImage**

```
// By set tint color of UIImageView, can set image color. 
UIImage *Image = [UIImage imageName：@"......."];
UIImageView *imageView = [[UIImageView alloc] init];
imageView.image = [Image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];    
imageView.tintColor = [UIColor redColor];

```