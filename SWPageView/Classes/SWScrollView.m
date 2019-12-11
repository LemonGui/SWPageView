//
//  SWScrollView.m
//
//  Created by Lemon on 2019/12/9.
//

#import "SWScrollView.h"

@implementation SWScrollView

//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        self.delaysContentTouches = NO;
//    }
//    return self;
//}

//- (BOOL)touchesShouldBegin:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view {
//    for (UIResponder *nextRespoder = view.nextResponder; nextRespoder; nextRespoder = nextRespoder.nextResponder) {
//        if (nextRespoder == self) {
//            break;
//        }
//        if ([nextRespoder isKindOfClass:[UITableView class]]) {
//            UITableView *tableView = (UITableView *)nextRespoder;
//            SEL sel = NSSelectorFromString(@"_beginTrackingWithEvent:");
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
//            if ([tableView respondsToSelector:sel]) {
//                [tableView performSelector:sel withObject:event];
//            }
//#pragma clang diagnostic pop
//        }
//    }
//    return [super touchesShouldBegin:touches withEvent:event inContentView:view];
//}

//-(BOOL)touchesShouldCancelInContentView:(UIView *)view
//{
//    [super touchesShouldCancelInContentView:view];
//    return YES;
//}

@end

