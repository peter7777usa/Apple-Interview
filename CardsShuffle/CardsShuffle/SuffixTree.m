//
//  SuffixTree.m
//  Trie
//
//  Created by Peter Fong on 7/28/14.
//  Copyright (c) 2014 Peter Fong. All rights reserved.
//

#import "SuffixTree.h"

@implementation SuffixTree

-(id)init{
    if ( self = [super init] ) {
        self.trie = [[Trie alloc] init];
    }
    return self;
}

- (void)insertSequenceIntoSuffixTree:(NSArray *)sequence{
    NSMutableArray *remainSeq = [sequence mutableCopy];
    while ([remainSeq count]!=0){
        [self.trie insertSequenceIntoTrie:remainSeq];
        [remainSeq removeObjectAtIndex:0];
    }
}

-(void)removeSequenceFromTrieWithTerminator:(int)terminator{
    [self.trie removeSequenceFromTrieWithTerminator:terminator];
}

- (NSArray*)longestCommonSubSequence {
    return [self.trie longestCommonSubSequence];
}

@end
