//
//  MovieParser.swift
//  Leamoji
//
//  Created by Youssra Outelli on 31/10/2018.
//  Copyright © 2018 Youssra Outelli. All rights reserved.
//

import Foundation

public final class MovieParser {
  
  static func useGetData(completion: ([Movie]) -> Void) {
    
    var movies = [Movie]()
    
    do {
      movies = try MovieParser.getData()
      completion(movies)
    }
    catch let error {
      print(error)
    }
  }
  
  static func useGetParsedData(completion: ([MovieMarkers]) -> Void) {
    
    var movieID = [MovieMarkers]()
    
    do {
      movieID = try MovieParser.getParsedData()
      completion(movieID)
    }
    catch let error{
      print(error)
    }
  }
  
  
  
  static func getData() throws -> [Movie] {
    
    guard let url = Bundle.main.url(forResource: "MovieData", withExtension: "json") else {
      assertionFailure("couldn't find url of MovieData.json")
      return []
    }
    
    do {
      guard let data = try? Data(contentsOf: url) else {
        assertionFailure("couldn't fetch content of url")
        return []
      }
      
      let decoder = JSONDecoder()
      let movies = try decoder.decode([Movie].self, from: data)
      
      return movies
    } catch let error {
      print("Retrieve failed: URL: '\(url))', Error: '\(error)'")
      throw error
    }
  }
  
  
  static func getParsedData() throws -> [MovieMarkers] {

    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let url = paths.appendingPathComponent("MovieData.json")

    do {
      guard let data = try? Data(contentsOf: url) else {
        assertionFailure("couldn't fetch content of url")
        return []
      }

      let decoder = JSONDecoder()
      let movieID = try decoder.decode([MovieMarkers].self, from: data)

      return movieID
    }
    catch let error {
      print("Retrieve failed: URL: \(url), Error: \(error)")
      throw error
    }
  }
}
