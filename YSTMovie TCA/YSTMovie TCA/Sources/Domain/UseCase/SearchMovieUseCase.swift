//
//  SearchMovieUseCase.swift
//  YSTMovie TCA
//
//  Created by 이승기 on 10/9/24.
//

import Foundation

struct SearchMovieUseCase {
  
  // MARK: - Properties
  
  private let repository: YTSMovieRepository
  
  
  // MARK: - Initializers
  
  init(repository: YTSMovieRepository) {
    self.repository = repository
  }
  
  
  // MARK: - Public Methods
  
  public func execute(
    term: String?,
    limit: Int,
    page: Int,
    genre: Genre? = nil
  ) async throws -> [Movie] {
    let movies = try await repository.fetchMovie(limit: limit, page: page, term: term, genre: genre, sortBy: nil)
    return movies
  }
}
