//
//  AppStoreItemView.h
//  KVOTest1
//
//  Created by Michael Nachbaur on 11-07-28.
//  Copyright 2011 Decaf Ninja Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppStoreItemView : UITableViewCell

@property (nonatomic, retain) UIImage *icon;
@property (nonatomic) BOOL iconNeedsGlossEffect;

@end
