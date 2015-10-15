//
//  NSAESData.h
//  密语输入法
//
//  Created by macsjh on 15/9/24.
//  Copyright © 2015年 macsjh. All rights reserved.
//

#ifndef NSAESData_h
#define NSAESData_h

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@interface NSData(AES256)
-(NSData *) aes256_encrypt:(NSString *)key;
-(NSData *) aes256_decrypt:(NSString *)key;
@end
#endif /* NSAESData_h */
