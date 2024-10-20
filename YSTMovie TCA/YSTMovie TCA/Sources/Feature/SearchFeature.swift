//
//  SearchFeature.swift
//  YSTMovie TCA
//
//  Created by 이승기 on 10/9/24.
//

import Foundation
import ComposableArchitecture
import Combine

@Reducer
struct SearchFeature {
  
  // MARK: - State, Action
  
  @ObservableState
  struct State: Equatable {
    var isLoading: Bool = false
    var movies: [Movie] = []
    var selectedMovie: Movie?
    var page: Int = 1
    var term: String = ""
  }
  
  enum Action: Equatable {
    case search(term: String)
    case loadMore
    case setMovies([Movie])
    case appendMovies([Movie])
    case setLoadingState(Bool)
    case termChanged(String)
  }
  
  // MARK: - Properties
  
  @Dependency(\.searchMovieUseCase) private var searchMovieUseCase
  
  
  // MARK: - Initializers
  
  init() { }
  
  
  // MARK: - Reducer
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .search(let term):
        state.isLoading = true
        state.page = 1
        let currentTerm = term
        let currentPage = state.page
        
        if currentTerm.isEmpty {
          state.isLoading = false
          return .send(.setMovies([]))
        } else {
          return .run { send in
            let movies = try await searchMovieUseCase.execute(term: currentTerm, limit: 10, page: currentPage)
            await send(.setMovies(movies))
            await send(.setLoadingState(false))
          }
        }
        
      case .loadMore:
        state.isLoading = true
        state.page += 1
        let currentTerm = state.term
        let currentPage = state.page
        
        if currentTerm.isEmpty {
          state.isLoading = false
          return .none
        } else {
          return .run { send in
            let movies = try await searchMovieUseCase.execute(term: currentTerm, limit: 5, page: currentPage)
            await send(.appendMovies(movies))
            await send(.setLoadingState(false))
          }
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
        
      case .termChanged(let term):
        if state.term == term { return .none }
        state.term = term
        
        return .send(.search(term: term))
          .debounce(id: "term.changed", for: 0.5, scheduler: DispatchQueue.main)
      }
    }
  }
}
