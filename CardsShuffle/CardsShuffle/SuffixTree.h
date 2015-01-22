//
//  SuffixTree.h
//  Trie
//
//  Created by Peter Fong on 7/28/14.
//  Copyright (c) 2014 Peter Fong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Trie.h"

@interface SuffixTree : NSObject

@property (nonatomic, strong) Trie* trie;

- (void)insertSequenceIntoSuffixTree:(NSArray *)sequence;
- (void)removeSequenceFromTrieWithTerminator:(int)terminator;
- (NSArray*)longestCommonSubSequence;

@end
