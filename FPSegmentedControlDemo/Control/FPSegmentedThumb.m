//
// FPSegmentedThumb.m
// FPSegmentedControl
//
// Created by Flaviu Pasca on 11/28/2013.
// Copyright 2013 Flaviu Pasca. All rights reserved.
// https://github.com/flaviup/FPSegmentedControl
//
// Based on Sam Vermette's SVSegmentedControl.
//
// Created by Sam Vermette on 25.05.11.
// Copyright 2011 Sam Vermette. All rights reserved.
//
// https://github.com/samvermette/SVSegmentedControl
//

#import "FPSegmentedThumb.h"
#import <QuartzCore/QuartzCore.h>
#import "FPSegmentedControl.h"

@interface FPSegmentedThumb ()

@property (nonatomic, readwrite) BOOL selected;
@property (nonatomic, unsafe_unretained) FPSegmentedControl *segmentedControl;
@property (nonatomic, unsafe_unretained) UIFont *font;

@property (strong, nonatomic, readonly) UILabel *label;
@property (strong, nonatomic, readonly) UILabel *secondLabel;

- (void)activate;
- (void)deactivate;

@end


@implementation FPSegmentedThumb

@synthesize segmentedControl, backgroundImage, highlightedBackgroundImage, font, tintColor, textColor, textShadowColor, textShadowOffset, shouldCastShadow, selected;
@synthesize label, secondLabel;

// deprecated properties
@synthesize shadowColor, shadowOffset, castsShadow;



- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
	
    if (self) {
		self.userInteractionEnabled = NO;
		self.backgroundColor = [UIColor clearColor];
		self.textColor = [UIColor whiteColor];
		self.textShadowColor = [UIColor blackColor];
		self.textShadowOffset = CGSizeMake(0, -1);
		self.tintColor = [UIColor grayColor];
        self.shouldCastShadow = YES;
    }
	
    return self;
}

- (UILabel*)label {
    
    if(label == nil) {
        label = [[UILabel alloc] initWithFrame:self.bounds];
		label.textAlignment = UITextAlignmentCenter;
		label.font = self.font;
		label.backgroundColor = [UIColor clearColor];
		[self addSubview:label];
    }
    
    return label;
}

- (UILabel*)secondLabel {
    
    if(secondLabel == nil) {
		secondLabel = [[UILabel alloc] initWithFrame:self.bounds];
		secondLabel.textAlignment = UITextAlignmentCenter;
		secondLabel.font = self.font;
		secondLabel.backgroundColor = [UIColor clearColor];
		[self addSubview:secondLabel];
    }
    
    return secondLabel;
}

- (UIFont *)font {
    return self.label.font;
}


- (void)drawRect:(CGRect)rect {
        
    if(self.backgroundImage && !self.selected)
        [self.backgroundImage drawInRect:rect];
    
    else if(self.highlightedBackgroundImage && self.selected)
        [self.highlightedBackgroundImage drawInRect:rect];
    
    else {
        
        CGFloat cornerRadius = self.segmentedControl.cornerRadius;
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGFloat dx = 0.0f;
        
        if ([self.segmentedControl.titlesArray count] > 0 && self.segmentedControl.selectedIndex == 0) {
            CGPathRef fillRect1 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(rect.origin.x, rect.origin.y, 2 * cornerRadius, rect.size.height - 1) cornerRadius:cornerRadius].CGPath;
            CGPathRef maskRect = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(rect.origin.x + cornerRadius, rect.origin.y, cornerRadius, rect.size.height - 1) cornerRadius:0].CGPath;
            CGContextSaveGState(context);
            CGContextAddPath(context, fillRect1);
            CGContextAddPath(context, maskRect);
            CGContextEOClip(context);
            CGContextAddPath(context, fillRect1);
            CGContextSetFillColorWithColor(context, self.tintColor.CGColor);
            CGContextFillPath(context);
            CGContextRestoreGState(context);
            dx = cornerRadius;
        }
        
        if (self.segmentedControl.selectedIndex > 0 && self.segmentedControl.selectedIndex < [self.segmentedControl.titlesArray count] - 1) {
            cornerRadius = 0;
        }
        
        if ([self.segmentedControl.titlesArray count] > 0 && self.segmentedControl.selectedIndex == [self.segmentedControl.titlesArray count] - 1) {
            CGPathRef fillRect2 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(rect.origin.x + rect.size.width - 2 * cornerRadius, rect.origin.y, 2 * cornerRadius, rect.size.height - 1) cornerRadius:cornerRadius].CGPath;
            CGPathRef maskRect = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(rect.origin.x + rect.size.width - 2 * cornerRadius, rect.origin.y, cornerRadius, rect.size.height - 1) cornerRadius:0].CGPath;
            CGContextSaveGState(context);
            CGContextAddPath(context, fillRect2);
            CGContextAddPath(context, maskRect);
            CGContextEOClip(context);
            CGContextAddPath(context, fillRect2);
            CGContextSetFillColorWithColor(context, self.tintColor.CGColor);
            CGContextFillPath(context);
            CGContextRestoreGState(context);
        }

        [self.tintColor set];
        UIRectFillUsingBlendMode(CGRectMake(rect.origin.x + dx, rect.origin.y, rect.size.width - cornerRadius, rect.size.height - 1), kCGBlendModeOverlay);
    }
}


#pragma mark -
#pragma mark Setters

- (void)setBackgroundImage:(UIImage *)newImage {
    
    if(backgroundImage)
        backgroundImage = nil;
    
    if(newImage) {
        backgroundImage = newImage;
        self.shouldCastShadow = NO;
    } else {
        self.shouldCastShadow = YES;
    }
}

- (void)setTintColor:(UIColor *)newColor {
    
    if(tintColor)
        tintColor = nil;
	
	if(newColor)
		tintColor = newColor;

	[self setNeedsDisplay];
}

- (void)setFont:(UIFont *)newFont {
    self.label.font = self.secondLabel.font = newFont;
}

- (void)setTextColor:(UIColor *)newColor {
	self.label.textColor = self.secondLabel.textColor = newColor;
}

- (void)setTextShadowColor:(UIColor *)newColor {
	self.label.shadowColor = self.secondLabel.shadowColor = newColor;
}

- (void)setTextShadowOffset:(CGSize)newOffset {
	self.label.shadowOffset = self.secondLabel.shadowOffset = newOffset;
}

- (void)setShouldCastShadow:(BOOL)b {
    self.layer.shadowOpacity = b ? 1 : 0;
}


#pragma mark -

- (void)setFrame:(CGRect)newFrame {
	[super setFrame:newFrame];
        
    CGFloat posY = ceil((self.segmentedControl.height-self.font.pointSize+self.font.descender)/2)+self.segmentedControl.titleEdgeInsets.top-self.segmentedControl.titleEdgeInsets.bottom+1;
	int pointSize = self.font.pointSize;
	
	if(pointSize%2 != 0)
		posY--;
    
	self.label.frame = self.secondLabel.frame = CGRectMake(0, posY, newFrame.size.width, self.font.pointSize + 1);
    
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowRadius = 1;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.segmentedControl.cornerRadius-1].CGPath;
    self.layer.shouldRasterize = YES;
}


- (void)setSelected:(BOOL)s {
	
	selected = s;
	
	if(selected && !self.segmentedControl.crossFadeLabelsOnDrag && !self.highlightedBackgroundImage)
		self.alpha = 0.8;
	else
		self.alpha = 1;
	
	[self setNeedsDisplay];
}

- (void)activate {
	[self setSelected:NO];
    
    if(!self.segmentedControl.crossFadeLabelsOnDrag)
        self.label.alpha = 1;
}

- (void)deactivate {
	[self setSelected:YES];
    
    if(!self.segmentedControl.crossFadeLabelsOnDrag)
        self.label.alpha = 0;
}

#pragma mark - Support for deprecated methods

- (void)setShadowOffset:(CGSize)newOffset {
    self.textShadowOffset = newOffset;
}

- (void)setShadowColor:(UIColor *)newColor {
    self.textShadowColor = newColor;
}

- (void)setCastsShadow:(BOOL)b {
    self.shouldCastShadow = b;
}

@end
