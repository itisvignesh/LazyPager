//
//  LazyPager.h
//  ReImagePager
//
//  Created by contus on 24/12/15.
//  Copyright © 2015 contus. All rights reserved.
//
#import <UIKit/UIKit.h>
@interface LazyPager : UIView <UIScrollViewDelegate>
-(void)initWithImageNames:(NSArray *) imageNames;
-(void)initWithImageURLS:(NSArray *) imageURLS;
-(void) initContentView:(NSInteger) viewCount;
@end
