//
//  CWViewController.m
//  CWAPM
//
//  Created by JackWchen2015 on 04/03/2019.
//  Copyright (c) 2019 JackWchen2015. All rights reserved.
//

#import "CWViewController.h"
#import <CWAPM/CWPerformanceMonitor.h>
@interface CWViewController ()

@end

@implementation CWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [[CWPerformanceMonitorManager sharedInstance] startMonitoring];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
