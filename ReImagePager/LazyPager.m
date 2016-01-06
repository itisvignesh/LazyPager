//
//  LazyPager.m
//  ReImagePager
//
//  Created by contus on 24/12/15.
//  Copyright © 2015 contus. All rights reserved.
//

#import "LazyPager.h"

@interface LazyPager ()
@property UIScrollView *contentView;
@property NSArray *imageURLs;
@property NSMutableArray *stackArray;
@property NSInteger historyPage;
@end
@implementation LazyPager
@synthesize contentView;

- (void)initWithImageNames:(NSArray *)imageNames{
    [self initContentView:imageNames.count];
}
-(void)initWithImageURLS:(NSArray *)imageURLS{
    _imageURLs = imageURLS;
    [self initContentView:imageURLS.count];
    
}
-(void) initContentView:(NSInteger) viewCount {
    _historyPage=0;
    CGRect contentRect = CGRectMake(0, 0,320, self.frame.size.height);
    contentView  = [[UIScrollView alloc] initWithFrame:contentRect];
    CGSize contentSize = CGSizeMake(320*viewCount, self.frame.size.height);
    [contentView setContentSize:contentSize];
    [contentView setPagingEnabled:YES];
    [contentView setShowsHorizontalScrollIndicator:NO];
    [contentView setShowsVerticalScrollIndicator:NO];
    [self addSubview:contentView];
    [self loadNextPage:-1];
    [self loadNextPage:0];
    [contentView setDelegate:self];
}
-(void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger currentPage = floor((scrollView.contentOffset.x+scrollView.frame.size.width)/scrollView.frame.size.width);
    currentPage--;
    if(_historyPage<currentPage){
    [self loadNextPage:currentPage];
    }else{
        [self loadPreviousPage:currentPage];
    }
    _historyPage = currentPage;
}

-(void) loadNextPage:(NSInteger) currentPage{
    currentPage++;
    UIImageView *imageView;
    if (_stackArray.count>2) {
        imageView = _stackArray[0];
        [imageView removeFromSuperview];
        [_stackArray removeObjectAtIndex:0];
    }else{
        imageView= [[UIImageView alloc]
                    init];
    }
    [imageView setImage:nil];
    NSURL *url = [NSURL URLWithString:_imageURLs[currentPage]];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *img = [[UIImage alloc] initWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            [imageView setImage:img];
            [imageView setNeedsDisplay];
        });
    });
    [imageView setFrame:CGRectMake(currentPage*320, 0, 320, self.frame.size.width)];
    [contentView addSubview:imageView];
    [self pushViewToStack:imageView];
}
-(void)loadPreviousPage:(NSInteger) currentPage {
    if(currentPage!=0){
    currentPage--;
    UIImageView *imageView;
    if (_stackArray.count>2) {
        imageView = _stackArray[0];
        [imageView removeFromSuperview];
        [_stackArray removeObjectAtIndex:0];
    }else{
        imageView= [[UIImageView alloc]
                    init];
    }
    [imageView setImage:nil];
    NSURL *url = [NSURL URLWithString:_imageURLs[currentPage]];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *img = [[UIImage alloc] initWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            [imageView setImage:img];
            [imageView setNeedsDisplay];
        });
    });
    [imageView setFrame:CGRectMake(currentPage*320, 0, 320, self.frame.size.width)];
    [contentView addSubview:imageView];
    [self pushViewToStack:imageView];
    }
}
-(void) pushViewToStack:(id) view {
    if(!_stackArray)
        _stackArray = [NSMutableArray array];
    [_stackArray addObject:view];
}
@end
