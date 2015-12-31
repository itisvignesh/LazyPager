//
//  ViewController.m
//  ReImagePager
//
//  Created by contus on 24/12/15.
//  Copyright © 2015 contus. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *urlString = [NSString stringWithContentsOfURL:[NSURL URLWithString: @"http://jsonplaceholder.typicode.com/photos"] encoding:NSUTF8StringEncoding error:nil];
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[urlString dataUsingEncoding:NSUTF8StringEncoding] options:NSUTF8StringEncoding error:nil];
    [_iamgePager initWithImageURLS:[dictionary valueForKey:@"thumbnailUrl"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}
@end
