//
//  NSString+Encrypt.h
//  TPTCoreMoudle
//
//  Created by Napiac on 2022/7/20.
//  Copyright © 2022 Napiac. All rights reserved.
//

///加密解密工具 http://tool.chacuo.net/cryptdes
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Encrypt)

/**
 *  AES加密数据
 *
 *  @param key  key 长度一般为16（AES算法所能支持的密钥长度可以为128,192,256位（也即16，24，32个字节））
 *  @param iv  iv
 *
 *  @return data
 */
- (NSString *)encryptedWithAESUsingKey:(NSString*)key andIV:(NSData* _Nullable)iv;
/**
 *  AES解密数据
 *
 *  @param key key 长度一般为16
 *  @param iv  iv
 *
 *  @return data
 */
- (NSString *)decryptedWithAESUsingKey:(NSString*)key andIV:(NSData* _Nullable)iv;

/**
 *  DES加密数据
 *
 *  @param key key 长度一般为8
 *  @param iv  iv
 *
 *  @return data
 */
- (NSString *)encryptedWithDESUsingKey:(NSString*)key andIV:(NSData* _Nullable)iv;
/**
 *  DE解密数据
 *
 *  @param key key 长度一般为8
 *  @param iv  iv
 *
 *  @return data
 */
- (NSString *)decryptedWithDESUsingKey:(NSString*)key andIV:(NSData* _Nullable)iv;

/**
 *  3DES加密数据
 *
 *  @param key key 长度一般为24
 *  @param iv  iv
 *
 *  @return data
 */
- (NSString *)encryptedWith3DESUsingKey:(NSString*)key andIV:(NSData* _Nullable)iv;
/**
 *  3DES解密数据
 *
 *  @param key key 长度一般为24
 *  @param iv  iv
 *
 *  @return data
 */
- (NSString *)decryptedWith3DESUsingKey:(NSString*)key andIV:(NSData* _Nullable)iv;


@end

NS_ASSUME_NONNULL_END
