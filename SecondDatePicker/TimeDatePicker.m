//
//  TimeDatePicker.m
//  TimeDatePicker
//
//  Created by shuju on 9/27/16.
//  Copyright © 2016 shuju. All rights reserved.
//

#import "TimeDatePicker.h"

static const NSInteger LOOP_NUMBER = 100;

@interface TimeDatePicker () <UIPickerViewDataSource, UIPickerViewDelegate>

@end

@implementation TimeDatePicker 

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.delegate = self;
        self.dataSource = self;
        self.showsSelectionIndicator = YES;
        self.date = [NSDate date];
        self.dateFormatter = [[NSDateFormatter alloc] init];
        self.dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss zzz";
        [self minutes];
    }
    return self;
}

-(void)setDate:(NSDate *)date {
    if (date == nil) {
        date = [NSDate  date];
    }
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    NSInteger second = [components second];
    
    [self selectRow:hour * LOOP_NUMBER / 2 inComponent:0 animated:YES];
    [self selectRow:minute  * LOOP_NUMBER / 2 inComponent:1 animated:YES];
    [self selectRow:second  * LOOP_NUMBER / 2 inComponent:2 animated:YES];
    _date = date;
}


#pragma mark dataSource
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self getPickerModeTimeObjectsWithComponent:component].count * LOOP_NUMBER;
}

#pragma mark delegate
// returns width of column and height of row for each component.
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return self.frame.size.width / 3;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 24;
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *rowLabel = (UILabel *)view;
    if (!rowLabel) {
        rowLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, pickerView.frame.size.width / 3, 22)];
        rowLabel.textAlignment = NSTextAlignmentCenter;
        rowLabel.font = [UIFont systemFontOfSize:12];
        rowLabel.text = [self pickerObjectAtRow:row InComponent:component];
    }
    return rowLabel;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
   
}


#pragma mark second/minute/hour
-(NSArray *)seconds {
    NSMutableArray *seconds = [NSMutableArray arrayWithCapacity:60];
    for (NSInteger i = 0; i < 60; i++) {
        NSString *second = [NSString stringWithFormat:@"%02ld秒", i];
        [seconds addObject:second];
    }
    return [seconds copy];
}

-(NSArray *)minutes {
    NSMutableArray *mins = [NSMutableArray arrayWithCapacity:60];
    for (NSInteger i = 0; i < 60; i++) {
        NSString *min = [NSString stringWithFormat:@"%02ld分", i];
        [mins addObject:min];
    }
    return [mins copy];
}

-(NSArray *)hours {
    NSMutableArray *hours = [NSMutableArray arrayWithCapacity:60];
    for (NSInteger i = 0; i < 24; i++) {
        NSString *hour = [NSString stringWithFormat:@"%02ld时", i];
        [hours addObject:hour];
    }
    return [hours copy];
}

-(NSArray *)getPickerModeTimeObjectsWithComponent:(NSInteger)component {
    if (component == 0) {
        return [self hours];
    } else if (component == 1) {
        return [self minutes];
    } else {
        return [self seconds];
    }
}

-(NSString *)pickerObjectAtRow:(NSInteger)row InComponent:(NSInteger)component {
    NSArray *components = [self getPickerModeTimeObjectsWithComponent:component];
    NSInteger index = row % components.count;
    return [components objectAtIndex:index];
}

-(NSDate *)updateDateWithSelectRow:(NSInteger)row Incomponent:(NSInteger)component {
    NSDate *date = [NSDate date];
    
    return date;
}

@end
