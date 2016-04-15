//
//  Connector.h
//  Coiny
//
//  Created by Bechir Arfaoui on 08/04/16.
//  Copyright © 2016 Bechir Arfaoui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExchangeRate.h"

@protocol Connector <NSObject>

@required -(NSArray*) getHistory;

@required -(ExchangeRate*)getTodyRate;
@end
