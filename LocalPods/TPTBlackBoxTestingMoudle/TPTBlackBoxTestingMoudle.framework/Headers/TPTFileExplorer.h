//
//  TPTFileExplorer.h
//  TPTBlackBoxTestingMoudle
//
//  Created by Napiac on 2023/6/12.
//  Copyright © 2023 Napiac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPTFileExplorer : NSObject

+ (NSArray<NSDictionary *> *)constructFilesDataListInDirectory:(NSString *)filePath;


+ (NSDictionary *)constructFileAttribute:(NSString *)filePath;

@end

NS_ASSUME_NONNULL_END
