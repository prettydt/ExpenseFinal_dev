//
//  ExpenseFinalApp.swift
//  ExpenseFinal
//
//  Created by 国梁李 on 2021/12/14.
//

import SwiftUI
import GoogleMobileAds
@main
struct ExpenseFinalApp: App {
    let persistenceController = PersistenceController.shared
    init() {

            GADMobileAds.sharedInstance().start(completionHandler: nil)
        GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = [ GADSimulatorID ]
    }
    var body: some Scene {
        WindowGroup {
            NewMainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environment(\.locale, Locale(identifier: "zh-cn"))
                .font(MyFont.body)
        }

    }
}
struct MyFont {
  static let title = Font.custom("MaShanZheng-Regular", size: 24.0)
  static let body = Font.custom("MaShanZheng-Regular", size: 20.0)
}
