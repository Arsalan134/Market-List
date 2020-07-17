//
//  ContentView.swift
//  Shared
//
//  Created by Arsalan Iravani on 12.07.2020.
//

import SwiftUI

struct ContentView: View {
    
    @State var lists: [List] = [List(name: "Salam 1"), List(name: "Salam 2"), List(name: "Salam 3")]
    @State var showingDetail = false
    
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                Button(action: {
                    print("hello")
                }, label: {
                    Image(systemName: "slider.horizontal.3")
                })
                
                Spacer()
                
                Text("My Lists")
                
                Spacer()
                
                Button(action: {
                    print("hello")
                }, label: {
                    Image(systemName: "magnifyingglass")
                })
            }.accentColor(.primary)
            
            Spacer()
            
            Image("Arsalan")
                .resizable()
                .frame(width: 70, height: 70)
                .clipShape(Capsule())
                .shadow(radius: 20, x: 10, y: 10)
            
            Text("Hello, Arsalan.")
                .font(.largeTitle)
            Text("Looks like you feel good.")
                .font(.subheadline)
            Text("You have 4 tasks to do today")
                .font(.subheadline)
            
        }
        .padding()
        
        Spacer()
        
        Group {
            
            ScrollView {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(lists, id: \.self) { list in
                            Button(action: {
                                self.showingDetail.toggle()
                            }, label: {
                                ListPreviewView()
                                    .frame(width: 200, height: 250, alignment: .center)
                                    .background(Color.secondary)
                                    .cornerRadius(10)
                            })
                            .accentColor(.primary)
                            .sheet(isPresented: $showingDetail) {
                                Color.red
                            }
                        }
                    }
                    .padding()
                }
                
                Spacer()
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
