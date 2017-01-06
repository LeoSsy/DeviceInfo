//
//  SYKeyChain.m
//  DeiviceInfoGet
//
//  Created by shushaoyong on 2016/12/21.
//  Copyright © 2016年 浙江踏潮流网络科技有限公司. All rights reserved.
//

#import "SYKeyChain.h"

@implementation SYKeyChain

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (id)kSecClassGenericPassword,(id)kSecClass,
            service, (id)kSecAttrService,
            service, (id)kSecAttrAccount,
            (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,
            nil];
}

+ (void)save:(NSString*)saveStr data:(id)data
{
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:saveStr];
    
    //Delete old item before add new item
    SecItemDelete((CFDictionaryRef)keychainQuery);
    
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(id)kSecValueData];
    
    //Add item to keychain with the search dictionary
    SecItemAdd((CFDictionaryRef)keychainQuery, NULL);

}

+ (id)load:(NSString*)loadName;
{
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:loadName];
    //Configure the search setting
    //Since in our simple case we are expecting only a single attribute to be returned (the password) we can set the attribute kSecReturnData to kCFBooleanTrue
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", loadName, e);
        } @finally {
        }
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
    
}

+ (void)deleteName:(NSString*)deleteName
{
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:deleteName];
    SecItemDelete((CFDictionaryRef)keychainQuery);
}



@end
