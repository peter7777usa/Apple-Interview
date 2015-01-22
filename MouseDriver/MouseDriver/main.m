//
//  main.m
//  MouseDriver
//
//  Created by Peter Fong on 7/26/14.
//  Copyright (c) 2014 Peter Fong. All rights reserved.
//

#import <Foundation/Foundation.h>

void handleReport(UInt8 * buffer, UInt16 length);

int main(int argc, const char * argv[])
{
    
    @autoreleasepool {
        UInt8 XYValid[] = {
            0b00000000, // B0
            0b00000000, // B1
            0b11111111, // B2
            0b11111111, // B3
            0b00111100, // B4
            0b00000000, // B5
            0b00000000  // B6
        };
        UInt8 timestampValid[] = {
            0b00000000, // B0
            0b00000000, // B1
            0b00000000, // B2
            0b00000000, // B3
            0b11000000, // B4
            0b11111111, // B5
            0b11111111  // B6
        };
        UInt8 buttonValid[] = {
            0b00000000, // B0
            0b00000000, // B1
            0b00000000, // B2
            0b00000000, // B3
            0b00000011, // B4
            0b00000000, // B5
            0b00000000  // B6
        };
        UInt8 XYInvalid[7];
        UInt8 timestampInvalid[7];
        UInt8 buttonInvalid[7];
        for (int i = 0; i < 7; i++) {
            XYInvalid[i] = ~XYValid[i];
            timestampInvalid[i] = ~timestampValid[i];
            buttonInvalid[i] = ~buttonValid[i];
        }
        
        UInt8 time1[] = {
            0b00000000, // B0
            0b00000000, // B1
            0b00000000, // B2
            0b00000000, // B3
            0b00000000, // B4
            0b00001111, // B5
            0b11111111  // B6
        };
        UInt8 time2[] = {
            0b00000000, // B0
            0b00000000, // B1
            0b00000000, // B2
            0b00000000, // B3
            0b00000000, // B4
            0b00111111, // B5
            0b11111111  // B6
        };
        UInt8 time3[] = {
            0b00000000, // B0
            0b00000000, // B1
            0b00000000, // B2
            0b00000000, // B3
            0b11000000, // B4
            0b11111111, // B5
            0b11111111  // B6
        };
        UInt8 time4[] = {
            0b00000000, // B0
            0b00000000, // B1
            0b00000000, // B2
            0b00000000, // B3
            0b00000000, // B4
            0b00000000, // B5
            0b00111000  // B6
        };
        
        handleReport(time1, 1);
        handleReport(time2, 1);
        handleReport(time3, 1);
        handleReport(time4, 1);
        
        UInt8 doubleReport[] = {
            0b00000000, // B0
            0b00000000, // B1
            0b00000000, // B2
            0b00000000, // B3
            0b11000000, // B4
            0b11111111, // B5
            0b11111111, // B6
            0b00000000, // B0
            0b00000000, // B1
            0b00000000, // B2
            0b00000000, // B3
            0b00000011, // B4
            0b00000000, // B5
            0b00000000  // B6
        };
        handleReport(doubleReport, 2);
        
    }
    return 0;
}

void handleReport(UInt8 * buffer, UInt16 length) {
    const UInt8 dXMaskOffset = 2;
    const UInt8 dXMask = 0b11 << dXMaskOffset;
    
    const UInt8 dYMaskOffset = 4;
    const UInt8 dYMask = 0b11 << dYMaskOffset;
    
    const UInt8 buttonOffset = 0;
    const UInt8 buttonMask = 0b11 << buttonOffset;
    
    const UInt8 timestampOffset = 6;
    const UInt8 timestampMask = 0b11 << timestampOffset;
    
    static UInt32 timestampTotal = 0;
    static UInt32 timestampUndropped = 0;
    
    for (UInt16 i = 0; i < length; i++) {
        UInt16 dX = (UInt16)(buffer[4 + i] & dXMask);
        dX <<= 8 - dXMaskOffset;
        dX += (UInt16)buffer[2 + i];
        
        UInt16 dY = (UInt16)(buffer[4 + i] & dYMask);
        dY <<= 8 - dYMaskOffset;
        dY += (UInt16)buffer[3 + i];
        printf("deltas: %d %d \n", dX, dY);
        
        UInt8 buttonStates = (buffer[4 + i] & buttonMask) >> buttonOffset;
        printf("button: %d \n", buttonStates);
        
        UInt32 timestamp = buffer[6 + i];
        timestamp <<= 8;
        timestamp += buffer[5 + i];
        timestamp <<= 8 - timestampOffset;
        timestamp += (buffer[4 + i] & timestampMask) >> timestampOffset;
        printf("time: %d \n", timestamp);
        
        if (timestamp >= timestampUndropped)
            timestampUndropped = timestamp;
        else {
            timestampTotal += timestampUndropped + 1;
            timestampUndropped = timestamp;
        }
        printf("Current total timestamp: %d\n", timestampTotal + timestampUndropped);
        
    }
}
