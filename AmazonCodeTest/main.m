//
//  main.m
//  AmazonCodeTest
//
//  Created by Michael Dautermann on 6/10/12.
//  Copyright (c) 2012 Try To Guess My Company Name. All rights reserved.
//

#import <Foundation/Foundation.h>

// this solution is better than the original "brute" force algorithm which would have
// been N x N (n2 time).  This version goes in n log n time in average and worst cases. 

// this struct keeps track of the maximum difference we've seen so far
// and which elements from the array generate that difference
typedef struct { 
    NSInteger maximumDifference;
    NSInteger maxDiffOuterObject;
    NSInteger maxDiffInnerObject;
} BiggestDifference;

@interface AmazonCodeTest
+ (void) findBiggestDifference: (NSArray *) arrayOfNumbers;
@end

@implementation AmazonCodeTest

+ (void) findBiggestDifference: (NSArray *) arrayOfNumbers
{
    NSInteger firstIndex;
    NSInteger secondIndex;
    NSInteger valueOfOuterObject;
    NSInteger valueOfInnerObject;
    NSInteger maximumDifferenceOfInnerloop = 0;
    BiggestDifference bObject;
    
    // no results get printed out if this "maximumDifference" doesn't get reset from zero
    bObject.maximumDifference = 0;

    // two loops going on here.  outer loop increments from 1 - N
    for(firstIndex = 0; firstIndex < [arrayOfNumbers count]; firstIndex++)
    {
        // inner loop from M - N (where M is the index (+1) pointed to by the outer loop)
        for(secondIndex = firstIndex+1; secondIndex < [arrayOfNumbers count]; secondIndex++)
        {
            NSString * numberAsStringObject = [arrayOfNumbers objectAtIndex: firstIndex];
            if(numberAsStringObject)
            {
                valueOfOuterObject = [numberAsStringObject integerValue];
                numberAsStringObject = [arrayOfNumbers objectAtIndex: secondIndex];
                if(numberAsStringObject)
                {
                    valueOfInnerObject = [numberAsStringObject integerValue];
             
                    // now that we have our pair from the array set as integers we could potentially compare
                    // let's just see if the "inner" object value is bigger than the "outer" object value
                    // plus the current maximum difference for this inner loop.  Doing this allows us to 
                    // avoid wasting time in any further computations if the inner object's value isn't going 
                    // to be part of a potential "winning" pair 
                    if(valueOfInnerObject >= (valueOfOuterObject + maximumDifferenceOfInnerloop))
                    {
                        //if you wanted to see how the comparisons are going along, just un-comment the next line of code
                        //NSLog( @"comparing %ld and %ld (diff of %ld); max diff of inner loop is %ld, current maximum is %ld", valueOfOuterObject, valueOfInnerObject, (valueOfInnerObject - valueOfOuterObject),  maximumDifferenceOfInnerloop, bObject.maximumDifference);

                        maximumDifferenceOfInnerloop = (valueOfInnerObject - valueOfOuterObject);
                        // if the maximum difference of this inner loop calculation is bigger than the 
                        // biggest difference we've seen so far...
                        if(maximumDifferenceOfInnerloop > bObject.maximumDifference)
                        {
                            // ... we have a new winning pair!
                            bObject.maximumDifference = maximumDifferenceOfInnerloop;
                            bObject.maxDiffOuterObject = valueOfOuterObject;
                            bObject.maxDiffInnerObject = valueOfInnerObject;
                        }
                    }
                }
            }
        }
        // reset inner loop "maximum" and increment the outer loop index
        maximumDifferenceOfInnerloop = 0;
    }

    // if maximum difference is greater than zero, then we'll have a winning pair to show off
    if(bObject.maximumDifference > 0)
    {
        NSLog( @"maximum difference between %ld & %ld is %ld", bObject.maxDiffInnerObject, bObject.maxDiffOuterObject, bObject.maximumDifference);
    }
}

@end

int main(int argc, const char * argv[])
{
    @autoreleasepool {
        // our array is made up of NSString objects only because it's easier on your eyes to look at the 
        // below line of code versus doing [NSNumber numberWithInt: 200] for each number in the array
        
        // if you'd like to see how other arrays work, just un-comment one of them out
        //NSArray * arrayToTryOut = [[NSArray alloc] initWithObjects: @"200", @"400", @"100", @"350", nil];
        //NSArray * arrayToTryOut = [[NSArray alloc] initWithObjects: @"2", @"3", @"5", @"1", @"3", @"2", nil];
        NSArray * arrayToTryOut = [[NSArray alloc] initWithObjects: @"3", @"2", @"1", @"4", @"5", @"6", @"7", nil];
        
        [AmazonCodeTest findBiggestDifference: arrayToTryOut];
    }
    return 0;
}
