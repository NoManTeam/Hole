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
	public static func dictionaryEncrypt(plainText: String, encDictionary: Dictionary<String, String>) -> String
	{
		var cipherText: String = ""
		for char in plainText.characters
		{
			let encChar = encDictionary[String(char)]
			if(encChar != nil)
			{
				cipherText += encChar!
			}
			else
			{
				cipherText += String(char)
			}
		}
		return cipherText
	}
	
	
	///将密文按照字典反映射为明文
	///
	///- Parameter plainText: 待加密的明文
	///- Parameter encDictionary: 映射用的字典（与加密用的字典相同）
	///- Returns: 解密后的明文
	public static func dictionaryDecrypt(cipherText: String, encDictionary: Dictionary<String, String>) -> String
	{
		var plainText: String = ""
		for char in cipherText.characters
		{
			var HasKey = false
			for (key, value) in encDictionary
			{
				if(String(char) == value)
				{
					plainText += key
					HasKey = true
					break
				}
			}
			if(!HasKey)
			{
				plainText += String(char)
			}
		}
		return plainText
	}
	
	///读取Json文件为Dictionary变量
	///
	///- Parameter plainText: Json文件绝对路径名
	///- Returns: 读出的Dictionary
	public static func dictionaryDecrypt(cipherText: String, encDictionary: Dictionary<String, String>) -> String
	{
		if (encDictionary == morseDictionary){
			var temp: String = cipherText
			for (key, value) in encDictionary{
				guard let range = temp.rangeOfString(value) else {continue}
				if range.startIndex == value.startIndex{
					temp.replaceRange(range, with: " " + key + " ")
				}
				var srange =  temp.rangeOfString(" " + value)
				while srange != nil{
					temp.replaceRange(srange!, with: " " + key + " ")
					srange = temp.rangeOfString(" " + value)
				}
			}
			var plainText = ""
			for char in temp.characters{
				if(char != " "){
					plainText.append(char)
				}
			}
			return plainText
		}
		else{
			var plainText: String = ""
			for char in cipherText.characters
			{
				var HasKey = false
				for (key, value) in encDictionary
				{
					if(String(char) == value)
					{
						plainText += key
						HasKey = true
						break
					}
				}
				if(!HasKey)
				{
					plainText += String(char)
				}
			}
			return plainText
		}
	}
	
}