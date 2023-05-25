//
//  ImageView.swift
//  GitHubCarrefour
//
//  Created by MagnaTI on 22/05/23.
//

import SwiftUI

struct ImageView: View {
    
    var url: String
    var width: CGFloat = 50
    var height: CGFloat = 120
    
    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: url)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: width, maxHeight: height)
                        .clipShape(Circle())
                case .failure:
                    Image(systemName: "photo")
                @unknown default:
                    EmptyView()
                }
            }
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(url: "https://avatars.githubusercontent.com/u/1?v=4")
    }
}
