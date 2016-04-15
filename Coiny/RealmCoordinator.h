//
//  RealmCoordinator.h
//  Coiny
//
//  Created by Bechir Arfaoui on 09/04/16.
//  Copyright © 2016 Bechir Arfaoui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "ExchangeRate.h"

@interface RealmCoordinator : NSObject
-(void)clearCache;
-(void)cacheExchangeRates:(NSMutableArray*)rates;
-(NSArray*)getCachedRates;
-(void)updateEchangeRateForDate:(ExchangeRate*)day;
@end
