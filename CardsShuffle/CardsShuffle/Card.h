//
//  Card.h
//  CardsShuffle
//
//  Created by Peter Fong on 7/27/14.
//  Copyright (c) 2014 Peter Fong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (nonatomic) NSNumber *value;

-(id)initCardWithValue:(int)value;

@end
