//
//  NSAESData.swift
//  密语输入法
//
//  Created by macsjh on 15/10/17.
//  Copyright © 2015年 macsjh. All rights reserved.
//

import Foundation
import CommonCrypto

extension NSData
{
	func aes256_encrypt(key:NSString) -> NSData? //加密
	{
		let keyPtr:UnsafeMutablePointer<Int8> = UnsafeMutablePointer<CChar>.alloc(kCCKeySizeAES256+1)
		bzero(keyPtr, kCCKeySizeAES256+1)
		key.getCString(keyPtr, maxLength: kCCKeySizeAES256+1, encoding: NSUTF8StringEncoding)
		let dataLength:Int = self.length
		let bufferSize:size_t = dataLength + kCCBlockSizeAES128
		let buffer:UnsafeMutablePointer<Void> = malloc(bufferSize)
		var numBytesEncrypted:size_t = 0
		let cryptStatus:CCCryptorStatus = CCCrypt(CCOperation(kCCEncrypt), CCAlgorithm(kCCAlgorithmAES128),
			CCOptions(kCCOptionPKCS7Padding | kCCOptionECBMode),
			keyPtr, kCCBlockSizeAES128,
			nil,
			self.bytes, dataLength,
			buffer, bufferSize,
			&numBytesEncrypted)
		if (UInt32(cryptStatus) == UInt32(kCCSuccess)) {
			return NSData(bytesNoCopy:buffer, length:numBytesEncrypted);
		}
		free(buffer)
		return nil;
	}
	
	func aes256_decrypt(key:NSString) -> NSData?  //解密
	{
		let keyPtr:UnsafeMutablePointer<Int8> = UnsafeMutablePointer<CChar>.alloc(kCCKeySizeAES256+1)
		bzero(keyPtr, kCCKeySizeAES256+1)
		key.getCString(keyPtr, maxLength: kCCKeySizeAES256+1, encoding: NSUTF8StringEncoding)
		let dataLength:Int = self.length
		let bufferSize:size_t = dataLength + kCCBlockSizeAES128
		let buffer:UnsafeMutablePointer<Void> = malloc(bufferSize)
		var numBytesDecrypted:size_t = 0
		let cryptStatus:CCCryptorStatus = CCCrypt(CCOperation(kCCDecrypt), CCAlgorithm(kCCAlgorithmAES128),
			CCOptions(kCCOptionPKCS7Padding | kCCOptionECBMode),
			keyPtr, kCCBlockSizeAES128,
			nil,
			self.bytes, dataLength,
			buffer, bufferSize,
			&numBytesDecrypted)
		if (UInt32(cryptStatus) == UInt32(kCCSuccess)) {
			return NSData(bytesNoCopy: buffer, length:numBytesDecrypted);
		}
		free(buffer);
		return nil;
	}
}