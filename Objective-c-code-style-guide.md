## Introduction
A good code style is benifit with reading and code review. For me, I follow the 
language guide when coding with Objective-c.

Here are some of the documents from Apple that informed the style guide.  

one of these:

* [The Objective-C Programming Language](http://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/ObjectiveC/Introduction/introObjectiveC.html)
* [Cocoa Fundamentals Guide](https://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/CocoaFundamentals/Introduction/Introduction.html)
* [Coding Guidelines for Cocoa](https://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/CodingGuidelines/CodingGuidelines.html)
* [iOS App Programming Guide](http://developer.apple.com/library/ios/#documentation/iphone/conceptual/iphoneosprogrammingguide/Introduction/Introduction.html)
* [github/objective-c-style-guide](https://github.com/github/objective-c-style-guide)

## Booleans

Never compare something directly to `YES`, because `YES` is defined as `1`, and a `BOOL` in Objective-C is a `CHAR` type that is 8 bits long (so a value of `11111110` will return `NO` if compared to `YES`).

**For an object pointer:**

```objc
if (!someObject) {
}

if (someObject == nil) {
}
```

**For a `BOOL` value:**

```objc
if (isAwesome)
if (!someNumber.boolValue)
if (someNumber.boolValue == NO)
```
**Not:**

```objc
if (isAwesome == YES) // Never do this.
```

If the name of a `BOOL` property is expressed as an adjective, the property’s name can omit the `is` prefix but should specify the conventional name for the getter.

## Private Properties

Private properties should be declared in class extensions (anonymous categories) in the implementation file of a class.

**For example:**

```objc
@interface NYTAdvertisement ()

@property (nonatomic, strong) GADBannerView *googleAdView;
@property (nonatomic, strong) ADBannerView *iAdView;
@property (nonatomic, strong) UIWebView *adXWebView;

@end
```

## Bitmasks

When working with bitmasks, use the `NS_OPTIONS` macro.

**Example:**

```objc
typedef NS_OPTIONS(NSUInteger, NYTAdCategory) {
    NYTAdCategoryAutos      = 1 << 0,
    NYTAdCategoryJobs       = 1 << 1,
    NYTAdCategoryRealState  = 1 << 2,
    NYTAdCategoryTechnology = 1 << 3
};
```
## Enumerated Types

When using `enum`s, use the new fixed underlying type specification, which provides stronger type checking and code completion. The SDK includes a macro to facilitate and encourage use of fixed underlying types: `NS_ENUM()`.

**Example:**

```objc
typedef NS_ENUM(NSInteger, NYTAdRequestState) {
    NYTAdRequestStateInactive,
    NYTAdRequestStateLoading
};
```

## Singletons

Singleton objects should use a thread-safe pattern for creating their shared instance.
```objc
+ (instancetype)sharedInstance {
    static id sharedInstance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });

    return sharedInstance;
}
```

## Whitespace

 * Tabs, not spaces.
 * End files with a newline.
 * Make liberal use of vertical whitespace to divide code into logical chunks.
 * Don’t leave trailing whitespace.
 * Not even leading indentation on blank lines.

## Documentation and Organization

 * All method declarations should be documented.
 * Comments should be hard-wrapped at 80 characters.
 * Comments should be [Tomdoc](http://tomdoc.org/)-style.
 * Document whether object parameters allow `nil` as a value.
 * Use `#pragma mark`s to categorize methods into functional groupings and protocol implementations, following this general structure:

```objc
#pragma mark Properties

@dynamic someProperty;

- (void)setCustomProperty:(id)value {}

#pragma mark Lifecycle

+ (instancetype)objectWithThing:(id)thing {}
- (instancetype)init {}

#pragma mark Drawing

- (void)drawRect:(CGRect) {}

#pragma mark Another functional grouping

#pragma mark GHSuperclass

- (void)someOverriddenMethod {}

#pragma mark NSCopying

- (id)copyWithZone:(NSZone *)zone {}

#pragma mark NSObject

- (NSString *)description {}
```

## Declarations

 * Never declare an ivar unless you need to change its type from its declared property.
 * Don’t use line breaks in method declarations.
 * Prefer exposing an immutable type for a property if it being mutable is an implementation detail. This is a valid reason to declare an ivar for a property.
 * Always declare memory-management semantics even on `readonly` properties.
 * Declare properties `readonly` if they are only set once in `-init`.
 * Don't use `@synthesize` unless the compiler requires it. Note that optional properties in protocols must be explicitly synthesized in order to exist.
 * Declare properties `copy` if they return immutable objects and aren't ever mutated in the implementation. `strong` should only be used when exposing a mutable object, or an object that does not conform to `<NSCopying>`.
 * Avoid `weak` properties whenever possible. A long-lived weak reference is usually a code smell that should be refactored out.
 * Instance variables should be prefixed with an underscore (just like when implicitly synthesized).
 * Don't put a space between an object type and the protocol it conforms to.

```objc
@property (attributes) id<Protocol> object;
@property (nonatomic, strong) NSObject<Protocol> *object;
```

 * C function declarations should have no space before the opening parenthesis, and should be namespaced just like a class.

```objc
void GHAwesomeFunction(BOOL hasSomeArgs);
```

 * Constructors should generally return [`instancetype`](http://clang.llvm.org/docs/LanguageExtensions.html#related-result-types) rather than `id`.
 * Prefer helper functions (such as `CGRectMake()`) to C99 struct initialiser syntax.

```objc
  CGRect rect = CGRectMake(3.0, 12.0, 15.0, 80.0);
   ```

## Expressions

 * Don't access an ivar unless you're in `-init`, `-dealloc` or a custom accessor.
 * Use dot-syntax when invoking idempotent methods, including setters and class methods (like `NSFileManager.defaultManager`).
 * Use object literals, boxed expressions, and subscripting over the older, grosser alternatives.
 * Comparisons should be explicit for everything except `BOOL`s.
 * Prefer positive comparisons to negative.
 * Long form ternary operators should be wrapped in parentheses and only used for assignment and arguments.

```objc
Blah *a = (stuff == thing ? foo : bar);
```

* Short form, `nil` coalescing ternary operators should avoid parentheses.

```objc
Blah *b = thingThatCouldBeNil ?: defaultValue;
```

 * Separate binary operands with a single space, but unary operands and casts with none:

```c
void *ptr = &value + 10 * 3;
NewType a = (NewType)b;

for (int i = 0; i < 10; i++) {
    doCoolThings();
}
```

## Control Structures

 * Always surround `if` bodies with curly braces if there is an `else`. Single-line `if` bodies without an `else` should be on the same line as the `if`.
 * All curly braces should begin on the same line as their associated statement. They should end on a new line.
 * Put a single space after keywords and before their parentheses.
 * Return and break early.
 * No spaces between parentheses and their contents.

```objc
if (somethingIsBad) return;

if (something == nil) {
	// do stuff
} else {
	// do other stuff
}
```

## Exceptions and Error Handling

 * Don't use exceptions for flow control.
 * Use exceptions only to indicate programmer error.
 * To indicate errors, use an `NSError **` argument or send an error on a [ReactiveCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa) signal.

## Blocks

 * Blocks should have a space between their return type and name.
 * Block definitions should omit their return type when possible.
 * Block definitions should omit their arguments if they are `void`.
 * Parameters in block types should be named unless the block is initialized immediately.

```objc
void (^blockName1)(void) = ^{
    // do some things
};

id (^blockName2)(id) = ^ id (id args) {
    // do some things
};
```

## Literals

 * Avoid making numbers a specific type unless necessary (for example, prefer `5` to `5.0`, and `5.3` to `5.3f`).
 * The contents of array and dictionary literals should have a space on both sides.
 * Dictionary literals should have no space between the key and the colon, and a single space between colon and value.

``` objc
NSArray *theStuff = @[ @1, @2, @3 ];

NSDictionary *keyedStuff = @{ GHDidCreateStyleGuide: @YES };
```

 * Longer or more complex literals should be split over multiple lines (optionally with a terminating comma):

``` objc
NSArray *theStuff = @[
    @"Got some long string objects in here.",
    [AndSomeModelObjects too],
    @"Moar strings."
];

NSDictionary *keyedStuff = @{
    @"this.key": @"corresponds to this value",
    @"otherKey": @"remoteData.payload",
    @"some": @"more",
    @"JSON": @"keys",
    @"and": @"stuff",
};
```

## Categories

 * Categories should be named for the sort of functionality they provide. Don't create umbrella categories.
 * Category methods should always be prefixed.
 * If you need to expose private methods for subclasses or unit testing, create a class extension named `Class+Private`.


## Protocols

In a [delegate or data source protocol](https://developer.apple.com/library/ios/documentation/General/Conceptual/CocoaEncyclopedia/DelegatesandDataSources/DelegatesandDataSources.html), the first parameter to each method should be the object sending the message.

This helps disambiguate in cases when an object is the delegate for multiple similarly-typed objects, and it helps clarify intent to readers of a class implementing these delegate methods.

**For example:**

```objc
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
```

**Not:**

```objc
- (void)didSelectTableRowAtIndexPath:(NSIndexPath *)indexPath;
```

