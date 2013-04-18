#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 * @return NSString UUID value for current device
 */
NSString* UUID();

/**
 * Add the value for given key in User Defaults
 */
void SetUserDefaultsForKey(NSString *key, id);

/**
 * Add the Integer value for given key in User Defaults
 */
void SetIntegerUserDefaultsForKey(NSString *key, NSInteger value);

	/**
 * @return String value for given key in User Defaults
 */
NSString* StringFromUserDefaultsForKey(NSString *key);

/**
 * @return Integer value for given key in User Defaults
 */
NSInteger IntegerFromUserDefaultsForKey(NSString *key);

/**
 * @return id value for given key in User Defaults
 */
id ObjectFromUserDefaultsForKey(NSString *key);

/**
 * Archive given object and add for given key in User Defaults
 */
void ArchiveObjectForKey(NSString *key, id value);

/**
 * @return id value for given key in User Defaults and unarchiving data
 */
id UnArchiveObjectForKey(NSString *key);

/**
 * @return YES/NO
 */
BOOL IsArrayWithItems(id object);

/**
 * @return YES/NO
 */
BOOL IsArrayWithItemsMoreThanCount(id object, int count);

/**
 * @return YES/NO
 */
BOOL IsEmptyString(id object);

BOOL IsConnectedToNetwork();

BOOL isOS3Plus();

/**
 * @return path to store cache data 
 */
NSString* CachePath(NSString* path);

#define LocalizedString(key) \
   NSLocalizedString(key, @"")

#define EMPTY @""

#define SAFE_RELEASE(__POINTER) { [__POINTER release]; __POINTER = nil; }

