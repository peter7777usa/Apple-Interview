//
//  main.m
//  CardsShuffle
//
//  Created by Peter Fong on 7/27/14.
//  Copyright (c) 2014 Peter Fong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Shuffler.h"
#import "SuffixTree.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        Shuffler *shuffler = [[Shuffler alloc] init];
        Deck *deck1 = [[Deck alloc] initDeckWithNumberOfCards:13];
        [deck1 printDeck];
        [shuffler shuffleDeckForN2R:deck1];
    }
    return 0;
}

