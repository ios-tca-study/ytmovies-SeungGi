//
//  SearchViewModel.swift
//  YSTMovie TCA
//
//  Created by 이승기 on 10/9/24.
//

import Foundation
import ComposableArchitecture
import Combine

struct SearchFeature: Reducer {
  
  // MARK: - State, Action
  
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
  
  private let searchMovieUseCase: SearchMovieUseCase
  
  
  // MARK: - Initializers
  
  init(searchMovieUseCase: SearchMovieUseCase) {
    self.searchMovieUseCase = searchMovieUseCase
  }
  
  
  // MARK: - Reducer
  
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
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
      // 더 불러오기는 기존에 Page를 +1 한 후
      // state에 있는 term을 이용해서 search 액션 재활용
      state.page += 1
      return .send(.search(term: state.term))
      
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
