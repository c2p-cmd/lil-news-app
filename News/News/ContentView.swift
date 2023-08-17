//
//  ContentView.swift
//  News
//
//  Created by Jordan Singer on 2/10/21.
//

import SwiftUI

struct ContentView: View {
    @State private var articles: [Article] = []
    @State private var isBusy = true
    @State private var error: String?
    
    var body: some View {
        NavigationView {
            VStack {
                if self.isBusy {
                    ProgressView()
                }
                
                if let error {
                    Text(error)
                        .tint(.red)
                }
                
                if articles.isEmpty == false {
                    List {
                        ForEach(articles, id: \.id) { article in
                            ArticleView(article: article)
                        }
                    }
                    .listStyle(.plain)
                    .navigationBarTitle("News", displayMode: .inline)
                    .refreshable {
                        self.loadNews()
                    }
                } else {
                    Button("Fetch") {
                        self.loadNews()
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
        .onAppear {
            print(String(describing: articles))
            
            if articles.isEmpty {
                self.loadNews()
            } else {
                self.isBusy = false
            }
        }
    }
    
    private func loadNews() {
        self.isBusy = true
        let request = URLRequest(url: URL(string: apiURL)!)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let data {
                do {
                    let decodedResponse = try JSONDecoder().decode(News.self, from: data)
                    
                    withAnimation {
                        self.articles = decodedResponse.articles
                        self.isBusy = false
                    }
                } catch {
                    withAnimation {
                        self.isBusy = false
                        self.error = error.localizedDescription
                    }
                }
            }
            
            if let error {
                self.error = error.localizedDescription
            }
        }.resume()
    }
}
