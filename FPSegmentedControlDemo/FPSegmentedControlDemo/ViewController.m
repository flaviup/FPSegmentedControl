//
//  ViewController.m
//  FPSegmentedControlDemo
//
//  Created by flaviupasca on 11/28/13.
//
//

#import "ViewController.h"
#import "FPSegmentedControl.h"

#define REGULAR_FONT_NAME @"HelveticaNeue"
#define LIGHT_FONT_NAME @"HelveticaNeue-Light"

#define DARK_GRAY_COLOR [UIColor colorWithRed:0.157 green:0.157 blue:0.157 alpha:1.0]
#define REGULAR_BLUE_COLOR [UIColor colorWithRed:0.2 green:0.525 blue:0.592 alpha:1.0]

@interface ViewController () {
    FPSegmentedControl *_segmentCtrl;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    FPSegmentedControl *segmentCtrl = nil;
    
    segmentCtrl = [[FPSegmentedControl alloc] initWithSectionTitles:@[@"Users", @"Items", @"Settings", @"Bookings", @"a"]];
    segmentCtrl.center = self.view.center;
    segmentCtrl.selectedIndex = 0;
    segmentCtrl.backgroundColor = self.view.backgroundColor;
    segmentCtrl.cornerRadius = 6.0f;
    segmentCtrl.textShadowColor = [UIColor clearColor];
    segmentCtrl.textShadowOffset = CGSizeZero;
    segmentCtrl.font = [UIFont fontWithName:REGULAR_FONT_NAME size:14.0];
    segmentCtrl.textColor = REGULAR_BLUE_COLOR;
    segmentCtrl.tintColor = REGULAR_BLUE_COLOR;
    segmentCtrl.thumb.shouldCastShadow = NO;
    segmentCtrl.thumb.textColor = [UIColor whiteColor];
    segmentCtrl.thumb.textShadowColor = nil;
    segmentCtrl.thumb.tintColor = REGULAR_BLUE_COLOR;
    segmentCtrl.changeHandler = ^(NSUInteger newIndex) {
        _segmentCtrl.selectedIndex = newIndex;
        
        if (_segmentCtrl.selectedIndex == 0) {
            
        } else if (_segmentCtrl.selectedIndex == _segmentCtrl.titlesArray.count - 1) {
            
        } else {
            
        }
    };
    _segmentCtrl = segmentCtrl;
    [self.view addSubview:segmentCtrl];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
