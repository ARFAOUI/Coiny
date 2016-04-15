//
//  MainView.h
//  Coiny
//
//  Created by Bechir Arfaoui on 08/04/16.
//  Copyright © 2016 Bechir Arfaoui. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MainView <NSObject>

@required -(void) onValuesReceived:(NSArray*)historyItems;
@required -(void) displayLoading:(NSString*)message;
@required -(void) hideLoading;
@end
