//
//  ViewController.m
//  EnvModify
//
//  Created by aleck on 20/03/2018.
//  Copyright © 2018 aleck. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UILabel *infoLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
#if TEST // 测试环境
#if DEBUG
    self.infoLabel.text = @"hello test env debug";
#else
    self.infoLabel.text = @"hello test env release";
#endif
#endif
#if RELEASE // 发布环境
#if DEBUG
    self.infoLabel.text = @"hello release env debug";
#else
    self.infoLabel.text =@"hello release env release";
#endif
#endif
#if ADHOC // 预发布环境
#if DEBUG
    self.infoLabel.text = @"hello pre-relase env debug";
#else
    self.infoLabel.text = @"hello pre-relase env release";
#endif
#endif
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
