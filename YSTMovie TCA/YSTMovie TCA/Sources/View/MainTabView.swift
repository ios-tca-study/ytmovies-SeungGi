//
//  MainTabView.swift
//  YSTMovie TCA
//
//  Created by 이승기 on 9/21/24.
//

import SwiftUI

struct MainTabView: View {
  
  // MARK: - Properties
  
  // MARK: - Initializers
  
  // MARK: - Views
  
  var body: some View {
    NavigationStack {
      HomeView()
    }
    .toolbarVisibility(.hidden, for: .navigationBar)
  }
}


// MARK: - Preview

#Preview {
  MainTabView()
}
