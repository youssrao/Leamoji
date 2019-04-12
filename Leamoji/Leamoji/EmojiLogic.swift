//
//  EmojiLogic.swift
//  Leamoji
//
//  Created by Youssra Outelli on 06/11/2018.
//  Copyright © 2018 Youssra Outelli. All rights reserved.
//

import UIKit
import CoreML

public enum EmojiType: String, Codable {
  
  case scary = "Scary"
  case happy = "Happy"
  case neutral = "Neutral"
  
  var enumToEmoji: String {
    
    switch (self) {
    case .scary:
      return "😱"
//    case .happy:
//      return "😃"
//    case .neutral:
//      return "😶"
    default:
      return ""
    }
  }
}

class EmojiLogic {
  
  var model = EmojiModel()
  
  func emojiType(from image: UIImage) -> EmojiType {
    
    guard let pixelBuffer = self.createPixelBuffer(image: image) else {
      return .neutral
    }
    
    let prediction = try? model.prediction(image: pixelBuffer)
    
    guard let emojiType = prediction?.classLabel, let type = EmojiType(rawValue: emojiType) else {
      return .neutral
    }
    
    return type
  }
  
  func createPixelBuffer(image: UIImage) -> CVPixelBuffer? {
    
    let width = Int(image.size.width)
    let height = Int(image.size.height)
    let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
    
    var pixelBufferFirst: CVPixelBuffer?
    let status = CVPixelBufferCreate(kCFAllocatorDefault, width, height, kCVPixelFormatType_32ARGB, attrs, &pixelBufferFirst)
    
    guard (status == kCVReturnSuccess), let pixelBuffer = pixelBufferFirst else {
      return nil
    }
    
    CVPixelBufferLockBaseAddress(pixelBuffer, CVPixelBufferLockFlags(rawValue: 0))
    
    let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer)
    let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
    let bytesperRow = CVPixelBufferGetBytesPerRow(pixelBuffer)
    let bitMapInfo = CGImageAlphaInfo.noneSkipFirst.rawValue
    
    guard let context = CGContext(data: pixelData, width: width, height: height, bitsPerComponent: 8, bytesPerRow: bytesperRow, space: rgbColorSpace, bitmapInfo: bitMapInfo) else {
      assertionFailure("context issue pixelbuffer")
      return nil
    }
    context.translateBy(x: 0, y: image.size.height)
    context.scaleBy(x: 1.0, y: -1.0)
    
    UIGraphicsPushContext(context)
    image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
    UIGraphicsPopContext()
    CVPixelBufferUnlockBaseAddress(pixelBuffer, CVPixelBufferLockFlags(rawValue: 0))
    
    return pixelBuffer
  }
  
  func checkFrames() {
    
    MovieParser.useGetData { movies in
      
      var jsonToWrite = [Movie]()
      
      for movie in movies {
        let images = Bundle.main.paths(forResourcesOfType: "jpeg", inDirectory: movie.id)
        
        var results = [Int: EmojiType]()
        for image in images {
          
          guard let imageAsset = UIImage(named: image) else { return }
          
          let timestamp = Int(String(image.split(separator: "/").last!).replacingOccurrences(of: ".jpeg", with: ""))!
          
          let emoji = emojiType(from: imageAsset)
          results[timestamp] = emoji
        }
        
        let newMovie = Movie(id: movie.id,
                             title: movie.title,
                             description: movie.description,
                             poster: movie.poster,
                             markers: results)
        print(newMovie)
        jsonToWrite.append(newMovie)
      }
      write(json: jsonToWrite)
    }
    
    func write(json: [Movie]) {
      let filename = getDocumentsDirectory().appendingPathComponent("MovieData.json")
      print(filename)
      do {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        
        guard let data = try? encoder.encode(json) else {
          assertionFailure("couldn't encode json data")
          return
        }
        
        try String(data: data, encoding: .utf8)?.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
      } catch let error {
        print(error)
        assertionFailure("failed to write file")
      }
    }
  }
  
  func getDocumentsDirectory() -> URL {
    
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
  }
}
