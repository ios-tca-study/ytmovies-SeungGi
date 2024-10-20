//
//  DiscoverFeature.swift
//  YSTMovie TCA
//
//  Created by 이승기 on 10/10/24.
//

import Foundation
import ComposableArchitecture
import Combine

struct DiscoverFeature: Reducer {
  
  // MARK: - State, Action
  
  @ObservableState
  struct State: Equatable {
    var isLoading: Bool = false
    var movies: [Movie] = []
    var genre: Genre = .all
    var page: Int = 1
    var isLastPage: Bool = false
  }
  
  enum Action: Equatable {
    case search
    case loadMore
    case setMovies([Movie])
    case appendMovies([Movie])
    case setLoadingState(Bool)
    case setGenre(Genre)
  }
  
  // MARK: - Properties
  
  
  @Dependency(\.searchMovieUseCase) private var searchMovieUseCase: SearchMovieUseCase
  
  
  // MARK: - Initializers
  
  init() { }
  
  
  // MARK: - Reducer
  
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
    switch action {
    case .search:
      state.page = 1
      state.isLoading = true
      state.movies.removeAll()
      let currentGenre = state.genre
    
      return .run { send in
        let movies = try await searchMovieUseCase.execute(term: nil, limit: 10, page: 1, genre: currentGenre)
        await send(.setMovies(movies))
        await send(.setLoadingState(false))
      }
    
    case .loadMore:
      state.isLoading = true
      state.page += 1
      let currentPage = state.page
      let currentGenre = state.genre
      
      return .run { send in
        let movies = try await searchMovieUseCase.execute(term: nil, limit: 10, page: currentPage, genre: currentGenre)
        await send(.appendMovies(movies))
        await send(.setLoadingState(false))
      }
      
    case .setMovies(let movies):
      state.movies = movies
      return .none
      
    case .appendMovies(let movies):
      state.movies.append(contentsOf: movies)
      return .none
      
    case .setLoadingState(let loadingState):
      state.isLoading = loadingState
      return .none
      
    case .setGenre(let genre):
      // 기존에 선택했던 장르와 같다면 리턴
      if state.genre == genre { return .none }
      state.genre = genre
      return .send(.search)
    }
  }
}
