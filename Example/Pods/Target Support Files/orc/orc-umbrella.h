#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "orcAPluginProvider.h"
#import "orcPluginRegister.h"
#import "startorcAction.h"

FOUNDATION_EXPORT double orcVersionNumber;
FOUNDATION_EXPORT const unsigned char orcVersionString[];

