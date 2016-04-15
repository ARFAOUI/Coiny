//
//  CoinyTests.m
//  CoinyTests
//
//  Created by Bechir Arfaoui on 08/04/16.
//  Copyright © 2016 Bechir Arfaoui. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "Presenter.h"
#import "CurrencyMapper.h"
#import "APIConnector.h"
#import "Connector.h"

@interface CoinyTests : XCTestCase
{
    APIConnector* connector ;
}
@end

@implementation CoinyTests

- (void)setUp {
    [super setUp];
    connector = [[APIConnector alloc]init];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testgetHistoryisBeingCalled {
    APIConnector *connecter = [[APIConnector alloc] init];
    id apiConnectorprotocol = [OCMockObject partialMockForObject:connecter];
    [[apiConnectorprotocol expect] getHistory];
    [apiConnectorprotocol getHistory];
    [apiConnectorprotocol verify];
}

- (void)testgetExchangeRateisBeingCalled {
    APIConnector *connecter = [[APIConnector alloc] init];
    id apiConnectorprotocol = [OCMockObject partialMockForObject:connecter];
    [[apiConnectorprotocol expect] getTodyRate];
    [apiConnectorprotocol getTodyRate];
    [apiConnectorprotocol verify];
}

@end
