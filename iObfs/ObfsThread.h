//
//  ObfsThread.h
//  iObfs
//
//  Created by Mike Tigas on 4/9/16.
//  Copyright © 2016 Mike Tigas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObfsThread : NSThread

@property (nonatomic) unsigned int obfs4SocksPort;
@property (nonatomic) unsigned int meekSocksPort;
@property (nonatomic) unsigned int obfs2SocksPort;
@property (nonatomic) unsigned int obfs3SocksPort;
@property (nonatomic) unsigned int scramblesuitSocksPort;

@end
