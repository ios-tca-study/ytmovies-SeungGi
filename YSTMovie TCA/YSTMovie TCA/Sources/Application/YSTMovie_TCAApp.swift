//
//  YSTMovie_TCAApp.swift
//  YSTMovie TCA
//
//  Created by 이승기 on 9/21/24.
//

import SwiftUI

@main
struct YSTMovie_TCAApp: App {
  
  init() {
    loadRocketSimConnect()
  }
  
  var body: some Scene {
    WindowGroup {
      MainTabView()
    }
  }
  
  private func loadRocketSimConnect() {
    #if DEBUG
    guard (Bundle(path: "/Applications/RocketSim.app/Contents/Frameworks/RocketSimConnectLinker.nocache.framework")?.load() == true) else {
      print("Failed to load linker framework")
      return
    }
    print("RocketSim Connect successfully linked")
    #endif
  }
}
