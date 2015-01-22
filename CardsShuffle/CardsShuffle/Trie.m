//
//  Trie.m
//  Trie
//
//  Created by Peter Fong on 7/27/14.
//  Copyright (c) 2014 Peter Fong. All rights reserved.
//

#import "Trie.h"

@implementation Trie

- (id)init{
    if ( self = [super init] ) {
        self.rootNode = [[TrieNode alloc] init];
        subSequenceArray = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma - Service methods

- (void)insertSequenceIntoTrie: (NSArray *)sequence{
    NSMutableArray *remainingSeq = [sequence mutableCopy];
    TrieNode *nextNode = [self getDeepestNodeWithSequence:remainingSeq];
    if ([remainingSeq  count]>0){
        [self insertRemainingSequenceAfterNode:remainingSeq andNode:nextNode];
    }//else{
        //NSLog(@"No Insert");
    //}
}

-(void)removeSequenceFromTrieWithTerminator:(int)terminator{
    [self removeNodeWithTerminator:self.rootNode andTerminator:terminator];
}

- (NSArray*)longestCommonSubSequence {
    [subSequenceArray removeAllObjects];
    [self hasTerminator:self.rootNode];
    NSArray* finalResult = @[];
    for (int i = 0; i< [subSequenceArray count]; i++){
        if ([subSequenceArray[i] count] > [finalResult count])
            finalResult = subSequenceArray[i];
    }
    if ([finalResult count] == 1) finalResult = @[];
    return finalResult;
}

#pragma - Private methods

-(TrieNode *)getDeepestNodeWithSequence:(NSMutableArray *)seq{
    TrieNode *lastNode;
    TrieNode *nextNode = self.rootNode;
    while (nextNode){
        lastNode = nextNode;
        nextNode = [nextNode checkValueExistInChildren:[[seq objectAtIndex:0] intValue]];
        if ([seq count]==1){
            if (nextNode){
                [seq removeAllObjects];
                return nextNode;
            }
        }else{
            if (nextNode){
                [seq removeObjectAtIndex:0];
            }
        }
    }
    return lastNode;
}

-(void)insertRemainingSequenceAfterNode:(NSMutableArray *)remainSeq andNode:(TrieNode *)node{
    if ([remainSeq count]>0){
        TrieNode *newNode = [[TrieNode alloc] init];
        newNode.key = [[remainSeq objectAtIndex:0] intValue];
        newNode.parentNode = node;
        [node.childrenNodes addObject:newNode];
        if ([remainSeq count]>1){
            [remainSeq removeObjectAtIndex:0];
            [self insertRemainingSequenceAfterNode:remainSeq andNode:newNode];
        }
    }
}



-(BOOL)removeNodeWithTerminator:(TrieNode*) node andTerminator:(int)terminator{
    for (int i =0; i<[node.childrenNodes count]; i++){
        BOOL shouldDelete;
        //NSLog(@"Into %d", [(TrieNode*)node.childrenNodes[i] key]);
        shouldDelete=[self removeNodeWithTerminator:node.childrenNodes[i] andTerminator:terminator];
        //NSLog(@"Return From %d, current %d, %d Delete", [(TrieNode*)node.childrenNodes[i] key], node.key, shouldDelete);
        if (shouldDelete){
            //NSLog(@"Removing %d", [(TrieNode*)[node.childrenNodes objectAtIndex:i] key]);
            [node.childrenNodes removeObjectAtIndex:i];
            if ([node.childrenNodes count]>=1){
                return NO;
            }else{
                return YES;
            }
        }
    }
    if (node.key == terminator){
        return YES;
    }
    return NO;
}



- (BOOL)hasTerminator:(TrieNode*)node {
    if (node.key < 0) return YES;
    if ([node.childrenNodes count] == 0) return NO;
    BOOL oneTerminatorPresent = NO;
    for (TrieNode* child in node.childrenNodes) {
        if ([self hasTerminator:child]) {
            if (oneTerminatorPresent) {
                [self registerSequence:node];
                return NO;
            } else {
                oneTerminatorPresent = YES;
            }
        }
    }
    return oneTerminatorPresent;
}

- (void)registerSequence:(TrieNode*)node {
    NSMutableArray* result = [[NSMutableArray alloc] init];
    while (node != nil && node.key != 0) {
        [result insertObject:[NSNumber numberWithInt:node.key] atIndex:0];
        node = node.parentNode;
    }
    [subSequenceArray addObject:result];
}


@end
