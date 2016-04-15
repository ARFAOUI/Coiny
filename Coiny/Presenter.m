//
//  Presenter.m
//  Coiny
//
//  Created by Bechir Arfaoui on 08/04/16.
//  Copyright © 2016 Bechir Arfaoui. All rights reserved.
//

#import "Presenter.h"
#import "RealmCoordinator.h"
#import "CoinyConfig.h"

@implementation Presenter
@synthesize myConnector;
@synthesize view;


-(void) initWithView: (id < MainView >) theView andDataSource:(id < Connector >) connector{
    self.view = theView;
    self.myConnector = connector;
    [self readOfflineData];
    [self.view displayLoading:LOADING_MESSAGE];
    [self updateCurrentRate];
    [self requestHistory];
    
}
-(void)readOfflineData{
    NSMutableArray* items = [[NSMutableArray alloc]initWithCapacity:0];
    RealmCoordinator* realmCoordinator = [[RealmCoordinator alloc]init];
    items =  (NSMutableArray*) [realmCoordinator getCachedRates];
    if (items.count > 0) {
        [self.view onValuesReceived:items];
    }
}
-(void)requestHistory{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        [self startbackgroundTask];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self readOfflineData];
            [self.view hideLoading];
        });
    });
    
}

-(void)startbackgroundTask{
    NSMutableArray* items = [[NSMutableArray alloc]initWithCapacity:0];
    items = (NSMutableArray*)[myConnector getHistory];
    [items addObject:[myConnector getTodyRate]];
    if (items.count>0) {
        RealmCoordinator* realmCoordinator = [[RealmCoordinator alloc]init];
        [realmCoordinator clearCache];
        [realmCoordinator cacheExchangeRates:items];
    }
}
-(void)updateCurrentRate{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:TIMER_INTERVAL
                                                  target: self
                                                selector:@selector(runUpdateRequest)
                                                userInfo: nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

-(void)runUpdateRequest{
    [self.view displayLoading:UPDATE_MESSAGE];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        ExchangeRate* todayRate  = [myConnector getTodyRate];
        RealmCoordinator* realmCoordinator = [[RealmCoordinator alloc]init];
        [realmCoordinator updateEchangeRateForDate:todayRate];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self readOfflineData];
            [self.view hideLoading];
        });
    });
}
@end
