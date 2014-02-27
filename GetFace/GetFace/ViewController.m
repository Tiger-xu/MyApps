//
//  ViewController.m
//  GetFace
//
//  Created by Tiger on 14-2-26.
//  Copyright (c) 2014年 Tiger. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

-(UIImage*) faceImage:(UIImage *) img
{
    CIImage *ciimg = [[CIImage alloc] initWithImage:img];
    NSDictionary *detectorOptions = [[NSDictionary alloc] initWithObjectsAndKeys:CIDetectorAccuracyLow, CIDetectorAccuracy, nil];
    CIDetector *faceDetector;
    faceDetector = [CIDetector detectorOfType:CIDetectorTypeFace context:nil options:detectorOptions];
    NSArray *features = [faceDetector featuresInImage:ciimg];
    
    NSLog(@"%@", features);
    
    for ( CIFaceFeature *ff in features ) {
        CGRect faceRect = [ff bounds];
        faceRect.origin.y = img.size.height - faceRect.origin.y - faceRect.size.height;
        CGImageRef cgimg = CGImageCreateWithImageInRect(img.CGImage, faceRect);
        UIImage *myimg = [UIImage imageWithCGImage:cgimg];
        return myimg;
    }
    return nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIImage *faceImage = [self faceImage:[UIImage imageNamed:@"2.jpg"]];
    UIImageView *iv = [[UIImageView alloc] initWithImage:faceImage];
    [self.view addSubview:iv];
    iv.frame = CGRectMake(10, 3, 300, 500);
    iv.contentMode = UIViewContentModeScaleAspectFill;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
