//
//  Deck.m
//  CardsShuffle
//
//  Created by Peter Fong on 7/27/14.
//  Copyright (c) 2014 Peter Fong. All rights reserved.
//

#import "Deck.h"

@implementation Deck

-(id)initDeckWithNumberOfCards:(int)numbersOfCards{
    if ( self = [super init] ) {
        self.cards = [[NSMutableArray alloc] init];
        [self creatDeckWithCardsAmount:numbersOfCards];
    }
    return self;
}

#pragma -Service Methods

-(void)printDeck{
    NSLog(@"The deck contain:");
    for (int i = 0; i<[self.cards count]; i++){
        NSLog(@"%@", [(Card *)[self.cards objectAtIndex:i] value]);
    }
}

#pragma -Private Methods

-(void)creatDeckWithCardsAmount: (int) amount{
    for (int i = 1; i <= amount; i++){
        [self.cards addObject:[[Card alloc] initCardWithValue:i]];
    }
}

@end
