//
//  SearchFormViewController.h
//  TrainDelays
//
//  Created by Michael Pritchard on 27/02/2014.
//  Copyright (c) 2014 Michael Pritchard. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchFormViewController;

@protocol SearchFormViewControllerDelegate <NSObject>

- (void)searchFormViewController:(SearchFormViewController *)controller didSelectStation: (NSInteger*) mode :(NSString *)crsCode :(NSString *)name;

@end

@interface SearchFormViewController : UIViewController

@property (strong, nonatomic)           NSString *fromStationText;
@property (strong, nonatomic)           NSString *fromStationCRS;
@property (strong, nonatomic)           NSString *toStationText;
@property (strong, nonatomic)           NSString *toStationCRS;

@property (weak, nonatomic) id <SearchFormViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet    UIButton *fromStationBtn;
@property (weak, nonatomic) IBOutlet    UIButton *toStationBtn;
@property (weak, nonatomic) IBOutlet    UIDatePicker *datePicker;

@end
