//
//  SecoundViewController.m
//  DDThemeKit
//
//  Created by 许龙 on 2020/3/13.
//  Copyright © 2020 ldd. All rights reserved.
//

#import "SecoundViewController.h"
#import "NSObject+Theme.h"

@interface SecoundViewController ()

@property (nonatomic, strong) NSMutableArray *list;

@end

@implementation SecoundViewController

- (NSMutableArray *)list {
    if (!_list) {
        _list = [NSMutableArray array];
    }
    return _list;
}

- (void)dealloc {
    NSLog(@"SecoundViewController dealloc...");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    void (^block)(void) = ^ {
//        self.view.backgroundColor = [UIColor whiteColor];
//    };
//    __weak typeof(self) wself = self;
//    [self add_themeBlock:^{
//        __strong typeof(wself) sself = wself;
//        block();
//    }];
    
    AddThemeProvider(self, ^(DDTraitCollection * _Nonnull traitCollection) {
        if (traitCollection.userInterfaceStyle == DDUserInterfaceStyleLight) {
            self.view.backgroundColor = [UIColor whiteColor];
        } else {
            self.view.backgroundColor = [UIColor blackColor];
        }
    });
}

- (void)add_themeBlock:(void (^)(void))block {
    block();
    
    [self.list addObject:block];
}

- (IBAction)changeTheme:(id)sender {
    if ([DDThemeManager manager].currentTraitCollection.userInterfaceStyle == DDUserInterfaceStyleLight) {
        [[DDThemeManager manager] setCurrentTraitCollection:[DDTraitCollection traitCollectionWithUserInterfaceStyle:DDUserInterfaceStyleDark]];
    } else {
        [[DDThemeManager manager] setCurrentTraitCollection:[DDTraitCollection traitCollectionWithUserInterfaceStyle:DDUserInterfaceStyleLight]];
    }
}

@end
