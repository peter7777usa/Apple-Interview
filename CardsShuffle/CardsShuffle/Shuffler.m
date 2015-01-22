//
//  Shuffler.m
//  CardsShuffle
//
//  Created by Peter Fong on 7/27/14.
//  Copyright (c) 2014 Peter Fong. All rights reserved.
//

#import "Shuffler.h"

@implementation Shuffler

-(id)init{
    if ( self = [super init] ) {
        self.deckSequence = [[SuffixTree alloc] init];
        self.validShuffledDeck = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma - Service Methods

- (void)shuffleDeck:(Deck *)deck{
    NSLog(@"Shuffling....");
    for (NSUInteger i = 0; i < [deck.cards count]; i++) {
        NSUInteger j = arc4random() % [deck.cards count];
        [deck.cards exchangeObjectAtIndex:i withObjectAtIndex:j];
    }
    NSLog(@"New Shuffled Deck-");
    [deck printDeck];
}

- (NSArray *)constructSequenceFromDeck: (Deck *)deck{
    NSMutableArray *sequence = [[NSMutableArray alloc] init];
    for (int i = 0; i < [deck.cards count]; i++){
        [sequence addObject:[(Card *)[deck.cards objectAtIndex:i] value]];
    }
    [sequence addObject:@(-1-[self.validShuffledDeck count])];
    return sequence;
}

#pragma -Two-Cards Sequences Methods

- (void)shuffleDeckForN2R:(Deck *)deck{
    NSArray *sequence;
    if ([self.validShuffledDeck count]==0){
        [self shuffleDeck:deck];
        [self.validShuffledDeck addObject:deck];
        sequence = [self constructSequenceFromDeck:deck];
        [self.deckSequence insertSequenceIntoSuffixTree:sequence];
    }
    NSInteger longestSeq = 2;
    while (longestSeq>=2){
        [self shuffleDeck:deck];
        sequence = [self constructSequenceFromDeck:deck];
        [self.deckSequence insertSequenceIntoSuffixTree:sequence];
        longestSeq = [[self.deckSequence longestCommonSubSequence] count];
        if (longestSeq >=2){
            NSLog(@"Deck doesn't qualify.... %@ is a 2-card sequence", [self.deckSequence longestCommonSubSequence]);
            [self.deckSequence removeSequenceFromTrieWithTerminator:[sequence[[sequence count]-1] intValue]];
        }
    }
    [self.validShuffledDeck addObject:deck];
    NSLog(@"Deck qualified....Ending");
    
}



@end
