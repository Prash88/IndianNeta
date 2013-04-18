#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 * @return the current runtime version of the iPhone OS.
 */
float OSVersion();

/**
 * Checks if the link-time version of the OS is at least a certain version.
 */
BOOL OSVersionIsAtLeast(float version);

/**
 * @return y for rect.
 */
CGFloat VerticalOriginForRect(CGRect rect);

/**
 * @return y for view.
 */
CGFloat VerticalOriginForView(UIView *view);

/**
 * @return a rectangle with dx and dy subtracted from the width and height, respectively.
 *
 * Example result: CGRectMake(x, y, w - dx, h - dy)
 */
CGRect RectContract(CGRect rect, CGFloat dx, CGFloat dy);

/**
 * @return a rectangle whose origin has been offset by dx, dy, and whose size has been
 * contracted by dx, dy.
 *
 * Example result: CGRectMake(x + dx, y + dy, w - dx, h - dy)
 */
CGRect RectShift(CGRect rect, CGFloat dx, CGFloat dy);

/**
 * @return a rectangle with the given insets.
 *
 * Example result: CGRectMake(x + left, y + top, w - (left + right), h - (top + bottom))
 */
CGRect RectInset(CGRect rect, UIEdgeInsets insets);

/**
 * @return TRUE if the device has phone capabilities.
 */
BOOL IsPhoneSupported();

/**
 * @return the current device orientation.
 */
UIDeviceOrientation DeviceOrientation();

/**
 * Checks if the orientation is portrait, landscape left, or landscape right.
 *
 * This helps to ignore upside down and flat orientations.
 */
BOOL IsSupportedOrientation(UIInterfaceOrientation orientation);

/**
 * @return TRUE if the keyboard is visible.
 */
BOOL IsKeyboardVisible();

/**
 * @return TRUE if the resolution of the screen is 2x.
 */

BOOL screenIs2xResolution();

/**
 * @return the rotation transform for a given orientation.
 */
CGAffineTransform RotateTransformForOrientation(UIInterfaceOrientation orientation);

/**
 * @return the application frame with no offset.
 *
 * From the apple docs:
 * Frame of application screen area in points (i.e. entire screen minus status bar if visible)
 */
CGRect ApplicationFrame();

/**
 * @return the toolbar height for a given orientation.
 *
 * The toolbar is slightly shorter in landscape.
 */
CGFloat ToolbarHeightForOrientation(UIInterfaceOrientation orientation);

/**
 * @return the height of the keyboard for a given orientation.
 */
CGFloat KeyboardHeightForOrientation(UIInterfaceOrientation orientation);

/**   
 * A convenient way to show a UIAlertView with a message.
 */
void QAAlert(NSString* message);

/**
 * A convenient way to show a UIAlertView with a title and message.
 */
void JAAlert(NSString* title, NSString* message);

/**
 * A convenient way to show a UIAlertView with a title, message, success button title and delegate.
 */
void CustomAlert(NSString* title, NSString* message, NSString *okButtonTitle, id delegate);

/**
 * Get TimeStamp in YYYYMMddhhmmss format
 */
NSString* TimeStamp();

/**
 * Get DateStamp in YYYYMMdd format
 */
NSString* DateStamp();

/**
 * Get Documents Resource Path in YYYYMMdd format
 */
NSString* ResourcePath(NSString* resourceName);

/**
 * Convert a hexadecimal color code into UIColor format
 */
UIColor* ColorWithHexString(NSString * stringToConvert);

/**
 * Convert a hexadecimal color code into UIColor format, also applies given alpha
 */
UIColor* ColorWithHexStringAlpha(NSString * stringToConvert, CGFloat alpha);

/**
 * Highlighted Selection View
 */


CGRect ScreenBounds();

UIView* HighlightView(CGRect frame,NSString *hexString);
BOOL isIndexWithinBounds(NSMutableArray *array, int index);
// Dimensions of common iPhone OS Views

/**
 * The standard height of a row in a table view controller.
 * @const 44 pixels
 */
extern const CGFloat kDefaultRowHeight;

/**
 * The standard height of a toolbar in portrait orientation.
 * @const 44 pixels
 */
extern const CGFloat kDefaultPortraitToolbarHeight;

/**
 * The standard height of a toolbar in landscape orientation.
 * @const 33 pixels
 */
extern const CGFloat kDefaultLandscapeToolbarHeight;

/**
 * The standard height of the keyboard in portrait orientation.
 * @const 216 pixels
 */
extern const CGFloat kDefaultPortraitKeyboardHeight;

/**
 * The standard height of the keyboard in landscape orientation.
 * @const 160 pixels
 */
extern const CGFloat kDefaultLandscapeKeyboardHeight;

/**
 * A constant denoting that a corner should be rounded.
 * @const -1
 */
extern const CGFloat kRounded;


#define ROW_HEIGHT                 kDefaultRowHeight
#define TOOLBAR_HEIGHT             kDefaultPortraitToolbarHeight
#define LANDSCAPE_TOOLBAR_HEIGHT   kDefaultLandscapeToolbarHeight

#define KEYBOARD_HEIGHT            kDefaultPortraitKeyboardHeight
#define LANDSCAPE_KEYBOARD_HEIGHT  kDefaultLandscapeKeyboardHeight

#define ROUNDED                    kRounded

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 \
alpha:(a)]

#define HSVCOLOR(h,s,v) [UIColor colorWithHue:(h) saturation:(s) value:(v) alpha:1]
#define HSVACOLOR(h,s,v,a) [UIColor colorWithHue:(h) saturation:(s) value:(v) alpha:(a)]

#define RGBA(r,g,b,a) (r)/255.0, (g)/255.0, (b)/255.0, (a)

#define kAdConfigDidLoadNotification @"kAdConfigDidLoad"
#define kProfileViewControllerConnectionActionNotification @"kProfileViewControllerConnectionAction" 