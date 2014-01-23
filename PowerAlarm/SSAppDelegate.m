//
//  SSAppDelegate.m
//  PowerAlarm
//
//  Created by Simon Gislen on 23/01/14.
//  Copyright (c) 2014 Simon Gislen. All rights reserved.
//

#import "SSAppDelegate.h"
#import <sys/cdefs.h>
@import AVFoundation;
#import <IOKit/ps/IOPowerSources.h>
@import CoreFoundation;

@interface SSAppDelegate ()

@property (nonatomic) AVAudioPlayer *player;
@end

@implementation SSAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(alarm) userInfo:nil repeats:YES];
    
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Alarm Clock.caf" ofType:nil]];
    self.player = [[AVAudioPlayer alloc] initWithData:data error:nil];
    [self.player prepareToPlay];
    self.player.numberOfLoops = 0;
    
}

- (void)alarm {
    if (IOPSCopyExternalPowerAdapterDetails() == NULL) {
        if (!self.player.isPlaying) {
            [self.player play];
        }
    }
    else {
        if (self.player.isPlaying)
            [self.player stop];
    }
    
}

@end
