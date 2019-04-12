//
//  Movie.swift
//  Leamoji
//
//  Created by Youssra Outelli on 30/10/2018.
//  Copyright © 2018 Youssra Outelli. All rights reserved.
//

import Foundation
import UIKit

struct Movie {
  
  public let id: String
  public let title: String
  public let description: String
  public let poster: String
  public var markers: [Int: EmojiType]
  
  mutating func addMarkers(markers: [Int: EmojiType]) {
    self.markers = markers
  }
  
  public static func getMovieById(id: String) -> Movie? {

    var movie: Movie?

    MovieParser.useGetData { movies in
      let found: [Movie] = movies.filter({ $0.id == id })
      movie = found.first
    }
    
    return movie
  }
  
  enum CodingKeys: String, CodingKey {
    
    case id
    case title
    case description
    case poster
    case markers
  }
}

extension Movie: Encodable {
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    
    try container.encode(id, forKey: .id)
    try container.encode(title, forKey: .title)
    try container.encode(description, forKey: .description)
    try container.encode(poster, forKey: .poster)
    try container.encode(markers, forKey: .markers)
  }
}

extension Movie: Decodable {
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    id = try container.decode(String.self, forKey: .id)
    title = try container.decode(String.self, forKey: .title)
    description = try container.decode(String.self, forKey: .description)
    poster = try container.decode(String.self, forKey: .poster)
    markers = try container.decodeIfPresent([Int: EmojiType].self, forKey: .markers) ?? [Int: EmojiType]()
  }
}
