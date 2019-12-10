//
//  SWScrollView.m
//  SBBarModule
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

@implementation UIView (SWFrame)


//frame accessors

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGFloat)top
{
    return self.origin.y;
}

- (void)setTop:(CGFloat)top
{
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (CGFloat)left
{
    return self.origin.x;
}

- (void)setLeft:(CGFloat)left
{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (CGFloat)right
{
    return self.left + self.width;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom
{
    return self.top + self.height;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.left;
}

- (void)setX:(CGFloat)x
{
    self.frame = CGRectMake(x, self.top, self.width, self.height);
}

- (CGFloat)y
{
    return self.top;
}

- (void)setY:(CGFloat)y
{
    self.frame = CGRectMake(self.left, y, self.width, self.height);
}

- (CGFloat)centerX;
{
    return [self center].x;
}

- (void)setCenterX:(CGFloat)centerX;
{
    [self setCenter:CGPointMake(centerX, self.center.y)];
}

- (CGFloat)centerY;
{
    return [self center].y;
}

- (void)setCenterY:(CGFloat)centerY;
{
    [self setCenter:CGPointMake(self.center.x, centerY)];
}

@end
