//
//  CatFactView.swift
//  CatFacts
//
//  Created by Amjad on 28/03/25.
//

import SwiftUI

struct CatFactView: View {
    @StateObject private var vm: CatFactViewModel = CatFactViewModel()
    
    var body: some View {
        ZStack {
            Color.white
            VStack {
                AsyncImage(url: URL(string: vm.imageUrl ??  "https://picsum.photos/id/12/600")) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    case .failure:
                        Image("cat_photo")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(width: 200, height: 200)
                .border(Color.gray)
                
                Text(vm.fact ?? "No Facts")
                    .padding()
            }
            .padding()
            .task {
                async let factsLoaded: Void = vm.loadCatFacts()
                async let imagesLoaded: Void =  vm.loadCatImages()
                
                // Await both operations to complete in parallel
                _ = await (factsLoaded, imagesLoaded)
                
                // Safely display random content after loading completes
                vm.showRandomCatImageAndFact()
            }
        }
        .onTapGesture {
            vm.showRandomCatImageAndFact()
        }
    }
}

#Preview {
    CatFactView()
}
