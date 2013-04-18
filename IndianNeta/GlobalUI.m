#import "GlobalUI.h"
#import "UIDevice+Hardware.h"

const CGFloat kDefaultRowHeight = 44;

const CGFloat kDefaultPortraitToolbarHeight   = 44;
const CGFloat kDefaultLandscapeToolbarHeight  = 33;

const CGFloat kDefaultPortraitKeyboardHeight  = 216;
const CGFloat kDefaultLandscapeKeyboardHeight = 160;


float OSVersion() {
  return [[[UIDevice currentDevice] systemVersion] floatValue];
}


BOOL OSVersionIsAtLeast(float version) {
#ifdef __IPHONE_3_0
	return 3.0 >= version;
#endif
#ifdef __IPHONE_2_2
	return 2.2 >= version;
#endif
#ifdef __IPHONE_2_1
	return 2.1 >= version;
#endif
#ifdef __IPHONE_2_0
	return 2.0 >= version;
#endif
  return NO;
}

BOOL screenIs2xResolution() {
	CGFloat scale = 1.0;
  UIScreen* screen = [UIScreen mainScreen];
  if ([UIScreen instancesRespondToSelector:@selector(scale)]) {
    scale = [screen scale];
	}
	
  return 2.0 == scale;
}


CGFloat VerticalOriginForRect(CGRect rect){
	return rect.origin.y;
}

CGFloat VerticalOriginForView(UIView *view){
	CGRect rect = [view frame];
	return rect.origin.y;
}

CGRect RectContract(CGRect rect, CGFloat dx, CGFloat dy) {
  return CGRectMake(rect.origin.x, rect.origin.y, rect.size.width - dx, rect.size.height - dy);
}


CGRect RectShift(CGRect rect, CGFloat dx, CGFloat dy) {
  return CGRectOffset(RectContract(rect, dx, dy), dx, dy);
}


CGRect RectInset(CGRect rect, UIEdgeInsets insets) {
  return CGRectMake(rect.origin.x + insets.left, rect.origin.y + insets.top,
                    rect.size.width - (insets.left + insets.right),
                    rect.size.height - (insets.top + insets.bottom));
}


BOOL IsPhoneSupported() {
  NSString* deviceType = [UIDevice currentDevice].model;
  return [deviceType isEqualToString:@"iPhone"];
}

BOOL IsKeyboardVisible() {
  // Operates on the assumption that the keyboard is visible if and only if there is a first
  // responder; i.e. a control responding to key events
  UIWindow* window = [UIApplication sharedApplication].keyWindow;
  return !![window findFirstResponder];
}

UIDeviceOrientation DeviceOrientation() {
  UIDeviceOrientation orient = [UIDevice currentDevice].orientation;
  if (UIDeviceOrientationUnknown == orient) {
    return UIDeviceOrientationPortrait;
  } else {
    return orient;
  }
}


BOOL IsSupportedOrientation(UIInterfaceOrientation orientation) {
  switch (orientation) {
			case UIInterfaceOrientationPortrait:
			case UIInterfaceOrientationLandscapeLeft:
			case UIInterfaceOrientationLandscapeRight:
				return YES;
			default:
				return NO;
  }
}


CGAffineTransform RotateTransformForOrientation(UIInterfaceOrientation orientation) {
  if (orientation == UIInterfaceOrientationLandscapeLeft) {
    return CGAffineTransformMakeRotation(M_PI*1.5);
  } else if (orientation == UIInterfaceOrientationLandscapeRight) {
    return CGAffineTransformMakeRotation(M_PI/2);
  } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
    return CGAffineTransformMakeRotation(-M_PI);
  } else {
    return CGAffineTransformIdentity;
  }
}


CGRect ApplicationFrame() {
  CGRect frame = [UIScreen mainScreen].applicationFrame;
  return CGRectMake(0, 0, frame.size.width, frame.size.height);
}


CGFloat ToolbarHeightForOrientation(UIInterfaceOrientation orientation) {
  if (UIInterfaceOrientationIsPortrait(orientation)) {
    return ROW_HEIGHT;
  } else {
    return LANDSCAPE_TOOLBAR_HEIGHT;
  }
}


CGFloat KeyboardHeightForOrientation(UIInterfaceOrientation orientation) {
  if (UIInterfaceOrientationIsPortrait(orientation)) {
    return KEYBOARD_HEIGHT;
  } else {
    return LANDSCAPE_KEYBOARD_HEIGHT;
  }
}


void QAAlert(NSString* message) {
	JAAlert(NSLocalizedString(@"Alert", @""), message);
}

void JAAlert(NSString* title, NSString* message) {
  UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:title
																									 message:message delegate:nil
																				 cancelButtonTitle:NSLocalizedString(@"OK", @"")
																				 otherButtonTitles:nil] autorelease];
  [alert show];
}

void CustomAlert(NSString *title, NSString *message, NSString *okButtonTitle, id delegate) {
  UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:title
												  message:message 
												  delegate:delegate
										cancelButtonTitle:NSLocalizedString(@"Cancel", @"")
										otherButtonTitles:okButtonTitle,nil] autorelease];
  [alert show];
}


NSString* TimeStamp() {
	NSDateFormatter *date_formater = [[[NSDateFormatter alloc] init] autorelease];
	[date_formater setDateFormat:@"YYYYMMddhhmmss"];
	NSString *timestamp = [date_formater stringFromDate:[NSDate date]];
	return timestamp;
}

NSString* DateStamp() {
	NSDateFormatter *date_formater = [[[NSDateFormatter alloc] init] autorelease];
	[date_formater setDateFormat:@"YYYYMMdd"];
	NSString *timestamp = [date_formater stringFromDate:[NSDate date]];
	return timestamp;
}

NSString* ResourcePath(NSString* resourceName) {
	return [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:resourceName];
}

UIColor* ColorWithHexString(NSString * stringToConvert){
	return ColorWithHexStringAlpha(stringToConvert, 1.0f);
}

UIColor* ColorWithHexStringAlpha(NSString * stringToConvert, CGFloat alpha){
	
	NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
	
	// String should be 6 or 8 characters
	if ([cString length] < 6) return nil;
	
	// strip 0X if it appears
	if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
		
		if ([cString length] != 6) return nil;
	
	// Separate into r, g, b substrings
	NSRange range;
	range.location = 0;
	range.length = 2;
	NSString *rString = [cString substringWithRange:range];
	
	range.location = 2;
	NSString *gString = [cString substringWithRange:range];
	
	range.location = 4;
	NSString *bString = [cString substringWithRange:range];
	
	// Scan values
	unsigned int r, g, b;
	[[NSScanner scannerWithString:rString] scanHexInt:&r];
	[[NSScanner scannerWithString:gString] scanHexInt:&g];
	[[NSScanner scannerWithString:bString] scanHexInt:&b];
	
	return [UIColor colorWithRed:((float) r / 255.0f)
												 green:((float) g / 255.0f)
													blue:((float) b / 255.0f)
												 alpha:alpha];
} 

UIView* HighlightView(CGRect frame,NSString *hexString){
	UIView *bgView = [[[UIView alloc] initWithFrame:frame] autorelease];
	[bgView setBackgroundColor:ColorWithHexString(hexString)];
	return bgView;
}

CGRect ScreenBounds() {
  CGRect bounds = [UIScreen mainScreen].bounds;
  if (UIInterfaceOrientationIsLandscape(DeviceOrientation())) {
    CGFloat width = bounds.size.width;
    bounds.size.width = bounds.size.height;
    bounds.size.height = width;
  }
  return bounds;
}

BOOL isIpodTouch(){
	NSString *deviceType = [UIDevice currentDevice].model;
	if ([deviceType isEqualToString:@"iPod touch"]) {
		return TRUE;
	}
	return FALSE;
}

BOOL isIndexWithinBounds(NSMutableArray *array, int index){
	if(IsArrayWithItems(array)){
		return [array count]-1 >= index;
	}
	return FALSE;
}

