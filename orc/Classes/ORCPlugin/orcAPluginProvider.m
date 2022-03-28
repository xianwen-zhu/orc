//
//  ORCAPluginProvider.m
//  ios_workarea
//
//  Created by xianwen zhu on 2022/3/22.
//  Copyright © 2022 朱德振. All rights reserved.
//

#import "orcAPluginProvider.h"
#import "startorcAction.h"
@implementation orcAPluginProvider

//实现该组件所有的 action 注册
- (void)registerActions
{
    [self registerAction:@"orcAction" action:[startorcAction new]];
}

@end
