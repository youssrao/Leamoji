//
//  VideoDetail.swift
//  Leamoji
//
//  Created by Youssra Outelli on 01/11/2018.
//  Copyright © 2018 Youssra Outelli. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class VideoDetailViewController: UIViewController {
  
  @IBOutlet var scrollView: UIScrollView!
  @IBOutlet var movieImage: UIImageView!
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var descriptionLabel: UILabel!
  
  var movie: Movie?
  
  func passedData() {
    
    guard let movie = movie else {
      assertionFailure("movie struct not loaded")
      return
    }
    
    titleLabel.text = movie.title
    movieImage.image = UIImage(named: movie.poster)
    descriptionLabel.text = movie.description
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    passedData()
    titleLabel.font = UIFont.boldSystemFont(ofSize: titleLabel.font.pointSize)
    scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 100)
  }
  
  @IBAction func playVideo(_ sender: UIButton) {
    
    guard let videoURL = Bundle.main.url(forResource: movie?.id, withExtension: "mp4") else {
      assertionFailure("wrong url")
      return
    }
    
    let player = AVPlayer(url: videoURL)
    let vc = EmojiAVPlayerViewController()
    
    vc.player = player
    vc.movie = movie
    
    present(vc, animated: true, completion: nil)
  }
}

extension VideoDetailViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: view.frame.height)
  }
}
