//
//  TimeDatePicker.h
//  TimeDatePicker
//
//  Created by shuju on 9/27/16.
//  Copyright © 2016 shuju. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    PickerModeDate, //select date as <year : month : day>
    PickerModeTime, //select time as <hour : minute : second>
} PickerMode;

@protocol TimePickerDelegate <NSObject>

-(NSDate *)timePickerDidChanged;

@end

@interface TimeDatePicker : UIPickerView
///timePicker select mode
@property(nonatomic, assign) PickerMode timeDatePickerMode;
///when pickerView is selected, timeDelegate can dosomthing
@property(nonatomic, weak) id<TimePickerDelegate> timeDelegate;
///set date
@property(nonatomic, strong) NSDate *date;
///set dateformater
@property(nonatomic, strong) NSDateFormatter *dateFormatter;

@end
