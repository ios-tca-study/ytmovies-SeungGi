//
//  BookmarkFeature.swift
//  YSTMovie TCA
//
//  Created by 이승기 on 10/20/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct BookmarkFeature {
  
  // MARK: - State, Action
  
  @ObservableState
  struct State: Equatable {
    var isLoading: Bool = false
    var movies: [Movie] = []
    var page: Int = 1
    var isLastPage: Bool = false
  }
  
  enum Action: Equatable {
    case load
    case loadMore
    case setMovies([Movie])
    case appendMovies([Movie])
    case setLoadingState(Bool)
    case setLastPageState(Bool)
  }
  
  // MARK: - Properties
  
  @Dependency(\.fetchBookmarkMovieUseCase) private var fetchBookmarkMovieUseCase
  
  
  // MARK: - Initializers
  
  init() { }
  
  
  // MARK: - Reducer
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .load:
        state.isLoading = true
        state.isLastPage = false
        state.page = 1
        let currentPage = state.page
        
        return .run { send in
          let movies = try await fetchBookmarkMovieUseCase.execute(limit: 10, page: currentPage)
          await send(.setMovies(movies))
          await send(.setLoadingState(false))
        }
        
      case .loadMore:
        state.isLoading = true
        state.page += 1
        let currentPage = state.page
        return .run { send in
          let movies = try await fetchBookmarkMovieUseCase.execute(limit: 10, page: currentPage)
          await send(.appendMovies(movies))
          await send(.setLoadingState(false))
          if movies.isEmpty {
            await send(.setLastPageState(true))
          }
        }
        
      case .setMovies(let movies):
        state.movies = movies
        return .none
        
      case .appendMovies(let movies):
        state.movies.append(contentsOf: movies)
        return .none
        
      case .setLoadingState(let isLoading):
        state.isLoading = isLoading
        return .none
        
      case .setLastPageState(let isLastPage):
        state.isLastPage = isLastPage
        return .none
      }
    }
  }
}
