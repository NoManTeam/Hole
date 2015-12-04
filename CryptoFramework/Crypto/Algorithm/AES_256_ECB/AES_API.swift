//
//  AES.swift
//  密语输入法
//
//  Created by macsjh on 15/9/24.
//  Copyright © 2015年 macsjh. All rights reserved.
//

import Foundation


/**
AES_256_ECB加密API

- Parameter plainText: 要加密的明文
- Parameter key: 密码（长度任意，会转换为MD5值）
- Returns: 加密后的密文（base64编码字符串）
*/
func aesEncrypt(plainText:NSString, var key:String) -> NSString?
{
	key = MessageDigest.md5(key)
	let base64PlainText = LowLevelEncryption.base64Encode(plainText)
	if(base64PlainText != nil)
	{
		let cipherText = NSAESString.aes256_encrypt(base64PlainText!, Key: key)
		if(cipherText != nil)
		{
		return LowLevelEncryption.base64Encode(cipherText!)
		}
	}
	return nil
}

/**
AES_256_ECB解密API

- Parameter plainText: 要解密的密文
- Parameter key: 密码（长度任意，会转换为MD5值）
- Returns: 明文（base64编码字符串）
*/
func aesDecrypt(cipherText:NSString, var key:String) -> NSString?
{
	key = MessageDigest.md5(key)
	let originCipherText = LowLevelEncryption.base64Decode(cipherText)
	if(originCipherText != nil)
	{
		let base64CipherText = NSAESString.aes256_decrypt(originCipherText!, key: key)
		if (base64CipherText != nil)
		{
			return LowLevelEncryption.base64Decode(base64CipherText!)
		}
	}
	return nil
}