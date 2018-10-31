//
//  UIColor+fromHex.h
//  RNDropdownMenu
//
//  Created by mac on 2018-10-27.
//  Copyright © 2018 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (fromHex)
+ (UIColor *)colorwithHexString:(NSString *)hexStr alpha:(CGFloat)alpha;
@end
