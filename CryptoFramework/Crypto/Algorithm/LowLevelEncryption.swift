//
//  RandomText.swift
//  密语输入法
//
//  Created by macsjh on 15/9/28.
//  Copyright © 2015年 Marcin Krzyzanowski. All rights reserved.
//

import Foundation

///低级加密算法
public class LowLevelEncryption {
	
	///符号集
	public static let symbols = ".,!?/\\+=-_;:\"'#$%^&*~∙<>(){}[]|®©™℠×÷。，！？、\\；：♬—“”‘’＃￥％＾＆＊～•《》（）｛｝【】…→←↑↓✓✕ "
	
	///英文小写字母集
	public static let englishCharacter:String = "abcdefghijklmnopqrstuvwxyz"
	
	///英文大写字母集
	public static let bigEnglishCharacter:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	
	///将明文按一定分隔符分隔成多个单元，并按照随机顺序重组的算法
	///- 明文需要一定长度，打乱才有意义
	///- 无解密算法（需要正常成年人水平的语义分析才有可能解密）
	///
	///- Parameter plainText: 待加密的明文
	///- Parameter splitChars: 分隔字符集,决定明文以何种方式分隔，留空则以1个NSString单位长度分割
	///- Returns: 加密后的密文（均为可打印字符）
	public static func randomText(plainText:NSString, splitChars:String?) -> String
	{
		var charSet:[String] = []
		for (var i = 0; i < plainText.length; ++i)
		{
			if(splitChars == nil)
			{
				let temp = plainText.substringFromIndex(i)
				charSet.append(NSString(string: temp).substringToIndex(1))
			}
			else
			{
				var j:Int
				var word:String = ""
				for(j = i; j < plainText.length; ++j)
				{
					let temp = plainText.substringFromIndex(j)
					let char = NSString(string: temp).substringToIndex(1)
					var isEqualToUnit = false
					for unit in splitChars!.characters
					{
						if (char == String(unit))
						{
							isEqualToUnit = true
							break
						}
					}
					if isEqualToUnit == true
					{
						break
					}
				}
				if(j > plainText.length)
				{
					word = plainText.substringFromIndex(i)
					break
				}
				else
				{
					var temp = plainText.substringFromIndex(i)
					word = NSString(string: temp).substringToIndex(j-i)
					temp = plainText.substringFromIndex(j)
					if(temp != "")
					{
						charSet.append(NSString(string: temp).substringToIndex(1))
					}
					i = j
				}
				charSet.append(word)
			}
		}
		
		var RandomString:String = ""
		while(charSet.count != 0)
		{
			let randNum = Int(arc4random_uniform(UInt32(charSet.count)))
			RandomString += charSet[randNum]
			charSet.removeAtIndex(randNum)
		}
		return RandomString
	}
	
	///将英文按照字母表的顺序、中文按照密语输入法汉字字库中的顺序，偏移指定的量
	///
	///- Parameter plainText: 待加密的明文
	///- Parameter Shift: 偏移量，不应为零，加解密时的偏移量应互为相反数
	///- Returns: 加密后的密文（均为可打印字符）
	public static func caesarCode(plainText: String, shift:Int) -> String
	{
		var cipherText = ""
		for(var i = 0; i < plainText.characters.count; ++i)
		{
			var isEChar = false
			for(var j = 0; j < englishCharacter.characters.count; ++j)
			{
				if englishCharacter[englishCharacter.startIndex.advancedBy(j)] == plainText[plainText.startIndex.advancedBy(i)]
				{
					var shiftIndex = (shift + j) % 26
					if(shiftIndex < 0)
					{
						shiftIndex += 26
					}
					cipherText.append(englishCharacter[englishCharacter.startIndex.advancedBy(shiftIndex)]) //.appendFormat("%c", eChar[shiftIndex])
					isEChar = true
					break
				}
				else if bigEnglishCharacter[bigEnglishCharacter.startIndex.advancedBy(j)] == plainText[plainText.startIndex.advancedBy(i)]
				{
					var shiftIndex = (shift + j) % 26
					if(shiftIndex < 0)
					{
						shiftIndex += 26
					}
					cipherText.append(bigEnglishCharacter[bigEnglishCharacter.startIndex.advancedBy(shiftIndex)]) //Format("%c", bEChar[shiftIndex])
					isEChar = true
					break
				}
			}
			if(isEChar == false)
			{
				cipherText.append(plainText[plainText.startIndex.advancedBy(i)])
			}
		}
		return cipherText
		// TODO: 增加中文凯撒加密算法
	}
	
	///将明文转换为base64编码的字符串
	///
	///- Parameter plainText: 待编码的明文
	///- Returns: base64编码的字符串（均为可打印字符）
	public static func base64Encode(plainText:NSString) -> String?
	{
		let sourceData = plainText.dataUsingEncoding(NSUTF8StringEncoding)
		if(sourceData != nil){
			return sourceData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
		}
		else {
			return nil
		}
	}
	
	///对base64编码的字符串进行解码
	///
	///- Parameter plainText: 待编码的明文
	///- Returns: 解码后的字符串（均为可打印字符）
	public static func base64Decode(cipherText:NSString) -> String?
	{
		let sourceData = NSData(base64EncodedString: cipherText as String, options: NSDataBase64DecodingOptions(rawValue: 0))
		if(sourceData != nil)
		{
			return String(data: sourceData!, encoding: NSUTF8StringEncoding)
		}
		return nil
	}
}