//
//  ListPreviewView.swift
//  Market List
//
//  Created by Arsalan Iravani on 12.07.2020.
//

import SwiftUI

struct ListPreviewView: View {
        
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                Spacer()
                
                Button(action: {
                    print("List edit pressed")
                }, label: {
                    Image(systemName: "slider.horizontal.3")
                })
            }
            .accentColor(.primary)
            
            Spacer()
            
            Text("9 Products")
                .font(.subheadline)
            Text("Personal")
                .font(.title)
            
        }.padding()
    }
}

struct ListPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        ListPreviewView()
    }
}
