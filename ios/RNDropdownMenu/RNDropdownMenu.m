#import <Foundation/Foundation.h>
#import "RNDropdownMenu.h"

// import RCTEventDispatcher
#if __has_include(<React/RCTEventDispatcher.h>)
#import <React/RCTEventDispatcher.h>
#elif __has_include("RCTEventDispatcher.h")
#import "RCTEventDispatcher.h"
#else
#import "React/RCTEventDispatcher.h" // Required when used as a Pod in a Swift project
#endif
#import <React/UIView+React.h>

#import "MKDropdownMenu.h"
#import "UIColor+fromHex.h"

@implementation RNDropdownMenu {
    
    RCTEventDispatcher *_eventDispatcher;
    
    // private properties to be mapped to the right prop
    // @todo: add as max as possible of properties
    float _minValue;
    float _maxValue;
    float _selectedMinimum;
    float _selectedMaximum;
    
    
    UIView *_childView;
    UISlider *_slider;
    
    
    NSArray *_content; // the content of menu.
    MKDropdownMenu *_dropdownMenu;
    NSInteger _selectedRowIndex;
    UIColor *mySelectedRowBackgroundColor;
    UIColor *myTitleBackgroundColor;
    UIColor *mySelectedItemColor;
    UIColor *myHighlightBackgroundColor;
    UIColor *_selectedRowColor;
    float _selectedRowTextSize;
    UIColor *myTintColor; // the color of arrow icon
    NSTextAlignment *_rowTextAlignment;
    NSString *_textAlignments; //left, center or right.
    NSInteger *_textSize;
}

- (void)setData:(NSArray *)data{
    NSLog(@"data is :%@", data);
    NSLog(@"first item is: %@", data[0]);
    
    _content = [data copy];
    [self setNeedsDisplay];
    
}

- (void)setSelectedRowBackgroundColor:(UIColor *)selectedRowBackgroundColor{
    NSLog(@"change selectedRowBackgroundcolor :%@", selectedRowBackgroundColor);
    mySelectedRowBackgroundColor = [UIColor colorwithHexString:selectedRowBackgroundColor alpha:1];
    
}

- (void)setSelectedRowTextSize:(float)selectedRowTextSize{
    _selectedRowTextSize = selectedRowTextSize;
}

- (void)setTitleBackgroundColor:(NSString *)titleBackgroundColor{
    NSLog(@"myTitleBackgroundColor :%@", titleBackgroundColor);
    myTitleBackgroundColor = [UIColor colorwithHexString:titleBackgroundColor alpha:1];
}

- (void)setSelectedItemColor:(NSString *)selectedItemColor{
    NSLog(@"mySelectedItemColor :%@", selectedItemColor);
    mySelectedItemColor = [UIColor colorwithHexString:selectedItemColor alpha:1];
}

- (void)setHighlightBackgroundColor:(NSString *)highlightBackgroundColor{
    NSLog(@"highlightBackgroundColor :%@", highlightBackgroundColor);
    myHighlightBackgroundColor = [UIColor colorwithHexString:highlightBackgroundColor alpha:1];
}

- (void)setTintColor:(NSString *)tintColor{
    NSLog(@"tintColor :%@", tintColor);
    myTintColor = [UIColor colorwithHexString:tintColor alpha:1];
    [_dropdownMenu setTintColor: myTintColor];
}


- (instancetype)initWithEventDispatcher:(RCTEventDispatcher *)eventDispatcher
{
    if ((self = [super init])) {
        _eventDispatcher = eventDispatcher;
        
        
        _childView = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, 50, 50))];
        
        
        _selectedRowIndex = 0; // initially selected the first item title.
        _dropdownMenu = [[MKDropdownMenu alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        _dropdownMenu.dataSource = self;
        _dropdownMenu.delegate = self;
        
        _content = @[ @"Monday", @"Tuesday", @"Wednesday",@"Thursday",@"Friday",@"Saturday",@"Sunday"];
        
        // @todo: check if we add border native here or add it to parent container
        // _dropdownMenu.layer.borderColor = [[UIColor colorWithRed:0.78 green:0.78 blue:0.8 alpha:1.0] CGColor];
        //_dropdownMenu.layer.borderWidth = 0.5;
        
        // _dropdownMenu.selectedComponentBackgroundColor = [UIColor redColor];
        // _dropdownMenu.dropdownBackgroundColor = [UIColor redColor];
        _dropdownMenu.backgroundDimmingOpacity = 0.01; // 1 for darker background of dropdown menu.
        
        // here we can show where to align row text
        // can be
        // - NSTextAlignmentCenter(default)
        // - NSTextAlignmentRight
        // - NSTextAlignmentLeft
        
        _rowTextAlignment = NSTextAlignmentLeft;
        [_dropdownMenu setRowTextAlignment: NSTextAlignmentCenter];
        _dropdownMenu.useFullScreenWidth = false;
        
        // @todo: add property to set this color.
        // set arrow icon color
        [_dropdownMenu setTintColor: [UIColor blackColor]];
        
        _selectedRowTextSize = 16;
        mySelectedRowBackgroundColor = [UIColor colorWithRed:0.96 green:0.97 blue:0.98 alpha:1.0]; // nice grey color
        myHighlightBackgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _childView.frame = self.bounds;
    
    // @important so it takes only the space given by the parent component
    _dropdownMenu.frame = self.bounds;
    [self addSubview:_dropdownMenu];
    
}

- (void)setExampleProp:(NSString *)exampleProp
{
    if(![exampleProp isEqual:_exampleProp]){
        _exampleProp = [exampleProp copy];
        // [self addTextView: _exampleProp];
    }
}

// export callback, not needed in this project
RCT_EXPORT_METHOD(getValues:(RCTResponseSenderBlock)callback)
{
    NSString *msg = @"Hi there";
    callback(@[msg]);
}

- (NSInteger)dropdownMenu:(nonnull MKDropdownMenu *)dropdownMenu numberOfRowsInComponent:(NSInteger)component {
    return _content.count;
}

- (NSInteger)numberOfComponentsInDropdownMenu:(nonnull MKDropdownMenu *)dropdownMenu {
    return 1;
}

- (CGFloat)dropdownMenu:(MKDropdownMenu *)dropdownMenu widthForComponent:(NSInteger)component{
    return 120;
}

- (BOOL)dropdownMenu:(MKDropdownMenu *)dropdownMenu shouldUseFullRowWidthForComponent:(NSInteger)component{
    return NO;
}

// @important: this method is where we define the UI of each item.
- (UIView *)dropdownMenu:(MKDropdownMenu *)dropdownMenu viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    // NSLog(@"awesome %ld", (long)row);
    view.backgroundColor = [UIColor blackColor];
    UILabel *l = [[UILabel alloc] init];
    l.text = _content[row];
    l.textAlignment = NSTextAlignmentCenter;
    
    if(row == _selectedRowIndex){
        l.backgroundColor = mySelectedRowBackgroundColor;
        l.font = [UIFont boldSystemFontOfSize: _selectedRowTextSize];
    }
    
    return l;
}


// when a row is selected.
- (void)dropdownMenu:(MKDropdownMenu *)dropdownMenu didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _selectedRowIndex = row;
    
    [_dropdownMenu closeAllComponentsAnimated:YES];
    [_dropdownMenu reloadComponent: 0]; // cause we have only 1 component
}

// - add the title of the dropdown menu
// - we can change dropdown title color too.
- (NSAttributedString *)dropdownMenu:(MKDropdownMenu *)dropdownMenu attributedTitleForComponent:(NSInteger)component{
    //UIColor *titleColor = [UIColor lightGrayColor];
    UIColor *titleColor = [UIColor blackColor];
    NSMutableAttributedString *string = [[NSAttributedString alloc] initWithString: _content[_selectedRowIndex]
                                                                        attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14 weight:UIFontWeightRegular],
                                                                                     NSForegroundColorAttributeName: titleColor}];
    
    return string;
}

// change the color etc of title when dropdown menu expended.
- (NSAttributedString *)dropdownMenu:(MKDropdownMenu *)dropdownMenu attributedTitleForSelectedComponent:(NSInteger)component{
    NSLog(@"slected item index: %ld", (long) component);
    UIColor *selectedItemColor = [UIColor orangeColor];
    return [[NSAttributedString alloc] initWithString: _content[_selectedRowIndex]
                                           attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16 weight:UIFontWeightLight],
                                                        NSForegroundColorAttributeName: mySelectedItemColor}];
}

// The background highlight color when clicked on item
- (UIColor *)dropdownMenu:(MKDropdownMenu *)dropdownMenu backgroundColorForHighlightedRowsInComponent:(NSInteger)component{
    return myHighlightBackgroundColor;
}

@end
                    
