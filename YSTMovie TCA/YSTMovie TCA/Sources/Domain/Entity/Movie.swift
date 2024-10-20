//
//  Movie.swift
//  YSTMovie TCA
//
//  Created by 이승기 on 10/6/24.
//

import Foundation

struct Movie: Identifiable, Equatable, Hashable {
  let id: String
  let title: String
  let thumbnailImageUrl: String
  let description: String
  let rating: Double
  var isBookmarked: Bool
  let genre: [String]
}

extension Movie {
  static let mock = Movie(
    id: UUID().uuidString,
    title: "닥터스트레인지",
    thumbnailImageUrl: "https://i.namu.wiki/i/mHehCXIcnRUn5qNO5zh4Uzp15FjyikuvJqAfHJXCk7nSxyuAqy4FyB1TWC5UOmNI61oEoEU1JGrAM60NMdSStw.webp",
    description: "A thief who steals corporate secrets through the use of dream-sharing technology.",
    rating: 8.8,
    isBookmarked: true,
    genre: ["Action", "Sci-Fi", "Thriller"]
  )
}
