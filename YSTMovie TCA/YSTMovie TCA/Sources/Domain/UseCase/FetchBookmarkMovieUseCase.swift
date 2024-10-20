//
//  FetchBookmarkMovieUseCase.swift
//  YSTMovie TCA
//
//  Created by 이승기 on 10/20/24.
//

import Foundation

struct FetchBookmarkMovieUseCase {
  
  // MARK: - Properties
  
  private let repository: YTSMovieRepository
  
  
  // MARK: - Initializers
  
  init(repository: YTSMovieRepository) {
    self.repository = repository
  }
  
  
  // MARK: - Initializers
  
  public func execute(limit: Int, page: Int?) async throws -> [Movie] {
    let movie = try await repository.fetchBookmarkMovie(limit: limit, page: page)
    return movie
  }
}
