//
//  MainTabView.swift
//  YSTMovie TCA
//
//  Created by 이승기 on 9/21/24.
//

import SwiftUI
import Moya
import ComposableArchitecture

struct MainTabView: View {

  // MARK: - Views
  var body: some View {
    TabView {
      Tab("Home", image: "home") {
        let store = Store(initialState: HomeFeature.State()) { HomeFeature() }
        
        NavigationView {
          HomeView(store: store)
        }
      }
      
      Tab("Search", image: "search") {
        let store = Store(initialState: SearchFeature.State()) { SearchFeature() }
        
        NavigationView {
          SearchView(store: store)
        }
      }
      
      Tab("bookmark", image: "bookmark") {
        BookmarkView()
      }
    }
    .toolbar(.hidden, for: .navigationBar)
  }
}

// MARK: - Preview

#Preview {
  MainTabView()
}
