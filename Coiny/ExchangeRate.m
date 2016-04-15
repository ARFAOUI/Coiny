//
//  ExchangeRate.m
//  Coiny
//
//  Created by Bechir Arfaoui on 08/04/16.
//  Copyright © 2016 Bechir Arfaoui. All rights reserved.
//

#import "ExchangeRate.h"

@implementation ExchangeRate
-(id)initWithExchangeValue:(float)rateValue
          ExchangeDate:(NSString*)ratedate{
    self = [super init];
    if(self){
        self.rateValue = rateValue;
        self.ratedate = ratedate;
    }
    return self;
}
@end
