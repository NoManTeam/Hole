//
//  NSAESString.swift
//  密语输入法
//
//  Created by macsjh on 15/10/17.
//  Copyright © 2015年 macsjh. All rights reserved.
//

import Foundation
class NSAESString:NSObject
{
	internal static func aes256_encrypt(PlainText:NSString, Key:NSString) -> NSString?
	{
		let cstr:UnsafePointer<Int8> = PlainText.cStringUsingEncoding(NSUTF8StringEncoding)
		let data = NSData(bytes: cstr, length:PlainText.length)
		//对数据进行加密
		let result = data.aes256_encrypt(Key)
		if (result != nil && result!.length > 0 ) {
			var datas:[UInt8] = result!.arrayOfBytes()
			let output:NSMutableString = NSMutableString(capacity: result!.length * 2)
			for(var i = 0; i < result!.length; i++)
			{
				output.appendFormat("%02x", datas [i])
			}
			return output
		}
		return nil
	}
	
	internal static func aes256_decrypt(CipherText:NSString, key:NSString) -> NSString?
	{
		//转换为2进制Data
		let data = NSMutableData(capacity: CipherText.length / 2)
		var whole_byte:UInt8 = UInt8.init();
		let byte_char = NSString(string: "\0\0\0").UTF8String;
		var byte_chars:[Int8] = [byte_char[0], byte_char[1], byte_char[2]]
		for (var i=0; i < CipherText.length / 2; i++) {
			byte_chars [0] = Int8(CipherText.characterAtIndex(i*2))
			byte_chars [1] = Int8(CipherText.characterAtIndex(i*2+1))
			whole_byte = UInt8(strtol(byte_chars, nil, 16))
			data!.appendBytes(&whole_byte, length:1);
		}
		
		//对数据进行解密
		let result = data!.aes256_decrypt(key);
		if (result != nil && result!.length > 0) {
			return NSString(data:result!, encoding:NSUTF8StringEncoding)
		}
		return nil;
	}
}