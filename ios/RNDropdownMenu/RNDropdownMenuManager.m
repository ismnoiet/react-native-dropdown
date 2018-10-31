#import <Foundation/Foundation.h>
#import "RNDropdownMenu.h"
#import "RNDropdownMenuManager.h"

// import RCTBridge
#if __has_include(<React/RCTBridge.h>)
#import <React/RCTBridge.h>
#elif __has_include("RCTBridge.h")
#import "RCTBridge.h"
#else
#import "React/RCTBridge.h" // Required when used as a Pod in a Swift project
#endif

@implementation RNDropdownMenuManager

@synthesize bridge = _bridge;

// Export a native module
// https://facebook.github.io/react-native/docs/native-modules-ios.html
RCT_EXPORT_MODULE();

// Return the native view that represents your React component
- (UIView *)view
{
    return [[RNDropdownMenu alloc] initWithEventDispatcher:self.bridge.eventDispatcher];
}

RCT_EXPORT_VIEW_PROPERTY(exampleProp, NSString)
RCT_EXPORT_VIEW_PROPERTY(minValue, float)
RCT_EXPORT_VIEW_PROPERTY(maxValue, float)
RCT_EXPORT_VIEW_PROPERTY(selectedMinimum, float)
RCT_EXPORT_VIEW_PROPERTY(selectedMaximum, float)
RCT_EXPORT_VIEW_PROPERTY(onValueChange, RCTBubblingEventBlock)

RCT_EXPORT_VIEW_PROPERTY(data, NSArray)
RCT_EXPORT_VIEW_PROPERTY(selectedRowBackgroundColor, NSString)
RCT_EXPORT_VIEW_PROPERTY(selectedRowTextSize, float)
RCT_EXPORT_VIEW_PROPERTY(titleBackgroundColor, NSString)
RCT_EXPORT_VIEW_PROPERTY(selectedItemColor, NSString)
RCT_EXPORT_VIEW_PROPERTY(highlightBackgroundColor, NSString)
RCT_EXPORT_VIEW_PROPERTY(tintColor, NSString)


// Export constants
// https://facebook.github.io/react-native/releases/next/docs/native-modules-ios.html#exporting-constants
- (NSDictionary *)constantsToExport
{
    return @{
             @"EXAMPLE": @"example"
             };
}

- (NSArray *) customDirectEventTypes {
    return @[
             @"onFrameChange",
             @"onChange"
             ];
}

// experiment with unneeded callback
RCT_EXPORT_METHOD(getValues:(RCTResponseSenderBlock)callback)
{
    NSString *msg = @"Hi there";
    callback(@[msg]);
}
@end
