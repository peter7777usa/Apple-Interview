//
//  TrieNode.h
//  Trie
//
//  Created by Peter Fong on 7/27/14.
//  Copyright (c) 2014 Peter Fong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrieNode : NSObject

@property (nonatomic) int key;
@property (nonatomic, strong) NSMutableArray *siblingNodes;
@property (nonatomic, strong) NSMutableArray *childrenNodes;
@property (nonatomic, strong) TrieNode *parentNode;

- (TrieNode *)checkValueExistInChildren:(int)value;
- (TrieNode *)checkValueExistInSiblings:(int)value;

@end
