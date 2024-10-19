//
//  Dependency.swift
//  YSTMovie TCA
//
//  Created by 이승기 on 10/19/24.
//

import Foundation
import ComposableArchitecture

import Moya

// MARK: - Service

private enum YTSMovieServiceKey: DependencyKey {
  static let liveValue: MoyaProvider<YTSAPI> = MoyaProvider<YTSAPI>()
}

// MARK: - Repository

private enum YTSMovieRepositoryKey: DependencyKey {
  static let liveValue: YTSMovieRepository = {
    @Dependency(\.ytsService) var service
    return YTSMovieRepositoryImpl(service: service)
  }()
}

// MARK: - UseCase

private enum LatestMovieUseCaseKey: DependencyKey {
  static let liveValue: LatestMovieUseCase = {
    @Dependency(\.ytsMovieRepository) var repository
    return LatestMovieUseCase(repository: repository)
  }()
}

private enum SearchMovieUseCaseKey: DependencyKey {
  static let liveValue: SearchMovieUseCase = {
    @Dependency(\.ytsMovieRepository) var repository
    return SearchMovieUseCase(repository: repository)
  }()
}

private enum TopFiveMovieUseCaseKey: DependencyKey {
  static let liveValue: TopFiveMovieUseCase = {
    @Dependency(\.ytsMovieRepository) var repository
    return TopFiveMovieUseCase(repository: repository)
  }()
}

// MARK: - Dependencies

extension DependencyValues {
  var ytsService: MoyaProvider<YTSAPI> {
    get { self[YTSMovieServiceKey.self] }
    set { self[YTSMovieServiceKey.self] = newValue }
  }
  
  var ytsMovieRepository: YTSMovieRepository {
    get { self[YTSMovieRepositoryKey.self] }
    set { self[YTSMovieRepositoryKey.self] = newValue }
   }
  
  var latestMovieUseCase: LatestMovieUseCase {
    get { self[LatestMovieUseCaseKey.self] }
    set { self[LatestMovieUseCaseKey.self] = newValue }
  }
  
  var searchMovieUseCase: SearchMovieUseCase {
    get { self[SearchMovieUseCaseKey.self] }
    set { self[SearchMovieUseCaseKey.self] = newValue }
  }
  
  var topFiveMovieUseCase: TopFiveMovieUseCase {
    get { self[TopFiveMovieUseCaseKey.self] }
    set { self[TopFiveMovieUseCaseKey.self] = newValue }
  }
}
