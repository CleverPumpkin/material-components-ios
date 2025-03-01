#import <UIKit/UIKit.h>

#import "MDCButton.h"

API_DEPRECATED_BEGIN("Use branded UIButton (iOS 13/14) / UIButtonConfiguration (iOS 15+) instead. "
                     "See go/material-ios-buttons for more details.",
                     ios(12, API_TO_BE_DEPRECATED))

/**
 This category is temporary and is meant to allow us to A/B test the performance improvements of
 using the new shadow vs the old shadow. When such test is finalized, we will delete this file and
 the internal corresponding static property and move all clients to the new shadow.
 TODO(b/185206035): Remove category for enabling performant shadow.
 */
@interface MDCButton (ShadowsPrivate)

/**
 Returns a bool indicating if the performant shadow is turned on or not.
 */
+ (BOOL)enablePerformantShadow;

/**
 Enables/disables the performant shadow for the button.
 */
+ (void)setEnablePerformantShadow:(BOOL)enable;

@end

API_DEPRECATED_END
