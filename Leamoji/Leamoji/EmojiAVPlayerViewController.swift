//
//  EmojiAVPlayerViewController.swift
//  Leamoji
//
//  Created by Youssra Outelli on 14/11/2018.
//  Copyright © 2018 Youssra Outelli. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import AVKit

class EmojiAVPlayerViewController: AVPlayerViewController {
  
  var movie: Movie?
  
  var playerItem: AVPlayerItem!
  var timeObserverToken: Any?
  
  var label = UILabel()
  var imageView = UIImageView()
  
  var isScrubbing: Bool {
    get {
      
      guard let player = self.player else { return false }
      // If rate is 0 the video is paused or we are scrubbing
      return (player.rate == 0)
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    createSubviews()
    
    addPeriodicTimeObserver()
  }
  
  func createSubviews() {
    
    label = UILabel.emojiImageFromType(type: .scary)
    label.tag = 1
    
    imageView = UIImageView.displayBuffer
    imageView.tag = 2
    imageView.isHidden = true
    
    contentOverlayView?.addSubview(label)
    contentOverlayView?.addSubview(imageView)
    
  }
  
  func addPeriodicTimeObserver() {
    
    let timeScale = CMTimeScale(NSEC_PER_SEC)
    let time = CMTime(seconds: 1.0, preferredTimescale: timeScale)
    
    timeObserverToken = player?.addPeriodicTimeObserver(forInterval: time, queue: .main) { [weak self] time in
      
      self?.handleTimeObserver(time: time)
    }
  }
  
  func updateLabel(emoji: EmojiType) {
    label.text = emoji.enumToEmoji
  }
  
  func updateBufer() {
    imageView.image = UIImageView.displayBuffer.image
    imageView.isHidden = false
  }
  
  func resetBuffer() {
    imageView.isHidden = true
  }
  
  func handleTimeObserver(time: CMTime) {
    
    guard let markers = MovieMarkers.getMovieById(id: ((movie?.id ?? "movie no value"))) else {
      assertionFailure("can't find movie id")
      return
    }
    
    let timeInSeconds = Int(time.seconds) + self.seekTime
    
    for (index, emoji) in markers.markers {
      if timeInSeconds == index {
        self.updateLabel(emoji: emoji)
      }
      
      // If we re scrubbing or the video is paused - add a view
      if self.isScrubbing {
        self.updateBufer()
      } else {
        self.resetBuffer()
      }
    }
  }
}

protocol EmojiSeeker {
  var seekTime: Int { get }
}


extension EmojiAVPlayerViewController: EmojiSeeker {
  
  var seekTime: Int {
    return 0
  }
}
