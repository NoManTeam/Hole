//
//  DictionaryEncryption.swift
//  密语输入法
//
//  Created by macsjh on 15/9/28.
//  Copyright © 2015年 macsjh. All rights reserved.
//

import Foundation

///字典加密算法
public class DictionaryEncryption {
	
	
	///将明文按照字典映射为密文
	///
	///- Parameter plainText: 待加密的明文
	///- Parameter encDictionary: 映射用的字典
	///- Returns: 加密后的密文（均为可打印字符）
	public static func dictionaryEncrypt(plainText: NSString, encDictionary: Dictionary<String, String>) -> String
	{
		var cipherText: String = ""
		for (var i = 0; i < plainText.length; ++i)
		{
			let temp = NSString(string: plainText.substringFromIndex(i))
			let char = temp.substringToIndex(1)
			let encChar = encDictionary[char]
			if(encChar != nil)
			{
				cipherText += encChar!
			}
			else
			{
				cipherText += char
			}
		}
		return cipherText
	}
	
	
	///将密文按照字典反映射为明文
	///
	///- Parameter plainText: 待加密的明文
	///- Parameter encDictionary: 映射用的字典（与加密用的字典相同）
	///- Returns: 解密后的明文
	public static func dictionaryDecrypt(cipherText: NSString, encDictionary: Dictionary<String, String>) -> String
	{
		var plainText: String = ""
		for (var i = 0; i < cipherText.length; ++i)
		{
			let temp = NSString(string: cipherText.substringFromIndex(i))
			var char:String
			var HasKey = false
			for (key, value) in encDictionary
			{
				let valueLength = NSString(string: value).length
				if(valueLength > temp.length)
				{
					continue
				}
				char = temp.substringToIndex(valueLength)
				if(char == value)
				{
					plainText += key
					HasKey = true
					i += valueLength - 1
					break
				}
			}
			if(!HasKey)
			{
				char = temp.substringToIndex(1)
				plainText += char
			}
		}
		return plainText
	}
	
	///读取Json文件为Dictionary变量
	///
	///- Parameter plainText: Json文件绝对路径名
	///- Returns: 读出的Dictionary
	public static func getDictionaryFromFile(path: NSString) -> Dictionary<String, String>?
	{
		let dictionaryRecord = fopen(path.UTF8String, "r")
		if(dictionaryRecord == nil)
		{
			return nil
		}
		fseek(dictionaryRecord, 0, SEEK_END)
		let length = ftell(dictionaryRecord)
		fseek(dictionaryRecord, 0, SEEK_SET)
		
		var buffer: [UInt8] = Array<UInt8>(count: length, repeatedValue: 0)
		fread(&buffer, 1, length, dictionaryRecord)
		fclose(dictionaryRecord)
		
		let dictionaryData = NSData.withBytes(buffer)
		do
		{
			let encDictionary = try NSJSONSerialization.JSONObjectWithData(dictionaryData, options: .MutableContainers) as? NSDictionary
			return encDictionary as? Dictionary
		}
		catch
		{
			return nil
		}
	}
	
}