//
//  RealmCoordinator.m
//  Coiny
//
//  Created by Bechir Arfaoui on 09/04/16.
//  Copyright © 2016 Bechir Arfaoui. All rights reserved.
//

#import "RealmCoordinator.h"
#import "ExchangeRate.h"

@implementation RealmCoordinator

-(void)clearCache{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm deleteAllObjects];
    [realm commitWriteTransaction];
}
-(void)cacheExchangeRates:(NSMutableArray*)rates{
     RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    for (int i=0; i< rates.count; i++) {
        ExchangeRate* rate = [rates objectAtIndex:i];
        [realm addObject:rate];
    }
    [realm commitWriteTransaction];
}
-(NSArray*)getCachedRates{
    RLMResults<ExchangeRate *> *rates = [ExchangeRate allObjects];
    return (NSArray*)rates;
}
-(void)updateEchangeRateForDate:(ExchangeRate*)day{
    if (day) {
        ExchangeRate* newRate = [[ExchangeRate alloc]init];
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        newRate.rateValue = day.rateValue;
        newRate.ratedate= day.ratedate;
        [realm commitWriteTransaction];
    }
}
@end
