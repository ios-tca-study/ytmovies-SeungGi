//
//  YTSMovieRepositoryImpl.swift
//  YSTMovie TCA
//
//  Created by 이승기 on 10/6/24.
//

import Foundation
import Moya

struct YTSMovieRepositoryImpl: YTSMovieRepository {
  
  // MARK: - Properties
  
  let service: MoyaProvider<YTSAPI>
  
  
  // MARK: - Initializers
  
  init(service: MoyaProvider<YTSAPI>) {
    self.service = service
  }
  
  
  // MARK: - Public Methods
  
  public func fetchMovie(limit: Int, page: Int?, term: String?, genre: String?, sortBy: SortBy?) async throws -> [Movie] {
    return try await withCheckedThrowingContinuation { continuation in
      service.request(.fetchMovie(limit: limit, page: page, term: term, genre: genre, sortBy: sortBy)) { result in
        switch result {
        case .success(let response):
          do {
            let movieResponseDTO = try JSONDecoder().decode(MovieResponseDTO.self, from: response.data)
            let movies = movieResponseDTO.data.movies?.map { $0.toDomain() }
            continuation.resume(returning: movies ?? [])
          } catch {
            continuation.resume(throwing: error)
          }
          
        case .failure(let error):
          continuation.resume(throwing: error)
        }
      }
    }
  }
}
