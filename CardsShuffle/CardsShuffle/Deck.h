//
//  Deck.h
//  CardsShuffle
//
//  Created by Peter Fong on 7/27/14.
//  Copyright (c) 2014 Peter Fong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

@property (nonatomic, strong) NSMutableArray *cards;

-(id)initDeckWithNumberOfCards:(int)numbersOfCards;
-(void)printDeck;

@end
