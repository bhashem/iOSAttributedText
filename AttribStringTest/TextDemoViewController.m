//
//  TextDemoViewController.m
//  AttribStringTest
//
//  Created by Basil Hashem on 2/3/13.
//  Copyright (c) 2013 Basil's Playground. All rights reserved.
//

#import "TextDemoViewController.h"

@interface TextDemoViewController()
@property (weak, nonatomic) IBOutlet UIStepper *selectedWordStepper;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *selectedWordLabel;
@property (weak, nonatomic) IBOutlet UIStepper *fontSizeStepper;
@end

@implementation TextDemoViewController

- (void) addLabelAttributes:(NSDictionary *)attributes range:(NSRange)range
{
    if (range.location != NSNotFound) {
        NSMutableAttributedString *mat = [self.label.attributedText mutableCopy];
        [mat addAttributes:attributes range:range];
        self.label.attributedText = mat;
    }
    
}

-(void) addSelectedWordAttributes:(NSDictionary *)attributes
{
    NSRange range = [[self.label.attributedText string] rangeOfString:[self selectedWord]];
    [self addLabelAttributes:attributes range:range];
}

- (IBAction)underline {
    [self addSelectedWordAttributes:@{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)}];
}

- (IBAction)ununderline {
    [self addSelectedWordAttributes:@{NSUnderlineStyleAttributeName: @(NSUnderlineStyleNone)}];
}

- (IBAction)outline {
    [self addSelectedWordAttributes:@{NSStrokeWidthAttributeName:@(3.0)}];
}
- (IBAction)noOutline {
    [self addSelectedWordAttributes:@{NSStrokeWidthAttributeName:@(0.0)}];
}


- (IBAction)changeColor:(UIButton *)sender {
    [self addSelectedWordAttributes:@{NSForegroundColorAttributeName:sender.backgroundColor}];
    
}

- (IBAction)changeFont:(UIButton *)sender {
    CGFloat  fontSize = [UIFont systemFontSize];
    NSDictionary *attributes = [self.label.attributedText attributesAtIndex:0 effectiveRange:NULL];
    UIFont *existingFont = attributes[NSFontAttributeName];
    if (existingFont) fontSize = existingFont.pointSize;
    UIFont *font = [sender.titleLabel.font fontWithSize:fontSize];
    [self addSelectedWordAttributes:@{NSFontAttributeName:font}];
}


- (IBAction)changeFontSize:(UIStepper *)sender {
    NSLog(@"Default System Font size is %f", [UIFont systemFontSize]);
    NSLog(@"Small System Font size is %f", [UIFont smallSystemFontSize]);
    NSLog(@"Changing the font size to: %f", self.fontSizeStepper.value);
    UIFont *font = [self.label.font fontWithSize:self.fontSizeStepper.value];

    NSMutableAttributedString *mat = [self.label.attributedText mutableCopy];
    NSRange range = NSMakeRange(0, self.label.attributedText.length);
    [mat addAttributes:@{NSFontAttributeName:font} range:range];
    self.label.attributedText = mat;
}

- (NSArray *)wordList
{
    NSArray *wordList = [[self.label.attributedText string] componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([wordList count] ) {
        return (wordList);
    } else {
        return (@[@""]);
    }
}

- (NSString *) selectedWord
{
    return ([self wordList][(int)self.selectedWordStepper.value]);
}

- (IBAction)updateSelectedWord
{
    self.selectedWordStepper.maximumValue = [[self wordList] count] - 1;
    self.selectedWordLabel.text = [self selectedWord];
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    [self updateSelectedWord];
}

@end
