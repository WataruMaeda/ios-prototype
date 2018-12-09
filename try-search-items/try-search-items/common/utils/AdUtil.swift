//
//  AdUtil.swift
//  Copyright © 2018 wataru maeda. All rights reserved.
//

import UIKit
import GoogleMobileAds

let kAppId = ""

#if targetEnvironment(simulator)
  // develop
  let kFullAdId = "ca-app-pub-3940256099942544/4411468910"
  let kBannerAdId = "ca-app-pub-3940256099942544/2934735716"
#else
  // production
  let kFullAdId = ""
  let kBannerAdId = ""
#endif

class AdUtil: NSObject {
  
  static var shared = AdUtil()
  private override init() {} // Singleton
  
  internal var fullAd = GADInterstitial(adUnitID: kFullAdId)
  
  func setup() {
    
    // Initialize the Google Mobile Ads SDK.
    GADMobileAds.configure(withApplicationID: kAppId)
    
    // load interstecial
    fullAd = createFullAd()
  }
}

// MARK: Full Ad

extension AdUtil: GADInterstitialDelegate {
  
  internal func showFullAd() {
    if !fullAd.hasBeenUsed {
      if fullAd.isReady {
        if let viewController = UIViewController.topViewController {
          fullAd.present(fromRootViewController: viewController)
        }
      } else {
        fullAd.load(GADRequest())
      }
    } else {
      fullAd = createFullAd()
    }
  }
  
  fileprivate func createFullAd() -> GADInterstitial {
    let interstitial = GADInterstitial(adUnitID: kFullAdId)
    interstitial.delegate = self
    interstitial.load(GADRequest())
    return interstitial
  }
  
  // MARK: GADInterstitialDelegate
  
  func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
    print("interstitial:didFailToReceiveAdWithError: \(error.localizedDescription)")
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
      self.fullAd.load(GADRequest())
    }
  }
  
  func interstitialWillDismissScreen(_ ad: GADInterstitial) {
    print("interstitialWillDismissScreen")
    fullAd = createFullAd()
  }
}
