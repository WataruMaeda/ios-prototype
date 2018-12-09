//
//  StoreUtil.swift
//  Copyright © 2018 wataru maeda. All rights reserved.
//

import UIKit
import SwiftyStoreKit

class StoreUtil {
  
  static func purchase(_ productId: String,
                       completion: @escaping (_ success: Bool) -> Void) {
    
    SwiftyStoreKit.purchaseProduct(productId) { (result) in
      switch result {
      case .success(let purchase):
        
        print("Purchase Success: \(purchase.productId)")
        completion(true)
        
      case .error(let error):
        if error.code == .paymentCancelled { return }
        print("Purchase Failed: \(error)")
        completion(false)
      }
    }
  }
  
  static func restore(_ completion: @escaping (Bool, [Purchase])->Void) {
    
    SwiftyStoreKit.restorePurchases { (result) in
      
      if result.restoreFailedPurchases.count > 0 {
        
        print("Restore Failed: \(result.restoreFailedPurchases)")
        completion(false, [])
        
      } else if result.restoredPurchases.count > 0 {
        
        print("Restore Success: \(result.restoredPurchases)")
        completion(true, result.restoredPurchases)
        
      } else {
        
        print("No restore item")
        completion(false, [])
      }
    }
  }
}

// MARK: - Prod info

extension StoreUtil {

  static func isPurchased(productId: String) -> Bool {
    return StorageUtil.boolForKey(productId)
  }
  
  static func getPrice(productId: String,
                       completion: @escaping (_ price: String) -> Void) {
    if self.isPurchased(productId: productId) {
      completion(DeviceUtil.isJp ? "購入済み" :  "Purchased")
      return
    }
    
    // Get price info
    SwiftyStoreKit.retrieveProductsInfo(["\(productId)"]) { (result) in
      
      if result.retrievedProducts.first?.price == 0 {
        completion(DeviceUtil.isJp ? "無料" :  "Free")
        return
      }
      
      let price = DeviceUtil.isJp ? "購入" : "Buy"
      completion(result.retrievedProducts.first?.localizedPrice ?? price)
    }
  }
}

// MARK: - Setup

extension StoreUtil {

  // Setting for app startup
  static func completeTransactions() {
    
    SwiftyStoreKit.completeTransactions(atomically: true) { purchases in
      
      for purchase in purchases {
        if purchase.transaction.transactionState == .purchased ||
          purchase.transaction.transactionState == .restored {
          
          if purchase.needsFinishTransaction {
            // Deliver content from server, then:
            SwiftyStoreKit.finishTransaction(purchase.transaction)
          }
          print("purchased: \(purchase)")
        }
      }
    }
  }
}
