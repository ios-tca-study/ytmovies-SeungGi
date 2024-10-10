//
//  YTSAPI.swift
//  YSTMovie TCA
//
//  Created by 이승기 on 10/6/24.
//

import Foundation
import Moya

enum YTSAPI {
  case fetchMovie(limit: Int, page: Int?, term: String?, genre: Genre?, sortBy: SortBy?)
}

extension YTSAPI: TargetType {
  
  var baseURL: URL {
    return URL(string: "https://yts.mx")!
  }
  
  var path: String {
    return "/api/v2/list_movies.json"
  }
  
  var method: Moya.Method {
    return .get
  }
  
  var task: Task {
    switch self {
    case let .fetchMovie(limit, page, term, genre, sortBy):
      var parameters: [String: Any] = ["limit": limit]
      
      if let page = page {
        parameters["page"] = page
      }
      
      if let term = term {
        parameters["query_term"] = term
      }
      
      if let genre = genre {
        parameters["genre"] = genre.rawValue
      }
      
      if let sortBy = sortBy {
        parameters["sort_by"] = sortBy.rawValue
      }
      
      return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }
  }
  
  var headers: [String : String]? {
    return ["Content-type": "application/json"]
  }
  
  var validationType: ValidationType {
    return .successCodes
  }
}
