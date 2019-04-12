//
//  CollectionViewCell.swift
//  Leamoji
//
//  Created by Youssra Outelli on 31/10/2018.
//  Copyright © 2018 Youssra Outelli. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewCell: UICollectionViewCell {
  
    @IBOutlet var moviePoster: UIImageView!
  
  override func prepareForReuse() {
    self.moviePoster.image = nil
  }
}
