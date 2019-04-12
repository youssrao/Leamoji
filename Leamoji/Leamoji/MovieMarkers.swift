//
//  MovieID.swift
//  Leamoji
//
//  Created by Youssra Outelli on 13/11/2018.
//  Copyright © 2018 Youssra Outelli. All rights reserved.
//

import Foundation
import UIKit

struct MovieMarkers {
  
  public let id: String
  public var markers: [Int: EmojiType]
  
  enum CodingKeys: String, CodingKey {
    
    case id
    case markers
  }
  
  public static func getMovieById(id: String) -> MovieMarkers? {
    
    var movie: MovieMarkers?
    
    MovieParser.useGetParsedData { movies in
      let found: [MovieMarkers] = movies.filter({ $0.id == id })
      movie = found.first
    }
    
    return movie
  }
}

extension MovieMarkers: Decodable {
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    id = try container.decode(String.self, forKey: .id)
    markers = try container.decodeIfPresent([Int: EmojiType].self, forKey: .markers) ?? [Int: EmojiType]()
  }
}
