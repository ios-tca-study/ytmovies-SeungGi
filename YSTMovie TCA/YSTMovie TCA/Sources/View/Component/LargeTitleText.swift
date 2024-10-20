//
//  LargeTitleText.swift
//  YSTMovie TCA
//
//  Created by 이승기 on 9/21/24.
//

import SwiftUI

struct LargeTitleText: View {
  
  // MARK: - Properties
  
  let title: String
  
  
  // MARK: - Views
  
  var body: some View {
    HStack(spacing: 0) {
      Text(title)
        .font(.system(size: 30, weight: .bold))
        .foregroundStyle(.white)
      
      Text(".")
        .font(.system(size: 30, weight: .bold))
        .foregroundStyle(.accent)
    }
  }
}


// MARK: - Preview

#Preview {
  ZStack {
    Color.black
      .ignoresSafeArea()
    
    LargeTitleText(title: "Discover")
  }
}
