//
//  CurrencyMapper.h
//  Coiny
//
//  Created by Bechir Arfaoui on 08/04/16.
//  Copyright © 2016 Bechir Arfaoui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExchangeRate.h"

@interface CurrencyMapper : NSObject
-(NSArray*) parseExchangeRateUsingData: (NSData*) data;
-(ExchangeRate*)parseExchangeRate:(NSData*)data;
-(NSString*)todayDate;
@end
