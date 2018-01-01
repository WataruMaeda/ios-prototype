//
//  TimerPickerView.swift
//  try_local_notification
//
//  Created by Wataru Maeda on 2017/12/31.
//  Copyright © 2017 com.watarumaeda. All rights reserved.
//

import UIKit

class TimerPickerView: UIPickerView {
  
  lazy var itemList: [Int] = {
    var items = [Int]()
    for i in 1...100 { items.append(i) }
    return items
  }()
  
  lazy var didSelectItemCallback: (Int) -> () = { item in }
  
  func setupPicker() {
    delegate = self
    dataSource = self
    selectRow(0, inComponent: 0, animated: true)
  }
}

// MARK: - Action

extension TimerPickerView {
  
  func didSelectItem(_ callback: @escaping (Int) -> ()) {
    didSelectItemCallback = callback
  }
}

// MARK: UIPickerViewDataSource

extension TimerPickerView: UIPickerViewDataSource {
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return itemList.count
  }
}

// MARK: UIPickerViewDelegate

extension TimerPickerView: UIPickerViewDelegate {
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return "\(itemList[row])"
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    print(itemList[row])
    didSelectItemCallback(itemList[row])
  }
}
