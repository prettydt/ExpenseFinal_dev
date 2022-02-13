//
//  BannerVC.swift
//  ExpenseFinal
//
//  Created by 夕拾 on 2022/2/13.
//

import Foundation
import GoogleMobileAds
import UIKit
import SwiftUI
final  class BannerVC: UIViewControllerRepresentable  {

    func makeUIViewController(context: Context) -> UIViewController {
        let adSize = GADAdSizeFromCGSize(CGSize(width: 300, height: 20))

        let view = GADBannerView(adSize: adSize)

        let viewController = UIViewController()
        view.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        view.rootViewController = viewController
        viewController.view.addSubview(view)
        viewController.view.frame = CGRect(origin: .zero, size: CGSize(width: 300, height: 20))
        view.load(GADRequest())

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
