//
//  Dependency.swift
//  YSTMovie TCA
//
//  Created by 이승기 on 10/19/24.
//

import Foundation
import ComposableArchitecture

import Moya
import CoreData

// MARK: - Service

private enum YTSMovieServiceKey: DependencyKey {
  static let liveValue: MoyaProvider<YTSAPI> = MoyaProvider<YTSAPI>()
}

private enum BookmarkDBModelContextKey: DependencyKey {
  static let liveValue: NSManagedObjectContext = {
    let container = NSPersistentContainer(name: "BookmarkModel")
    container.loadPersistentStores { storeDescription, error in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
    return container.viewContext
  }()
}

// MARK: - Repository

private enum YTSMovieRepositoryKey: DependencyKey {
  static let liveValue: YTSMovieRepository = {
    @Dependency(\.ytsService) var service
    @Dependency(\.bookmarkDBModelContext) var bookmarkDBModelContext
    return YTSMovieRepositoryImpl(service: service, context: bookmarkDBModelContext)
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

private enum FetchBookmarkMovieUseCaseKey: DependencyKey {
  static let liveValue: FetchBookmarkMovieUseCase = {
    @Dependency(\.ytsMovieRepository) var repository
    return FetchBookmarkMovieUseCase(repository: repository)
  }()
}

private enum AddBookmarkUseCaseKey: DependencyKey {
  static let liveValue: AddBookmarkMovieUseCase = {
    @Dependency(\.ytsMovieRepository) var repository
    return AddBookmarkMovieUseCase(repository: repository)
  }()
}

private enum RemoveBookmarkMovieUseCaseKey: DependencyKey {
  static let liveValue: RemoveBookmarkMovieUseCase = {
    @Dependency(\.ytsMovieRepository) var repository
    return RemoveBookmarkMovieUseCase(repository: repository)
  }()
}

// MARK: - Dependencies

extension DependencyValues {
  var ytsService: MoyaProvider<YTSAPI> {
    get { self[YTSMovieServiceKey.self] }
    set { self[YTSMovieServiceKey.self] = newValue }
  }
  
  var bookmarkDBModelContext: NSManagedObjectContext {
    get { self[BookmarkDBModelContextKey.self] }
    set { self[BookmarkDBModelContextKey.self] = newValue }
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
  
  var fetchBookmarkMovieUseCase: FetchBookmarkMovieUseCase {
    get { self[FetchBookmarkMovieUseCaseKey.self] }
    set { self[FetchBookmarkMovieUseCaseKey.self] = newValue }
  }
  
  var addBookmarkMovieUseCase: AddBookmarkMovieUseCase {
    get { self[AddBookmarkUseCaseKey.self] }
    set { self[AddBookmarkUseCaseKey.self] = newValue }
  }
  
  var removeBookmarkMovieUseCase: RemoveBookmarkMovieUseCase {
    get { self[RemoveBookmarkMovieUseCaseKey.self] }
    set { self[RemoveBookmarkMovieUseCaseKey.self] = newValue }
  }
}
