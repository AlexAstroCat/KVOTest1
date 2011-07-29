//
//  AppStoreItemView.m
//  KVOTest1
//
//  Created by Michael Nachbaur on 11-07-28.
//  Copyright 2011 Decaf Ninja Software. All rights reserved.
//

#import "AppStoreItemView.h"
#import <QuartzCore/QuartzCore.h>

static NSSet * ObservableKeys = nil;
static NSString * const IconKeyPath = @"icon";
static NSString * const IconNeedsGlossEffectKeyPath = @"iconNeedsGlossEffect";

@interface AppStoreItemView ()

- (UIImage*)glossImageForImage:(UIImage*)image;

@end

@implementation AppStoreItemView

@synthesize icon;
@synthesize iconNeedsGlossEffect;

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
{
    // Setup our set of observable keys only once
    if (nil == ObservableKeys) {
        ObservableKeys = [[NSSet alloc] initWithObjects:
                          IconKeyPath,
                          IconNeedsGlossEffectKeyPath,
                          nil];
    }

    self = [super initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:reuseIdentifier];
    if (nil != self) {
        // Add observers for each of the keyPaths we care about
        for (NSString *keyPath in ObservableKeys)
            [self addObserver:self
                   forKeyPath:keyPath
                      options:(NSKeyValueObservingOptionOld |
                               NSKeyValueObservingOptionNew)
                      context:nil];
        
        self.imageView.layer.cornerRadius = 10.0;
        self.imageView.layer.masksToBounds = YES;
    }
    
    return self;
}

- (void)dealloc {
    // Tidy up and remove all the observers when the view is destroyed
    for (NSString *keyPath in ObservableKeys)
        [self removeObserver:self
                  forKeyPath:keyPath
                     context:nil];
    
    [super dealloc];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    // If the keyPath being changed isn't one we care about,
    // pass this up to super and return immediately.
    if (![ObservableKeys containsObject:keyPath]) {
        [super observeValueForKeyPath:keyPath
                             ofObject:object
                               change:change
                              context:context];
        return;
    }
    
    // Fetch the old and new objects from the change dictionary
    id oldObject = [change objectForKey:NSKeyValueChangeOldKey];
    id newObject = [change objectForKey:NSKeyValueChangeNewKey];
    
    // Detect null values, since the changed object references
    // are object references.
    if ([NSNull null] == (NSNull*)oldObject)
        oldObject = nil;
    if ([NSNull null] == (NSNull*)newObject)
        newObject = nil;
    
    // Update imageView when the icon is changed
    if ([IconKeyPath isEqualToString:keyPath]) {
        self.imageView.image = [self glossImageForImage:newObject];
    }
    
    // If the gloss effect is changed, refresh the gloss image
    else if ([IconNeedsGlossEffectKeyPath isEqualToString:keyPath]) {
        self.imageView.image = [self glossImageForImage:self.icon];
    }
    
    
}

- (UIImage*)glossImageForImage:(UIImage*)image {
    static UIImage *overlayImage = nil;
    static UIImage *overlayMask = nil;
    if (nil == overlayImage) {
        overlayImage = [UIImage imageNamed:@"IconOverlay"];
        overlayMask = [UIImage imageNamed:@"IconMask"];
    }
    
    // Create a new CGImage from the new object, and merge our overlay image onto it
    UIGraphicsBeginImageContextWithOptions(overlayImage.size,
                                           NO,
                                           [[UIScreen mainScreen] scale]);
    
    // Draw our new image and the icon overlay to the context
    [image drawAtPoint:CGPointZero];
    
    if (self.iconNeedsGlossEffect) {
        [overlayImage drawAtPoint:CGPointZero];
        [overlayMask drawAtPoint:CGPointZero];
    }
    
    // Retrieve the merged image, and destroy our drawing context
    UIImage *mergedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Return the resulting image
    return mergedImage;
}

@end
