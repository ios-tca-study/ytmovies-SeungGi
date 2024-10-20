//
//  YTSMovieRepository.swift
//  YSTMovie TCA
//
//  Created by 이승기 on 10/6/24.
//

import Foundation

protocol YTSMovieRepository {
  func fetchMovie(limit: Int, page: Int?, term: String?, genre: Genre?, sortBy: SortBy?) async throws -> [Movie]
  
  func fetchBookmarkMovie(limit: Int, page: Int?) async throws -> [Movie]
  func addBookmark(for movie: Movie) async throws
  func removeBookmark(for movie: Movie) async throws
  func isBookmarked(id: String) async -> Bool
}
