//
//  ViewController.m
//  Coiny
//
//  Created by Bechir Arfaoui on 08/04/16.
//  Copyright © 2016 Bechir Arfaoui. All rights reserved.
//

#import "ViewController.h"
#import "CoinyColors.h"
#import "ExchangeRate.h"
#import "CoinyConfig.h"

@interface ViewController ()
{
    JBBarChartView *barChartView;
    NSMutableArray* ExchangeRates;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = INDEX;
    self.view.backgroundColor = [UIColor whiteColor];
    ExchangeRates = [[NSMutableArray alloc]init];
    [self SetupChart];
    [self setupInformationLabel];
    self.presenter = [[Presenter alloc]init];
    self.myconnector  = [[APIConnector alloc]init];
    [self.presenter initWithView:self andDataSource:self.myconnector];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)displayLoading:(NSString*)message{
    self.informationLabel.text = message;
    self.informationLabel.hidden = FALSE;
}
-(void)onValuesReceived:(NSArray *)historyItems{
    ExchangeRates = (NSMutableArray*)historyItems;
    [barChartView reloadData];
}
-(void)hideLoading{
    self.informationLabel.hidden = TRUE;
}
#pragma mark - Chart Delegate

- (CGFloat)barChartView:(JBBarChartView *)barChartView heightForBarViewAtIndex:(NSUInteger)index
{
    return [[ExchangeRates objectAtIndex:index] rateValue];
}

- (NSUInteger)numberOfBarsInBarChartView:(JBBarChartView *)barChartView
{
    return ExchangeRates.count;
}
- (UIColor *)barChartView:(JBBarChartView *)barChartView colorForBarViewAtIndex:(NSUInteger)index{
    return SkyBleuChartColor;
}
- (UIColor *)barSelectionColorForBarChartView:(JBBarChartView *)barChartView
{
    return [UIColor greenColor];
}

- (void)barChartView:(JBBarChartView *)barChartView didSelectBarAtIndex:(NSUInteger)index touchPoint:(CGPoint)touchPoint
{
    self.informationLabel.hidden = FALSE;
    self.informationLabel.text = [NSString stringWithFormat:@"%@ : %.03f",[[ExchangeRates objectAtIndex:index] ratedate],[[ExchangeRates objectAtIndex:index] rateValue]];
}

- (void)didDeselectBarChartView:(JBBarChartView *)barChartView
{
    self.informationLabel.hidden = TRUE;
}
- (void)SetupChart{
    barChartView = [[JBBarChartView alloc] init];
    barChartView.dataSource = self;
    barChartView.delegate = self;
    barChartView.frame = CGRectMake(10,40,self.view.frame.size.width -20 ,240);
    [self.view addSubview:barChartView];
}

-(void)setupInformationLabel{
    self.informationLabel  = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 200, 20)];
    self.informationLabel.text = @"information";
    self.informationLabel.backgroundColor = [UIColor greenColor];
    self.informationLabel.textColor = [UIColor blackColor];
    self.informationLabel.hidden = TRUE;
    [self.view addSubview:self.informationLabel];
}
@end
