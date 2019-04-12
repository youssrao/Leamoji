//
//  Extensions.swift
//  Leamoji
//
//  Created by Youssra Outelli on 15/11/2018.
//  Copyright © 2018 Youssra Outelli. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
  
  static var displayBuffer: UIImageView {
    
    let image = UIImage(named: "Buffer")
    let imageView = UIImageView(image: image)
    
    imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
    imageView.center = CGPoint(x: 40, y: 150)
    imageView.backgroundColor = UIColor.white
    
    return imageView
  }
}


extension UILabel {
  
  static func emojiImageFromType(type: EmojiType) -> UILabel {
    
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    
    label.center = CGPoint(x: 40, y: 150)
    label.backgroundColor = UIColor.clear
    label.font = UIFont.systemFont(ofSize: 46)
    label.textAlignment = .center
    label.text = type.enumToEmoji
    
    return label
  }
  
  static func displayTimer() {
    
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    
    label.center = CGPoint(x: 40, y: 200)
    label.backgroundColor = UIColor.white
    label.font = UIFont.systemFont(ofSize: 46)
    label.textAlignment = .center
  }
  
  
  
  
}
