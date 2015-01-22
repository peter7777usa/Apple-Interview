//
//  TrieNode.m
//  Trie
//
//  Created by Peter Fong on 7/27/14.
//  Copyright (c) 2014 Peter Fong. All rights reserved.
//

#import "TrieNode.h"

@implementation TrieNode

-(id)init{
    if ( self = [super init] ) {
        self.childrenNodes = [[NSMutableArray alloc] init];
        self.SiblingNodes = [[NSMutableArray alloc] init];
        return  self;
    }
    return self;
}

- (TrieNode *)checkValueExistInSiblings:(int)value{
    for (int i = 0; i<[self.siblingNodes count]; i++){
        if ([(TrieNode *)self.siblingNodes[i] key] == value){
            return self.siblingNodes[i];
        }
    }
    return nil;
}

- (TrieNode *)checkValueExistInChildren:(int)value{
    for (int i = 0; i<[self.childrenNodes count]; i++){
        if ([(TrieNode *)self.childrenNodes[i] key] == value){
            return self.childrenNodes[i];
        }
    }
    return nil;
}

@end
