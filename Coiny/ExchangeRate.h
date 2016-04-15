//
//  ExchangeRate.h
//  Coiny
//
//  Created by Bechir Arfaoui on 08/04/16.
//  Copyright © 2016 Bechir Arfaoui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface ExchangeRate : RLMObject
@property float  rateValue;
@property (nonatomic, retain) NSString* ratedate;

-(id)initWithExchangeValue:(float)rateValue
          ExchangeDate:(NSString*)ratedate;
@end
