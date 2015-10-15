//
//  NSAESString.m
//  密语输入法
//
//  Created by macsjh on 15/9/24.
//  Copyright © 2015年 macsjh. All rights reserved.
//

#import "NSAESString.h"

@implementation NSAESString:NSObject

+(NSString *) aes256_encrypt:(NSString *)PlainText :(NSString*)Key
{
	const char *cstr = [PlainText cStringUsingEncoding:NSUTF8StringEncoding];
	NSData *data = [NSData dataWithBytes:cstr length:PlainText.length];
	//对数据进行加密
	NSData *result = [data aes256_encrypt:Key];
 
	//转换为2进制字符串
	if (result && result.length > 0) {
		
		Byte *datas = (Byte*)[result bytes];
		NSMutableString *output = [NSMutableString stringWithCapacity:result.length * 2];
		for(int i = 0; i < result.length; i++){
			[output appendFormat:@"%02x", datas[i]];
		}
		return output;
	}
	return nil;
}

+(NSString *) aes256_decrypt:(NSString *)CipherText :(NSString *)key
{
	//转换为2进制Data
	NSMutableData *data = [NSMutableData dataWithCapacity:CipherText.length / 2];
	unsigned char whole_byte;
	char byte_chars[3] = {'\0','\0','\0'};
	int i;
	for (i=0; i < [CipherText length] / 2; i++) {
		byte_chars[0] = [CipherText characterAtIndex:i*2];
		byte_chars[1] = [CipherText characterAtIndex:i*2+1];
		whole_byte = strtol(byte_chars, NULL, 16);
		[data appendBytes:&whole_byte length:1];
	}
 
	//对数据进行解密
	NSData* result = [data aes256_decrypt:key];
	if (result && result.length > 0) {
		return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];;
	}
	return nil;
}
@end
