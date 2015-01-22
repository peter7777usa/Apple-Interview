//
//  Shuffler.h
//  CardsShuffle
//
//  Created by Peter Fong on 7/27/14.
//  Copyright (c) 2014 Peter Fong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SuffixTree.h"
#import "Deck.h"

@interface Shuffler : NSObject

@property (nonatomic, strong) SuffixTree *deckSequence;
@property (nonatomic, strong) NSMutableArray *validShuffledDeck;

-(void)shuffleDeck:(Deck *)deck;
-(void)shuffleDeckForN2R:(Deck *)deck; //No 2-card sequence recurrence

@end
