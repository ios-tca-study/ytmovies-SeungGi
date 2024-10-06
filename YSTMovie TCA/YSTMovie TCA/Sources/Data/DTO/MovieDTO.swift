//
//  MovieDTO.swift
//  YSTMovie TCA
//
//  Created by 이승기 on 10/6/24.
//

import Foundation

struct MovieDTO: Decodable {
  let id: Int
  let title: String
  let thumbnailImageUrl: String
  let descriptionFull: String
  let rating: Double
  let genres: [String]
  
  enum CodingKeys: String, CodingKey {
    case id
    case title
    case thumbnailImageUrl = "large_cover_image"
    case descriptionFull = "description_full"
    case rating
    case genres
  }
}

// MARK: - Mapping

extension MovieDTO {
  func toDomain() -> Movie {
    return Movie(
      id: String(id),
      title: title,
      thumbnailImageUrl: thumbnailImageUrl,
      description: descriptionFull,
      rating: rating,
      isBookmarked: false, // API에서 북마크 상태를 제공하지 않으므로 기본값 사용
      genre: genres
    )
  }
}
