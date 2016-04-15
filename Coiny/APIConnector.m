//
//  APIConnector.m
//  Coiny
//
//  Created by Bechir Arfaoui on 08/04/16.
//  Copyright © 2016 Bechir Arfaoui. All rights reserved.
//

#define API_ENDPOINT_TODAY @"http://api.coindesk.com/v1/bpi/currentprice.json"
#define API_ROOT @"https://api.coindesk.com/v1/bpi/historical/close.json?"

#import "APIConnector.h"
#import "CurrencyMapper.h"
#import "CoinyConfig.h"

@implementation APIConnector

-(NSArray*)getHistory{
    NSArray* ret = [[NSArray alloc] init];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[self myURL]]];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request
                                                 returningResponse:nil
                                                             error:nil];
    
    CurrencyMapper*myCurrencyMapper = [[CurrencyMapper alloc]init];
    ret = [myCurrencyMapper parseExchangeRateUsingData:responseData];
    return ret;
}

-(ExchangeRate*)getTodyRate{
    ExchangeRate* ret;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:API_ENDPOINT_TODAY]];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request
                                                 returningResponse:nil
                                                             error:nil];
    
    CurrencyMapper*myCurrencyMapper = [[CurrencyMapper alloc]init];
    ret = [myCurrencyMapper parseExchangeRate:responseData];
    return ret;
}

-(NSString*)myURL{
    CurrencyMapper*myCurrencyMapper = [[CurrencyMapper alloc]init];
    NSString * from = [self getFourWeeksAgodate];
    NSString* to = [myCurrencyMapper todayDate];
    return [self urlStringWithIndex:INDEX from:from to:to Currency:CURRENCY];

}

-(NSString*)urlStringWithIndex:(NSString*)index from:(NSString*)from to:(NSString*)to Currency:(NSString*)currency{
    NSString* myUrl = API_ROOT;
    myUrl = [myUrl stringByAppendingString:[NSString stringWithFormat:@"currency=%@&",currency]];
    myUrl = [myUrl stringByAppendingString:[NSString stringWithFormat:@"start=%@&",from]];
    myUrl = [myUrl stringByAppendingString:[NSString stringWithFormat:@"end=%@&",to]];
    myUrl = [myUrl stringByAppendingString:[NSString stringWithFormat:@"index=%@",index]];
    NSLog(@"%@",myUrl);
    return myUrl;
}

-(NSString*)getFourWeeksAgodate{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setWeekOfMonth:-4];
    NSDate *fourWeekAgo = [gregorian dateByAddingComponents:offsetComponents toDate:[NSDate date] options:0];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: @"YYYY-MM-dd"];
    NSString *stringFromDate = [formatter stringFromDate:fourWeekAgo];
    return stringFromDate;
}

@end
