//
//  MovieThumbnailFeature.swift
//  YSTMovie TCA
//
//  Created by 이승기 on 10/20/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct MovieThumbnailFeature {
  
  // MARK: - State, Action
  
  @ObservableState
  struct State: Equatable {
    var movie: Movie
  }
  
  enum Action: Equatable {
    case toggleBookmark
    case setBookmarked(Bool)
  }
  
  
  // MARK: - Properties
  
  @Dependency(\.addBookmarkMovieUseCase) var addBookmarkMovieUseCase
  @Dependency(\.removeBookmarkMovieUseCase) var removeBookmarkMovieUseCase
  
  
  // MARK: - Initializers
  
  init() { }
  
  
  // MARK: - Reducer
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .toggleBookmark:
        let isBookmarked = state.movie.isBookmarked
        
        let movie = state.movie
        if isBookmarked {
          return .run { send in
            try await removeBookmarkMovieUseCase.execute(movie: movie)
            await send(.setBookmarked(false))
          }
        } else {
          return .run { send in
            try await addBookmarkMovieUseCase.execute(movie: movie)
            await send(.setBookmarked(true))
          }
        }
        
      case .setBookmarked(let isBookmarked):
        state.movie.isBookmarked = isBookmarked
        return .none
      }
    }
  }
}
