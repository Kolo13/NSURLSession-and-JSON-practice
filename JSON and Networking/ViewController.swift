//
//  ViewController.swift
//  JSON and Networking
//
//  Created by Kori Kolodziejczak on 8/31/14.
//  Copyright (c) 2014 Kori Kolodziejczak. All rights reserved.
//
//A good little tutorial for understanding some of the NSURL related concepts
//http://www.raywenderlich.com/67081/cookbook-using-nsurlsession

import UIKit

class ViewController: UIViewController {
  var imageDownloadQueue = NSOperationQueue()
  var gitUserJSON = NSData()

  override func viewDidLoad(){
    super.viewDidLoad()
    
    // Getting JSON from https: //api.github.com/users/<UserName>
    var downloadURL = NSURL(string: "https://api.github.com/users/kolo13")
    
    //The NSURLSession class and related classes provide an API for downloading content via HTTP
    let gitSession = NSURLSession.sharedSession()
    
    //The other big part of NSURLSession is session tasks, which handle the loading of data, as well as uploading and downloading files and data between the client and server. NSURLSessionTask is most analogous to NSURLConnection in that it is responsible for loading data, with the main difference being that tasks share the common delegate of their parent NSURLSession. (referenced from www.objc.io/issue-5/from-nsurlconnection-to-nsurlsession.html )
    let gitTask = gitSession.dataTaskWithURL(downloadURL, completionHandler: { (data, response, error) -> Void in
      
      var JSONerr: NSError?
      
      //Coverting NSData to NSDictionary
      var gitUserDict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &JSONerr) as NSDictionary
      
      //Retrieving User's Profile Pic URL
      var gitUserPicURL: String = gitUserDict["avatar_url"] as String
      
    })
    // Session Tasks all start in suspended state so you have to tell the process when to continue ( referenced from www.raywenderlich.com/67081/cookbook-using-nsurlsession)
    gitTask.resume()

  
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

