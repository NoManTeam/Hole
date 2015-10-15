
//
//  NSAESString.h
//  密语输入法
//
//  Created by macsjh on 15/9/24.
//  Copyright © 2015年 macsjh. All rights reserved.
//

#ifndef NSAESString_h
#define NSAESString_h
#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import "NSAESData.h"
@interface NSAESString:NSObject

+(NSString *) aes256_encrypt:(NSString *)PlainText :(NSString*)Key;
+(NSString *) aes256_decrypt:(NSString *)CipherText :(NSString *)key;

@end


#endif /* NSAESString_h */
