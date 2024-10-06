//
//  LatestMovieUseCase.swift
//  YSTMovie TCA
//
//  Created by 이승기 on 10/6/24.
//

import Foundation

struct LatestMovieUseCase {
  
  // MARK: - Properties
  
  private let repository: YTSMovieRepository
  
  
  // MARK: - Initializers
  
  init(repository: YTSMovieRepository) {
    self.repository = repository
  }
  
  
  // MARK: - Public Methods
  
  public func execute() async throws -> Movie? {
    let movie = try await repository.fetchMovie(limit: 1, page: nil, term: nil, genre: nil, sortBy: .dateAdded).first
    return movie
  }
}
