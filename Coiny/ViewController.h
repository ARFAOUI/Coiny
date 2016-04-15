//
//  ViewController.h
//  Coiny
//
//  Created by Bechir Arfaoui on 08/04/16.
//  Copyright © 2016 Bechir Arfaoui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainView.h"
#import "Connector.h"
#import "Presenter.h"
#import "APIConnector.h"
#import "JBChartView.h"
#import "JBBarChartView.h"
#import "JBLineChartView.h"

@interface ViewController : UIViewController <MainView,JBBarChartViewDelegate,JBBarChartViewDataSource>
@property id<Connector> myconnector;
@property Presenter* presenter;
@property (nonatomic,strong) UILabel * informationLabel;
@end

