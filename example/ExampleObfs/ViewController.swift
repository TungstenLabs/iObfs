//
//  ViewController.swift
//  ExampleObfs
//
//  Created by Mike Tigas on 4/10/16.
//  Copyright © 2016 Mike Tigas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {

    // Wait a second for Tor to get set up and then
    // fire off an HTTPS request. In a real app we'd actually
    // connect to control port and check that we have a
    // good circuit.
    let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 1 * Int64(NSEC_PER_SEC))
    dispatch_after(time, dispatch_get_main_queue()) {
      let url = NSURL(string: "https://check.torproject.org/")
      let req = NSURLRequest(URL: url!)
      let webView:UIWebView = self.view as! UIWebView
      webView.loadRequest(req)
    }

    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

