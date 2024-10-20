//
//  AddBookmarkMovieUseCase.swift
//  YSTMovie TCA
//
//  Created by 이승기 on 10/20/24.
//

import Foundation

struct AddBookmarkMovieUseCase {
  
  // MARK: - Properties
  
  private let repository: YTSMovieRepository
  
  
  // MARK: - Initializers
  
  init(repository: YTSMovieRepository) {
    self.repository = repository
  }
  
  
  // MARK: - Initializers
  
  public func execute(movie: Movie) async throws {
    try await repository.addBookmark(for: movie)
  }
}
