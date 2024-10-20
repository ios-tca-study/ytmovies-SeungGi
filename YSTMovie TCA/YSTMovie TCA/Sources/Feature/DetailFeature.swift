//
//  DetailFeature.swift
//  YSTMovie TCA
//
//  Created by 이승기 on 10/19/24.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct DetailFeature {
  
  // MARK: - State, Action
  
  @ObservableState
  struct State: Equatable {
    var movie: Movie
  }
  
  enum Action: Equatable { }
  
  // MARK: - Properties
  
  init() { }
  
  // MARK: - Reducer
  
  @Dependency(\.uuid) var uuid
  var body: some ReducerOf<Self> {
    Reduce { _, _ in
      return .none
    }
  }
}
