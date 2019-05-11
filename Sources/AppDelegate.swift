//
//  AppDelegate.swift
//  WebRTC
//
//  Created by Stasel on 20/05/2018.
//  Copyright © 2018 Stasel. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  internal var window: UIWindow?
  private let config = Config.default
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    let window = UIWindow(frame: UIScreen.main.bounds)
    window.rootViewController = self.buildMainViewController()
    window.makeKeyAndVisible()
    self.window = window
    
    FirebaseApp.configure()
    
    // Firestore allows offline mode by default.
    // but I experimented an error when data that I deleted on Firestore still be returned on listener
    // so I will turn off offline to resolve this problem
    let settings = FirestoreSettings()
    settings.isPersistenceEnabled = false
    Firestore.firestore().settings = settings
    
    return true
  }
  
  private func buildMainViewController() -> UIViewController {
    let signalClient = SignalingClient()
    let webRTCClient = WebRTCClient(iceServers: self.config.webRTCIceServers)
    let mainViewController = MainViewController(
      signalClient: signalClient,
      webRTCClient: webRTCClient)
    let navViewController = UINavigationController(rootViewController: mainViewController)
    return navViewController
  }
}

