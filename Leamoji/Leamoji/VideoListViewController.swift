//
//  ViewController.swift
//  Leamoji
//
//  Created by Youssra Outelli on 30/10/2018.
//  Copyright © 2018 Youssra Outelli. All rights reserved.
//

import UIKit

class VideoListViewController: UIViewController {
  
  @IBOutlet weak var collectionViewList: UICollectionView!
  
  fileprivate let itemsPerRow: CGFloat = 2
  fileprivate let gutterSize: CGFloat = 10
  
  let emoji = EmojiLogic()
  
  public var loadedData = [Movie]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    MovieParser.useGetData { [weak self] movies in
      self?.loadedData = movies
    }
    
    if AppDelegate.isDebug {
      emoji.checkFrames()
    }
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    collectionViewList.delegate = self
    collectionViewList.dataSource = self
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
  }
}

extension VideoListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return loadedData.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath) as? CollectionViewCell
      else {
        assertionFailure("couldn't make myCell")
        return UICollectionViewCell()
    }
    
    let posterUrl = loadedData[indexPath.row].poster
    myCell.moviePoster.image = UIImage(named: posterUrl)
    
    return myCell
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    guard let selectedIndex = collectionViewList.indexPathsForSelectedItems?.first,
      let target = segue.destination as? VideoDetailViewController
      else { return }
    
    target.movie = loadedData[selectedIndex.row]
  }
}

extension VideoListViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let availableWidth = collectionView.frame.width - gutterSize * (itemsPerRow + 1)
    let width  = availableWidth / itemsPerRow
    let height = width / (151 / 227)
    
    return CGSize(width: width, height: height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    
    return UIEdgeInsets(top: gutterSize, left: gutterSize, bottom: gutterSize, right: gutterSize)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    
    return gutterSize
  }
}
