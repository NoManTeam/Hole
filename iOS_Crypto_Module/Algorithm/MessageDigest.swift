//
//  MD5.swift
//  密语输入法
//
//  Created by macsjh on 15/9/30.
//  Copyright © 2015年 macsjh. All rights reserved.
//

import Foundation

///信息摘要算法集，用于验证数据完整性、变长字符串转换为定长、数字签名等
class MessageDigest
{
	internal static func md5(str:String) -> String{
		let cStr = (str as NSString).UTF8String
		let buffer = UnsafeMutablePointer<UInt8>.alloc(16)
		CC_MD4(cStr,(CC_LONG)(strlen(cStr)), buffer)
		let md5String = NSMutableString()
		for var i = 0; i < 8; ++i
		{
			md5String.appendFormat("%02x", buffer [i])
		}
		free(buffer)
		return md5String as String
	}
}