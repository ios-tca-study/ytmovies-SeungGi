//
//  HomeView.swift
//  YSTMovie TCA
//
//  Created by 이승기 on 9/21/24.
//

import SwiftUI
import ComposableArchitecture

struct HomeView: View {
  
  // MARK: - Properties
  
  let store: StoreOf<HomeFeature>
  @State private var didAppear = false
  
  
  // MARK: - Views
  
  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      ScrollView {
        VStack(spacing: 30) {
          topFiveSection(viewStore: viewStore)
            .padding(.top, 33)
          
          latestSection(viewStore: viewStore)
        }
      }
      .background(Color.black)
      .navigationDestination(
        isPresented: viewStore.binding(
          get: \.isDiscoverViewShown,
          send: HomeFeature.Action.showDiscoverView
        )
      ) {
        let service = MoyaProvider<YTSAPI>()
        let repository = YTSMovieRepositoryImpl(service: service)
        let searchMovieUseCase = SearchMovieUseCase(repository: repository)
        let store = Store(initialState: DiscoverFeature.State()) {
          DiscoverFeature(searchMovieUseCase: searchMovieUseCase)
        }
        DiscoverView(store: store)
      }
      .onAppear {
        if didAppear == false {
          viewStore.send(.loadData)
          didAppear = true
        }
      }
    }
  }
  
  private func topFiveSection(viewStore: ViewStore<HomeFeature.State, HomeFeature.Action>) -> some View {
    VStack(spacing: 20) {
      LargeTitleText(title: "Top Five")
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
      
      if viewStore.isLoading {
        VStack {
          ProgressView()
            .tint(.white)
        }
        .frame(height: 266)
      } else {
        ScrollView(.horizontal, showsIndicators: false) {
          HStack(alignment: .top, spacing: 20) {
            ForEach(viewStore.topFiveMovies) { movie in
              NavigationLink(destination: DetailView()) {
                LandscapeMovieThumbnailViewRegular(movie: movie)
              }
            }
          }
          .padding(.horizontal, 16)
        }
      }
    }
  }
  
  private func latestSection(viewStore: ViewStore<HomeFeature.State, HomeFeature.Action>) -> some View {
    VStack(spacing: 20) {
      HStack(spacing: 0) {
        LargeTitleText(title: "Latest")
        
        Spacer()
        
        Button {
          viewStore.send(.showDiscoverView(true))
        } label: {
          if !viewStore.isLoading {
            Text("SEE MORE")
              .font(.system(size: 16))
              .foregroundColor(.accentColor)
          }
        }
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(.horizontal, 16)
      
      if let latestMovie = viewStore.latestMovie {
        if viewStore.isLoading {
          VStack {
            ProgressView()
              .tint(.white)
          }
          .frame(height: 266)
        } else {
          NavigationLink(destination: DetailView()) {
            PortraitMovieThumbnailViewLarge(movie: latestMovie)
            .padding(16)
          }
        }
      }
    }
  }
}

#if DEBUG
import Moya

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    let service = MoyaProvider<YTSAPI>()
    let repository = YTSMovieRepositoryImpl(service: service)
    let latestMovieUseCase = LatestMovieUseCase(repository: repository)
    let topFiveMovieUseCase = TopFiveMovieUseCase(repository: repository)
    
    let store = Store(initialState: HomeFeature.State()) {
      HomeFeature(latestMovieUseCase: latestMovieUseCase, topFiveMovieUseCase: topFiveMovieUseCase)
    }
    
    HomeView(store: store)
  }
}
#endif
