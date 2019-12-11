//
//  SWHeadView.h
//  SWPageView_Example
//
//  Created by Lemon on 2019/12/11.
//  Copyright © 2019 LemonGui. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWHeadView : UIView
@property (nonatomic,strong) UIImage * bgImage;
@property (nonatomic,copy) void(^btnClickBlock)();

@end

NS_ASSUME_NONNULL_END
