//
//  MainTabView.swift
//  YSTMovie TCA
//
//  Created by 이승기 on 9/21/24.
//

import SwiftUI

struct MainTabView: View {
  
  // MARK: - Properties
  @State private var selectedTab: Tab = .home
  
  enum Tab {
    case home
    case search
    case bookmark
  }
  
  // MARK: - Views
  var body: some View {
    NavigationStack {
      ZStack {
        // Views for each tab
        switch selectedTab {
        case .home:
          HomeView()
        case .search:
          SearchView()
        case .bookmark:
          BookmarkView()
        }
        
        VStack {
          Spacer()
          HStack {
            Spacer()
            
            TabButton(tab: .home, selectedTab: $selectedTab, iconName: "home")
            Spacer()
            TabButton(tab: .search, selectedTab: $selectedTab, iconName: "search")
            Spacer()
            TabButton(tab: .bookmark, selectedTab: $selectedTab, iconName: "bookmark")
            
            Spacer()
          }
          .frame(height: 70)
          .background(.black)
        }
      }
    }
    .toolbar(.hidden, for: .navigationBar)
  }
}

// Tab Button
struct TabButton: View {
  let tab: MainTabView.Tab
  @Binding var selectedTab: MainTabView.Tab
  let iconName: String
  
  var body: some View {
    Button(action: {
      selectedTab = tab
    }) {
      Image(iconName)
        .resizable()
        .scaledToFit()
        .frame(height: 20)
        .foregroundColor(selectedTab == tab ? .accentColor : .white)
    }
  }
}


// MARK: - Preview

#Preview {
  MainTabView()
}
