//
//  ViewController.m
//  DDThemeKit
//
//  Created by 许龙 on 2020/3/13.
//  Copyright © 2020 ldd. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+Theme.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    AddThemeProvider(self, ^(DDTraitCollection * _Nonnull traitCollection) {
        if (traitCollection.userInterfaceStyle == DDUserInterfaceStyleLight) {
            self.view.backgroundColor = [UIColor whiteColor];
        } else {
            self.view.backgroundColor = [UIColor blackColor];
        }
    });
}

@end
