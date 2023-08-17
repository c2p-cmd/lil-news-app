//
//  ArticleView.swift
//  News
//
//  Created by Sharan Thakur on 16/08/23.
//

import SwiftUI

struct ArticleView: View {
    var article: Article
    @State private var showWebView = false
    @State private var isExpanded = false
    
    init(article: Article) {
        self.article = article
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack(alignment: .top, spacing: 16) {
                if let image = article.image {
                    AsyncImage(url: URL(string: image)) { image in
                        let imageView = image.resizable().scaledToFit()
                        
                        imageView
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 128, height: 96)
                            .background(Color(UIColor.systemFill))
                            .cornerRadius(4)
                            .clipped()
                            .onTapGesture {
                                self.isExpanded = true
                            }
                            .sheet(isPresented: $isExpanded) {
                                NavigationView(content: {
                                    FullImageView {
                                        imageView
                                    } buttonCloseAction: {
                                        self.isExpanded = false
                                    }
                                })
                            }
                    } placeholder: {
                        Image(systemName: "newspaper.circle.fill")
                            .frame(width: 100, height: 100)
                            .symbolRenderingMode(.multicolor)
                    }
                } else {
                    Image(systemName: "newspaper.circle.fill")
                        .frame(width: 100, height: 100)
                        .symbolRenderingMode(.multicolor)
                }
                
                Button {
                    self.showWebView = true
                } label: {
                    news(show: true)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.vertical, 12)
        .fullScreenCover(isPresented: $showWebView) {
            let url = URL(string: self.article.url)!
            
            WebView(url: url).edgesIgnoringSafeArea(.all)
        }
    }
    
    private func news(show: Bool = false) -> some View {
        VStack (alignment: .leading, spacing: 6) {
            Text(article.title)
                .font(.system(.headline, design: .serif))
            
            Text(article.source)
                .font(.callout)
                .lineLimit(1)
                .foregroundColor(.secondary)
            
            if show {
                Text("Read More")
                    .font(.caption2)
                    .lineLimit(1)
                    .foregroundColor(.secondary)
            }
        }
    }
}
