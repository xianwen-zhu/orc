//
//  ORCPluginRegister.m
//  ios_workarea
//
//  Created by xianwen zhu on 2022/3/22.
//  Copyright © 2022 朱德振. All rights reserved.
//

#import "orcPluginRegister.h"
#import "orcAPluginProvider.h"
#import "EPTPluginRouter.h"
@implementation orcPluginRegister
/**
 注册组件供应商 provider 方法，可以在该方法中进行组件的初始化工作
 */
- (void)registerPluginProvider
{
    [[EPTPluginRouter sharedInstance] registerPlugin:@"orc" providerName:@"provider" provider:[orcAPluginProvider new]];
}

@end
