//
//  IIILocalizedIndex.m
//  IIILocalizedIndexDemo
//
//  Created by sehone on 1/23/13.
//  Copyright (c) 2013 sehone <sehone@gmail.com>. All rights reserved.
//

#import "IIILocalizedIndex.h"

@implementation IIILocalizedIndex

int const III_NOT_FOUND = -1;
NSString * const III_COMMON_INDEX = @"#";
NSString * const III_LANG_EN = @"en";

static NSMutableDictionary *delimiters = nil;
static NSMutableDictionary *indexes = nil;

// Note:
// This method sends 'description' message to items in data array. So if items
// are objects of custom classes, remember to implement your own 'description'
// method for getting index.
+ (NSDictionary *)indexed:(NSArray *)data {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSString *desc = nil;
    NSString *index = nil;
    NSMutableArray *arr = nil;
    for (NSObject *item in data) {
        // Make sure that 'description' returns a correct NSString.
        desc = item.description;
        index = [IIILocalizedIndex getIndex:desc];
        arr = [dict objectForKey:index];
        if (arr.count == 0) {
            // No password with this index key exists yet.
            NSMutableArray *arr = [NSMutableArray arrayWithObject:item];
            [dict setObject:arr forKey:index];
        } else {
            [arr addObject:item];
        }
    }
    // sort array
    NSArray *allKeys = [dict allKeys];
    for (NSString *k in allKeys) {
        NSArray *a = [[dict objectForKey:k] sortedArrayUsingSelector:@selector(compare:)];
        [dict setObject:a forKey:k];
    }
    return dict;
}



+ (NSString *)getIndex:(NSString *)str {
    
    if (str.length == 0) {
        return III_COMMON_INDEX;
    }
    NSString *fc = [str substringToIndex:1];
    NSString *lang;
    if ([fc canBeConvertedToEncoding:NSASCIIStringEncoding]) {
        // If first char is an ascii char
        lang = III_LANG_EN;
    } else {
        lang = [[NSLocale preferredLanguages] objectAtIndex:0];
    }
    return [IIILocalizedIndex getIndexWithFirstChar:fc language:lang];
}



+ (NSString *)getIndexWithFirstChar:(NSString *)fc language:(NSString *)lang {
    NSString *index = III_COMMON_INDEX;
    // delimiters for this language
    NSArray *d = [[IIILocalizedIndex getLangDelimiters] objectForKey:lang];
    int i = III_NOT_FOUND;
    int c = d.count;
    
    NSString *first = [d objectAtIndex:0];
    NSString *last = [d objectAtIndex:c-1];
    
    if ([fc localizedCaseInsensitiveCompare:first] != NSOrderedAscending &&
        [fc localizedCaseInsensitiveCompare:last] != NSOrderedDescending) {
        // first <= firstChar <= last. i.e. A <= firstChar <= Z
        
        for (int j=0; j<c-2; j++) {
            if ([fc localizedCaseInsensitiveCompare:[d objectAtIndex:j]] != NSOrderedAscending &&
                [fc localizedCaseInsensitiveCompare:[d objectAtIndex:(j+1)]] == NSOrderedAscending) {
                // d[j] <= firstChar < d[j+1]. i.e. C <= firstChar < D
                i = j;
                break;
            }
        }
        if (i == III_NOT_FOUND) {
            if ([fc localizedCaseInsensitiveCompare:[d objectAtIndex:c-2]] != NSOrderedAscending &&
                [fc localizedCaseInsensitiveCompare:[d objectAtIndex:c-1]] != NSOrderedDescending) {
                // d[c-2] <= firstChar <= d[c-1]. i.e. Z <= firstChar <= Z
                i = c-2;
            }
        }
    }
    if (i != III_NOT_FOUND) {
        // If found in current language.
        index = [[indexes objectForKey:lang] objectAtIndex:i];
    }
    return index;
}




// For each language, delimiters are group of characters which partition all
// characters in that language into correct sections.
//
// Theoretically, if a language supports 'localizedCaseInsensitiveCompare', then
// there is a certain order for all characters in that language. If this order
// makes sense to users(i.e. alphabetic order), then it's easy to find those
// delimiters.
// 
// This is the precondition for 'IIILocalizedIndex' to work.
// 
+ (NSDictionary *)getLangDelimiters {
    if (delimiters.count == 0) {
        delimiters = [NSMutableDictionary dictionaryWithCapacity:0];
        indexes = [NSMutableDictionary dictionaryWithCapacity:0];
        // Delimiters, use them to partition all characters
        NSArray *dlm;
        // Indexes, use them as section titles, i.e. [A-Z]
        NSArray *idx;  
        NSString *lang;
        
        // English en
        lang = III_LANG_EN;
        dlm = [NSArray arrayWithObjects:
               @"A", @"B", @"C", @"D", @"E",
               @"F", @"G", @"H", @"I", @"J",
               @"K", @"L", @"M", @"N", @"O",
               @"P", @"Q", @"R", @"S", @"T",
               @"U", @"V", @"W", @"X", @"Y",
               @"Z", @"Z", nil];
        //     Standard indexes, 26 letters.
        idx = [NSArray arrayWithObjects:
               @"A", @"B", @"C", @"D", @"E",
               @"F", @"G", @"H", @"I", @"J",
               @"K", @"L", @"M", @"N", @"O",
               @"P", @"Q", @"R", @"S", @"T",
               @"U", @"V", @"W", @"X", @"Y",
               @"Z", nil];
        [delimiters setObject:dlm forKey:lang];
        [indexes setObject:idx forKey:lang];
        
        // 简体中文 zh-Hans
        lang = @"zh-Hans";
        dlm = [NSArray arrayWithObjects:
               @"啊", @"芭", @"擦", @"搭", @"蛾",
               @"发", @"噶", @"哈", @"击", @"喀",
               @"垃", @"妈", @"拿", @"哦", @"啪",
               @"七", @"然", @"撒", @"塌", @"挖",
               @"昔", @"压", @"匝", @"做", nil];
        //     23 indexes, without 'I', 'U', 'V' in Simplified Chinese.
        idx = [NSArray arrayWithObjects:
               @"A", @"B", @"C", @"D", @"E",
               @"F", @"G", @"H", @"J", @"K",
               @"L", @"M", @"N", @"O", @"P",
               @"Q", @"R", @"S", @"T", @"W",
               @"X", @"Y", @"Z", nil];
        [delimiters setObject:dlm forKey:lang];
        [indexes setObject:idx forKey:lang];
        
        // 繁體中文 zh-Hant
        // TODO
    }
    return delimiters;
}


@end
