#import <UIKit/UIKit.h>
#import "MKDropdownMenu.h"//;

@class RCTEventDispatcher;

@interface RNDropdownMenu : UIView<MKDropdownMenuDataSource, MKDropdownMenuDelegate>
// Define view properties here with @property
@property (nonatomic, assign) NSString  *exampleProp;
@property (nonatomic, assign) NSArray  *data;
@property (nonatomic, assign) NSString *selectedRowBackgroundColor;
@property (nonatomic, assign) float selectedRowTextSize;
@property (nonatomic, assign) NSString *titleBackgroundColor;
@property (nonatomic, assign) NSString *selectedItemColor;
@property (nonatomic, assign) NSString *highlightBackgroundColor;
@property (nonatomic, assign) NSString *tintColor;



// Initializing with the event dispatcher allows us to communicate with JS
- (instancetype)initWithEventDispatcher:(RCTEventDispatcher *)eventDispatcher NS_DESIGNATED_INITIALIZER;

@end

