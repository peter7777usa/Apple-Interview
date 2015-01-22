//
//  Trie.h
//  Trie
//
//  Created by Peter Fong on 7/27/14.
//  Copyright (c) 2014 Peter Fong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TrieNode.h"

@interface Trie : NSObject{
    NSMutableArray* subSequenceArray;
}

@property (nonatomic, strong) TrieNode *rootNode;

- (void)insertSequenceIntoTrie: (NSArray *)sequence;
- (void)removeSequenceFromTrieWithTerminator:(int)terminator;
- (NSArray*)longestCommonSubSequence;

@end
