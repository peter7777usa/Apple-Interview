//
//  Card.m
//  CardsShuffle
//
//  Created by Peter Fong on 7/27/14.
//  Copyright (c) 2014 Peter Fong. All rights reserved.
//

#import "Card.h"

@implementation Card

-(id)initCardWithValue:(int) value{
    if ( self = [super init] ) {
        self.value = [NSNumber numberWithInt:value];
    }
    return self;
}

@end
