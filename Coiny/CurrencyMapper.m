//
//  CurrencyMapper.m
//  Coiny
//
//  Created by Bechir Arfaoui on 08/04/16.
//  Copyright © 2016 Bechir Arfaoui. All rights reserved.
//

#import "CurrencyMapper.h"

@implementation CurrencyMapper
-(NSArray*) parseExchangeRateUsingData: (NSData*) data{
    NSMutableArray* itemsList = [[NSMutableArray alloc] init];
    NSError* error = nil;
    NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:data
                                                         options:NSJSONReadingMutableContainers
                                                           error:&error];
    if (error) {
        NSLog(@"%@",[error localizedFailureReason]);
    }
    
    if ([dict isKindOfClass:[NSDictionary class]] && dict[@"bpi"]) {
        NSDictionary *results = dict[@"bpi"];
        if ([results count] > 0) {
            
            NSArray *keys = [results allKeys];
            NSArray *sortedKeys = [keys sortedArrayUsingSelector:@selector(compare:)];
            for(NSString *key in sortedKeys) {
                ExchangeRate * rate = [[ExchangeRate alloc] initWithExchangeValue:[[results objectForKey:key] floatValue]
                                                                     ExchangeDate:key];
                [itemsList addObject:rate];
            }
        }
    }
    return itemsList;
}
-(ExchangeRate*)parseExchangeRate:(NSData*)data{
    NSError* error = nil;
    NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:data
                                                         options:NSJSONReadingMutableContainers
                                                           error:&error];
    if (error) {
        NSLog(@"%@",[error localizedFailureReason]);
        return nil;
    }
    if ([dict isKindOfClass:[NSDictionary class]] && dict[@"bpi"]) {
        NSString* euroRate = [[dict[@"bpi"] objectForKey:@"EUR"] objectForKey:@"rate"];
        NSLog(@"%@",euroRate);
        ExchangeRate * rate = [[ExchangeRate alloc] initWithExchangeValue:[euroRate floatValue] ExchangeDate:[self todayDate]];
        return rate;
    }else
        return nil;
}
-(NSString*)todayDate{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: @"YYYY-MM-dd"];
    NSString *stringFromDate = [formatter stringFromDate:[NSDate date]];
    return stringFromDate;
}
@end
