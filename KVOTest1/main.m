//
//  main.m
//  KVOTest1
//
//  Created by Michael Nachbaur on 11-07-28.
//  Copyright 2011 Decaf Ninja Software. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "KVOTest1AppDelegate.h"

int main(int argc, char *argv[])
{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, NSStringFromClass([KVOTest1AppDelegate class]));
    [pool release];
    return retVal;
}
