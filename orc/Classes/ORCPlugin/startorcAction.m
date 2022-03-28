//
//  StartORCAction.m
//  ios_workarea
//
//  Created by xianwen zhu on 2022/3/22.
//  Copyright © 2022 朱德振. All rights reserved.
//

#import "startorcAction.h"
#import <OcrSDKKit/OcrSDKConfig.h>
#import <OcrSDKKit/OcrSDKKit.h>
#import <EPTCore/EPTCore.h>
#import <EPTCore/UIColor+HexString.h>
@interface startorcAction ()
{
    CustomConfigUI *_customConfigUI;
    OcrSDKKit *_kit;
}

@property (nonatomic,copy) EPTPluginCallbackSucceess successBlock;
@property (nonatomic,copy) EPTPluginCallbackFailure failureBlock;

@end

@implementation startorcAction

/**
 action 的统一执行方法，可以传额外参数 extendedParam
 @param viewController action调用时所处的控制器环境
 @param params 参数
 @param success 成功回调
 @param failure 失败回调
 */
- (void)invokeWithContext:(UIViewController *)viewController params:(NSDictionary<NSString *,NSString *> *)params onResponse:(EPTPluginCallbackSucceess)success onFailure:(EPTPluginCallbackFailure)failure{
    
        NSString *method = params[@"method"];
        if([method isEqualToString:@"orcAction"])
        {
            self.successBlock = success;
            self.failureBlock = failure;
            [self startProcessOrc:params];
        }
}

///open
- (void)startProcessOrc:(NSDictionary *)params{
    ///
    _customConfigUI = [[CustomConfigUI alloc] init];
    ///传入参数解析
    ///isHorizontal是否横屏显示 (默认是横屏显示)  0代表横屏,1代表竖屏 (非必须)
    ///cardFrameColor 扫描识别背景框颜色(非必须)
    ///orctype 识别模式 (必须)
    /**
     IDCardOCR_FRONT = 0,//身份证正面
     IDCardOCR_BACK = 1,     //身份证反面
     BankCardOCR = 2,        //银行卡识别
     BusinessCardOCR = 3,    //名片识别
     MLIdCardOCR = 4,        //马来西亚身份证识别
     LicensePlateOCR = 5,    //车牌识别
     VinOCR = 6,              // vin码识别
     VehicleLicenseOCR_FRONT = 7, //行驶证主页
     VehicleLicenseOCR_BACK = 8,  //行驶证副页
     DriverLicenseOCR_FRONT = 9,  //驾驶证主页
     DriverLicenseOCR_BACK = 10    //驾驶证副页
     */
    NSString *isHorizontal = params[@"isHorizontal"];
    NSString *cardFrameColor = params[@"cardFrameColor"];
    NSString *orctype = params[@"orctype"];
    if([isHorizontal intValue] == 1){
        _customConfigUI.isHorizontal = YES;
    }
    
    if(cardFrameColor){
     _customConfigUI.cardFrameColor = [UIColor colorWithHexString:params[@"cardFrameColor"]];
    }
    
    _kit = [OcrSDKKit sharedInstance];
    OcrSDKConfig *ocrSDKConfig = [[OcrSDKConfig alloc] init];
    //默认设置为自动识别
    ocrSDKConfig.ocrModeType = 1;
    
    NSString *secretId = [EPTComponentUtil getComponentParams:@""][@"orc_secretId"];
    NSString *secretKey = [EPTComponentUtil getComponentParams:@""][@"orc_secretKey"];
    
    [_kit loadSDKConfigWithSecretId:secretId withSecretKey:secretKey withConfig:ocrSDKConfig];
    
    ///ocrType
    __weak typeof (self) weakSelf = self;
    [_kit startProcessOcr:[orctype intValue] ?:0 withSDKUIConfig:_customConfigUI withProcessSucceedBlock:^(id  _Nonnull resultInfo, UIImage * _Nullable resultImage, id  _Nonnull reserved) {
        NSDictionary *dic = (NSDictionary *)resultInfo;
        if(weakSelf.successBlock){
            weakSelf.successBlock(dic);
        }
        
    } withProcessFailedBlock:^(NSError * _Nonnull error, id  _Nullable reserved) {
        if(weakSelf.failureBlock){
            weakSelf.failureBlock(error.code, @"", reserved);
        }
    }];
    
}





@end
