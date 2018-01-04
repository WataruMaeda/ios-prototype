//
//  TimePickerView.swift
//  try_local_notification
//
//  Created by Wataru Maeda on 2018/01/03.
//  Copyright © 2018 com.watarumaeda. All rights reserved.
//

import UIKit

class TimePickerView: UIView {
  
  let picker: UIPickerView = {
    let picker = UIPickerView()
    picker.selectRow(0, inComponent: 0, animated: true)
    return picker
  }()
  
  let cancelButton: UIButton = {
    let button = UIButton()
    button.setTitle("Cancel", for: .normal)
    button.setTitleColor(.black, for: .normal)
    button.titleLabel?.textAlignment = .left
    return button
  }()
  
  let doneButton: UIButton = {
    let button = UIButton()
    button.setTitle("Done", for: .normal)
    button.setTitleColor(.black, for: .normal)
    button.titleLabel?.textAlignment = .right
    return button
  }()
  
  let repeatLavel: UILabel = {
    let label = UILabel()
    label.text = "Repeat"
    label.font = .systemFont(ofSize: 12)
    return label
  }()
  
  let repeatSwitch: UISwitch = {
    let sw = UISwitch()
    sw.isOn = false
    return sw
  }()
  
  lazy var timeList: [Int] = {
    var items = [Int]()
    for i in 1...100 { items.append(i) }
    return items
  }()
  
  lazy var timeUnitList: [String] = {
    return ["sec", "min", "hour", "day", "week", "month"]
  }()
  
  lazy var didSelectItemCallback: (Int) -> () = { item in }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.initView()
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    self.initView()
  }
  
  // MARK: - UI
  
  private func initView() {
    backgroundColor = .white
    addSubview(picker)
    picker.delegate = self
    picker.dataSource = self
  }
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
  }
}

// MARK: - Action

extension TimePickerView {
  
  func didSelectItem(_ callback: @escaping (Int) -> ()) {
    didSelectItemCallback = callback
  }
}

// MARK: UIPickerViewDataSource

extension TimePickerView: UIPickerViewDataSource {
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 2
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    
    return (component == 0) ? timeList.count : timeUnitList.count
  }
}

// MARK: UIPickerViewDelegate

extension TimePickerView: UIPickerViewDelegate {
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return (component == 0) ? "\(timeList[row])" : timeUnitList[row]
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    print(timeList[row])
    didSelectItemCallback(timeList[row])
  }
}
