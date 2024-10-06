//
//  TopFiveMovieUseCase.swift
//  YSTMovie TCA
//
//  Created by 이승기 on 10/6/24.
//

import Foundation

struct TopFiveMovieUseCase {
  
  // MARK: - Properties
  
  private let repository: YTSMovieRepository
  
  
  // MARK: - Initializers
  
  init(repository: YTSMovieRepository) {
    self.repository = repository
  }
  
  
  // MARK: - Public Methods
  
  public func execute() async throws -> [Movie] {
    let movies = try await repository.fetchMovie(limit: 5, page: nil, term: nil, genre: nil, sortBy: .rating)
    return movies
  }
}
