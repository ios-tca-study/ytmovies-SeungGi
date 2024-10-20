//
//  DetailFeature.swift
//  YSTMovie TCA
//
//  Created by 이승기 on 10/19/24.
//

import SwiftUI
import ComposableArchitecture

struct DetailFeature: Reducer {
  
  // MARK: - State, Action
  
  struct State: Equatable {
    var movie: Movie
  }
  
  enum Action: Equatable { }
  
  // MARK: - Properties
  
  init() { }
  
  // MARK: - Reducer
  
  func reduce(into state: inout State, action: Action) -> Effect<Action> { }
}
