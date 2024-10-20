//
//  YTSMovieRepositoryImpl.swift
//  YSTMovie TCA
//
//  Created by 이승기 on 10/6/24.
//

import Foundation
import Moya
import CoreData

struct YTSMovieRepositoryImpl: YTSMovieRepository {
  
  // MARK: - Properties
  
  let service: MoyaProvider<YTSAPI>
  let context: NSManagedObjectContext
  
  // MARK: - Initializers
  
  init(service: MoyaProvider<YTSAPI>, context: NSManagedObjectContext) {
    self.service = service
    self.context = context
  }
  
  // MARK: - Public Methods
  
  public func fetchMovie(limit: Int, page: Int?, term: String?, genre: Genre?, sortBy: SortBy?) async throws -> [Movie] {
    // CoreData에서 북마크된 영화 ID를 가져옴
    let fetchRequest: NSFetchRequest<BookmarkMovieEntity> = BookmarkMovieEntity.fetchRequest()
    let bookmarks = try context.fetch(fetchRequest)
    let bookmarkedIds = bookmarks.map { $0.id }
    
    // 네트워크 요청
    return try await withCheckedThrowingContinuation { continuation in
      service.request(.fetchMovie(limit: limit, page: page, term: term, genre: genre, sortBy: sortBy)) { result in
        switch result {
        case .success(let response):
          do {
            let movieResponseDTO = try JSONDecoder().decode(MovieResponseDTO.self, from: response.data)
            let movies = movieResponseDTO.data.movies?.map { $0.toDomain() } ?? []
            
            // 북마크 상태 반영
            let updatedMovies = movies.map { movie in
              var updatedMovie = movie
              updatedMovie.isBookmarked = bookmarkedIds.contains(movie.id)
              return updatedMovie
            }
            
            continuation.resume(returning: updatedMovies)
          } catch {
            continuation.resume(throwing: error)
          }
          
        case .failure(let error):
          continuation.resume(throwing: error)
        }
      }
    }
  }
  
  func fetchBookmarkMovie(limit: Int, page: Int?) async throws -> [Movie] {
    let fetchRequest: NSFetchRequest<BookmarkMovieEntity> = BookmarkMovieEntity.fetchRequest()
    let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
    fetchRequest.sortDescriptors = [sortDescriptor]
    
    let bookmarks = try context.fetch(fetchRequest)
    
    // 페이지네이션 처리
    let currentPage = page ?? 1
    let startIndex = (currentPage - 1) * limit
    let endIndex = min(startIndex + limit, bookmarks.count)
    
    // 페이지 초과
    guard startIndex < bookmarks.count else {
      return []
    }
    
    let pagedBookmarks = Array(bookmarks[startIndex..<endIndex])
    return pagedBookmarks.map { $0.toDomain() }
  }
  
  func addBookmark(for movie: Movie) async throws {
    // 이미 북마크되었는지 확인
    let fetchRequest: NSFetchRequest<BookmarkMovieEntity> = BookmarkMovieEntity.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "id == %@", movie.id)
    
    let existingBookmarks = try context.fetch(fetchRequest)
    if existingBookmarks.isEmpty {
      let bookmarkMovieEntity = BookmarkMovieEntity(context: context)
      bookmarkMovieEntity.id = movie.id
      bookmarkMovieEntity.title = movie.title
      bookmarkMovieEntity.thumbnailImageUrl = movie.thumbnailImageUrl
      bookmarkMovieEntity.movieDescription = movie.description
      bookmarkMovieEntity.rating = movie.rating
      bookmarkMovieEntity.isBookmarked = true
      bookmarkMovieEntity.genre = movie.genre
      
      // 데이터 저장
      try context.save()
    }
  }
  
  func removeBookmark(for movie: Movie) async throws {
    let fetchRequest: NSFetchRequest<BookmarkMovieEntity> = BookmarkMovieEntity.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "id == %@", movie.id)
    
    let bookmarks = try context.fetch(fetchRequest)
    if let bookmarkToRemove = bookmarks.first {
      context.delete(bookmarkToRemove)
      try context.save()
    }
  }
  
  func isBookmarked(id: String) async -> Bool {
    let fetchRequest: NSFetchRequest<BookmarkMovieEntity> = BookmarkMovieEntity.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "id == %@", id)
    
    do {
      let bookmarks = try context.fetch(fetchRequest)
      return !bookmarks.isEmpty
    } catch {
      return false
    }
  }
}
