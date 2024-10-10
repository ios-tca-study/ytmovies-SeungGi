//
//  HomeFeature.swift
//  YSTMovie TCA
//
//  Created by 이승기 on 10/6/24.
//

import Foundation
import ComposableArchitecture
import Combine

struct HomeFeature: Reducer {
  
  // MARK: - State, Action
  
  struct State: Equatable {
    var isLoading: Bool = false
    var topFiveMovies: [Movie] = []
    var latestMovie: Movie?
    var isDiscoverViewShown: Bool = false
  }
  
  enum Action: Equatable {
    case loadData
    case latestMovieLoaded(Movie)
    case topFiveMoviesLoaded([Movie])
    case showDiscoverView(Bool)
    case navigationSelectionChanged(NavigationDestination?)
  }
  
  enum NavigationDestination: Equatable {
    case detailView(Movie)
    case discoverView
  }
  
  // MARK: - Properties
  
  let latestMovieUseCase: LatestMovieUseCase
  let topFiveMovieUseCase: TopFiveMovieUseCase
  
  
  // MARK: - Initializers
  
  init(
    latestMovieUseCase: LatestMovieUseCase,
    topFiveMovieUseCase: TopFiveMovieUseCase
  ) {
    self.latestMovieUseCase = latestMovieUseCase
    self.topFiveMovieUseCase = topFiveMovieUseCase
  }
  
  
  // MARK: - Reducer
  
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
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
      
    case let .showDiscoverView(isShown):
      state.isDiscoverViewShown = isShown
      return .none
      
    case .navigationSelectionChanged:
      return .none
    }
  }
}
