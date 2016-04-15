//
//  MainPresenter.h
//  Coiny
//
//  Created by Bechir Arfaoui on 08/04/16.
//  Copyright © 2016 Bechir Arfaoui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainView.h"
#import "Connector.h"


@protocol MainPresenter <NSObject>
@property (nonatomic,strong) id<MainView> view;
@property (nonatomic,strong) id<Connector> myConnector;

-(void) initWithView: (id < MainView >) view andDataSource:(id < Connector >) connector;
@end
