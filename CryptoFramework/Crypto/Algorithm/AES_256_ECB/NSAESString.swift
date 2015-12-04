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
			return result!.toHexString()
		}
		return nil
	}
	
	internal static func aes256_decrypt(CipherText:String, key:NSString) -> NSString?
	{
		//转换为2进制Data
		let data = CipherText.hexStringToData()
		
		//对数据进行解密
		let result = data!.aes256_decrypt(key);
		if (result != nil && result!.length > 0) {
			return NSString(data:result!, encoding:NSUTF8StringEncoding)
		}
		return nil;
	}
}