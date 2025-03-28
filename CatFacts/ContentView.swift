//
//  ContentView.swift
//  CatFacts
//
//  Created by Amjad on 28/03/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm: ContentViewModel = ContentViewModel()
    
    var body: some View {
        ZStack {
            Color.white
            VStack {
                AsyncImage(url: URL(string: vm.imageUrl ?? "https://cdn2.thecatapi.com/images/ebv.jpg")) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } else if phase.error != nil {
                        Text("No image available")
                    } else {
                        Image(systemName: "photo")
                    }
                }
                .frame(width: 250, height: 250)
                .border(Color.gray)
                Text(vm.fact ?? "No Facts")
            }
            .padding()
            .task {
                await vm.loadCatFacts()
                await vm.loadCatImages()
                vm.showRandomCatImageAndFact()
            }
        }
        .onTapGesture {
            vm.showRandomCatImageAndFact()
        }
    }
}

#Preview {
    ContentView()
}
