//
//  AppDelegate.swift
//  MovieWorld
//
//  Created by Todd Isaacs on 7/13/16.
//  Copyright © 2016 Todd Isaacs. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  //MARK: variables
  var window: UIWindow?

  //MARK: lifecycle
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // Override point for customization after application launch.
    
    let coreDataStack = CoreDataStack()
    
    print("Context Name: \(coreDataStack.context.name!)")
    return true
  }
  
}

