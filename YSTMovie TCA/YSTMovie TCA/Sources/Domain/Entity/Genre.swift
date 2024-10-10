//
//  Genre.swift
//  YSTMovie TCA
//
//  Created by 이승기 on 10/10/24.
//

import Foundation

enum Genre: String, Codable, CaseIterable {
  case all = "all"
  case action = "action"
  case adventure = "adventure"
  case animation = "animation"
  case biography = "biography"
  case crime = "crime"
  case documentary = "documentary"
  case drama = "drama"
  case family = "family"
  case fantasy = "fantasy"
  case filmNoir = "film-noir"
  case gameShow = "game-show"
  case history = "history"
  case horror = "horror"
  case music = "music"
  case musical = "musical"
  case mystery = "mystery"
  case news = "news"
  case realityTV = "reality-tv"
  case romance = "romance"
  case sciFi = "sci-fi"
  case sport = "sport"
  case talkShow = "talk-show"
  case thriller = "thriller"
  case war = "war"
  case western = "western"
}

extension Genre {
  var displayName: String {
    switch self {
    case .all: return "All"
    case .action: return "Action"
    case .adventure: return "Adventure"
    case .animation: return "Animation"
    case .biography: return "Biography"
    case .crime: return "Crime"
    case .documentary: return "Documentary"
    case .drama: return "Drama"
    case .family: return "Family"
    case .fantasy: return "Fantasy"
    case .filmNoir: return "Film-Noir"
    case .gameShow: return "Game Show"
    case .history: return "History"
    case .horror: return "Horror"
    case .music: return "Music"
    case .musical: return "Musical"
    case .mystery: return "Mystery"
    case .news: return "News"
    case .realityTV: return "Reality TV"
    case .romance: return "Romance"
    case .sciFi: return "Sci-Fi"
    case .sport: return "Sport"
    case .talkShow: return "Talk Show"
    case .thriller: return "Thriller"
    case .war: return "War"
    case .western: return "Western"
    }
  }
}
