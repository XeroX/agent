//
//  Agent.swift
//  Agent
//
//  Created by Christoffer Hallas on 6/2/14.
//  Copyright (c) 2014 Christoffer Hallas. All rights reserved.
//

import Foundation

class Agent: NSObject, NSURLConnectionDelegate {
  
  var request: NSMutableURLRequest? = nil
  var connection: NSURLConnection? = nil
  
  // No-op default callback
  var done: (Agent, NSURLResponse) -> () = { (req: Agent, res: NSURLResponse) -> () in }
  
  init (method: String, url: String) {
    super.init()
    let _url = NSURL(string: url)
    self.request = NSMutableURLRequest(URL: _url)
    self.request!.HTTPMethod = method;
    self.connection = NSURLConnection(request: self.request, delegate: self)
  }
  
  class func get (url: String) -> Agent {
    return Agent(method: "GET", url:url)
  }
  
  class func get (url: String, done: (Agent, NSURLResponse) -> ()) {
    Agent.get(url).end(done)
  }
  
  func end (done: (Agent, NSURLResponse) -> ()) {
    self.done = done
    self.connection!.start()
  }
  
  func connection (connection: NSURLConnection!, didReceiveResponse response: NSURLResponse!) {
    self.done(self, response)
  }
  
}