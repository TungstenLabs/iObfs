//
//  AppDelegate.swift
//  ExampleObfs
//
//  Created by Mike Tigas on 4/10/16.
//  Copyright © 2016 Mike Tigas. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    NSURLProtocol.registerClass(TorProxyURLProtocol)


    let conf:TORConfiguration = TORConfiguration()
    conf.cookieAuthentication = NSNumber(booleanLiteral: true)
    conf.dataDirectory = NSURL(fileURLWithPath: NSTemporaryDirectory())

    var args = [
      "--socksport", "39050",

      "--UseBridges", "1",
      // Our hard-coded ports for pluggable transports
      "--ClientTransportPlugin", "obfs4 socks5 127.0.0.1:47351",
      "--ClientTransportPlugin", "meek_lite socks5 127.0.0.1:47352",
      "--ClientTransportPlugin", "obfs2 socks5 127.0.0.1:47353",
      "--ClientTransportPlugin", "obfs3 socks5 127.0.0.1:47354",
      "--ClientTransportPlugin", "scramblesuit socks5 127.0.0.1:47355",
      // Tor Browser Bundle's default obfs4 bridges
      "--Bridge", "obfs4 154.35.22.10:41835 8FB9F4319E89E5C6223052AA525A192AFBC85D55 cert=GGGS1TX4R81m3r0HBl79wKy1OtPPNR2CZUIrHjkRg65Vc2VR8fOyo64f9kmT1UAFG7j0HQ iat-mode=0",
      "--Bridge", "obfs4 198.245.60.50:443 752CF7825B3B9EA6A98C83AC41F7099D67007EA5 cert=xpmQtKUqQ/6v5X7ijgYE/f03+l2/EuQ1dexjyUhh16wQlu/cpXUGalmhDIlhuiQPNEKmKw iat-mode=0",
      "--Bridge", "obfs4 192.99.11.54:443 7B126FAB960E5AC6A629C729434FF84FB5074EC2 cert=VW5f8+IBUWpPFxF+rsiVy2wXkyTQG7vEd+rHeN2jV5LIDNu8wMNEOqZXPwHdwMVEBdqXEw iat-mode=0",
      "--Bridge", "obfs4 109.105.109.165:10527 8DFCD8FB3285E855F5A55EDDA35696C743ABFC4E cert=Bvg/itxeL4TWKLP6N1MaQzSOC6tcRIBv6q57DYAZc3b2AzuM+/TfB7mqTFEfXILCjEwzVA iat-mode=0",
      "--Bridge", "obfs4 83.212.101.3:41213 A09D536DD1752D542E1FBB3C9CE4449D51298239 cert=lPRQ/MXdD1t5SRZ9MquYQNT9m5DV757jtdXdlePmRCudUU9CFUOX1Tm7/meFSyPOsud7Cw iat-mode=0",
      "--Bridge", "obfs4 104.131.108.182:56880 EF577C30B9F788B0E1801CF7E433B3B77792B77A cert=0SFhfDQrKjUJP8Qq6wrwSICEPf3Vl/nJRsYxWbg3QRoSqhl2EB78MPS2lQxbXY4EW1wwXA iat-mode=0",
      "--Bridge", "obfs4 109.105.109.147:13764 BBB28DF0F201E706BE564EFE690FE9577DD8386D cert=KfMQN/tNMFdda61hMgpiMI7pbwU1T+wxjTulYnfw+4sgvG0zSH7N7fwT10BI8MUdAD7iJA iat-mode=0",
      "--Bridge", "obfs4 154.35.22.11:49868 A832D176ECD5C7C6B58825AE22FC4C90FA249637 cert=YPbQqXPiqTUBfjGFLpm9JYEFTBvnzEJDKJxXG5Sxzrr/v2qrhGU4Jls9lHjLAhqpXaEfZw iat-mode=0",
      "--Bridge", "obfs4 154.35.22.12:80 00DC6C4FA49A65BD1472993CF6730D54F11E0DBB cert=N86E9hKXXXVz6G7w2z8wFfhIDztDAzZ/3poxVePHEYjbKDWzjkRDccFMAnhK75fc65pYSg iat-mode=0",
      "--Bridge", "obfs4 154.35.22.13:443 FE7840FE1E21FE0A0639ED176EDA00A3ECA1E34D cert=fKnzxr+m+jWXXQGCaXe4f2gGoPXMzbL+bTBbXMYXuK0tMotd+nXyS33y2mONZWU29l81CA iat-mode=0",
      "--Bridge", "obfs4 154.35.22.10:80 8FB9F4319E89E5C6223052AA525A192AFBC85D55 cert=GGGS1TX4R81m3r0HBl79wKy1OtPPNR2CZUIrHjkRg65Vc2VR8fOyo64f9kmT1UAFG7j0HQ iat-mode=0",
      "--Bridge", "obfs4 154.35.22.10:443 8FB9F4319E89E5C6223052AA525A192AFBC85D55 cert=GGGS1TX4R81m3r0HBl79wKy1OtPPNR2CZUIrHjkRg65Vc2VR8fOyo64f9kmT1UAFG7j0HQ iat-mode=0",
      "--Bridge", "obfs4 154.35.22.11:443 A832D176ECD5C7C6B58825AE22FC4C90FA249637 cert=YPbQqXPiqTUBfjGFLpm9JYEFTBvnzEJDKJxXG5Sxzrr/v2qrhGU4Jls9lHjLAhqpXaEfZw iat-mode=0",
      "--Bridge", "obfs4 154.35.22.11:80 A832D176ECD5C7C6B58825AE22FC4C90FA249637 cert=YPbQqXPiqTUBfjGFLpm9JYEFTBvnzEJDKJxXG5Sxzrr/v2qrhGU4Jls9lHjLAhqpXaEfZw iat-mode=0",

      "--ignore-missing-torrc"
      
    ]


    // controlsocket path length is often too long
    #if (arch(i386) || arch(x86_64)) && (os(iOS) || os(watchOS) || os(tvOS))
      args += [
        "--controlport", "127.0.0.1:39060"
      ]
    #else
      conf.controlSocket = conf.dataDirectory?.URLByAppendingPathComponent("control_port")
    #endif

    conf.arguments = args;

    let torThread:TORThread = TORThread(configuration: conf)
    torThread.start()

    let obfsThread:ObfsThread = ObfsThread()
    obfsThread.start()

    /*
    let cookiePath:NSURL? = conf.dataDirectory?.URLByAppendingPathComponent("control_auth_cookie")

    // wait one second for tor to start up and actually
    // write the cookie file.
    let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 2 * Int64(NSEC_PER_SEC))
    dispatch_after(time, dispatch_get_main_queue()) {
        let cookie:NSData = NSData(contentsOfURL: cookiePath!)!

        #if (arch(i386) || arch(x86_64)) && (os(iOS) || os(watchOS) || os(tvOS))
            let controller:TORController = TORController(socketHost: "127.0.0.1", port: 39060)
        #else
            let controller:TORController = TORController(socketURL: conf.controlSocket!)
        #endif
        controller.authenticateWithData(cookie) { (success, error) in
          print("we're in!")
          if !success {
            print("err: %@", error)
          }
        }
    }
    */


    // Override point for customization after application launch.
    return true
  }

  func applicationWillResignActive(application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }


}

