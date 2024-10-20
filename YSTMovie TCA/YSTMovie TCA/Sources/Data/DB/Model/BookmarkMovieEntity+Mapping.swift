//
//  BookmarkMovieEntity+Mapping.swift
//  YSTMovie TCA
//
//  Created by 이승기 on 10/20/24.
//

import Foundation

extension BookmarkMovieEntity {
  func toDomain() -> Movie {
    return .init(
      id: self.id!,
      title: self.title!,
      thumbnailImageUrl: self.thumbnailImageUrl ?? "",
      description: self.movieDescription ?? "",
      rating: self.rating,
      isBookmarked: self.isBookmarked,
      genre: self.genre ?? []
    )
  }
}
