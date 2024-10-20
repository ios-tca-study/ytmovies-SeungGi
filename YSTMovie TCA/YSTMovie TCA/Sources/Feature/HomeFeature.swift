//
//  HomeFeature.swift
//  YSTMovie TCA
//
//  Created by 이승기 on 10/6/24.
//

import Foundation
import ComposableArchitecture
import Combine

@Reducer
struct HomeFeature {
  
  // MARK: - State, Action
  
  @ObservableState
  struct State: Equatable {
    var isLoading: Bool = false
    var topFiveMovies: [Movie] = []
    var latestMovie: Movie?
    var path = StackState<DiscoverFeature.State>()
  }
  
  enum Action: Equatable {
    case loadData
    case latestMovieLoaded(Movie)
    case topFiveMoviesLoaded([Movie])
    case path(StackAction<DiscoverFeature.State, DiscoverFeature.Action>)
  }
  
  
  // MARK: - Properties
  
  @Dependency(\.latestMovieUseCase) private var latestMovieUseCase: LatestMovieUseCase
  @Dependency(\.topFiveMovieUseCase) private var topFiveMovieUseCase: TopFiveMovieUseCase
  
  
  // MARK: - Initializers
  
  init() { }
  
  
  // MARK: - Reducer
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .loadData:
        state.isLoading = true
        
        return .run { send in
          // 두 비동기 작업을 동시에 시작
          async let latestMovie = try latestMovieUseCase.execute()
          async let topFiveMovies = try topFiveMovieUseCase.execute()
          
          // 동시에 실행된 작업의 결과를 기다림
          let topFiveMoviesResult = try await topFiveMovies
          let latestMovieResult = try await latestMovie
          
          // 결과 처리
          await send(.topFiveMoviesLoaded(topFiveMoviesResult))
          if let latestMovieResult {
            await send(.latestMovieLoaded(latestMovieResult))
          }
        }
        
      case let .latestMovieLoaded(movie):
        state.latestMovie = movie
        if !state.topFiveMovies.isEmpty {
          state.isLoading = false
        }
        return .none
        
      case let .topFiveMoviesLoaded(movies):
        state.topFiveMovies = movies
        if state.latestMovie != nil {
          state.isLoading = false
        }
        return .none
        
      case .path:
        return .none
      }
    }
    .forEach(\.path, action: \.path) {
      DiscoverFeature()
    }
  }
}
