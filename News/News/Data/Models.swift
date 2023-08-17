//
//  Models.swift
//  News
//
//  Created by Sharan Thakur on 16/08/23.
//

import Foundation

// lil news api
let apiURL = "https://api.lil.software/news"


// MARK: - News
struct News: Codable {
    let articles: [Article]
    
    enum CodingKeys: String, CodingKey {
        case articles = "articles"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.articles = try container.decode([Article].self, forKey: .articles)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.articles, forKey: .articles)
    }
}

// MARK: - Article
class Article: Identifiable, Codable, RawRepresentable {
    let id = UUID()
    let author: String?
    let url: String
    let source: String
    let title: String
    let description: String?
    let image: String?
    let date: Date
    
    enum CodingKeys: String, CodingKey {
        case author = "author"
        case url = "url"
        case source = "source"
        case title = "title"
        case description = "description"
        case image = "image"
        case date = "date"
    }
    
    init(author: String?, url: String, source: String, title: String, description: String?, image: String?, date: Date) {
        self.author = author
        self.url = url
        self.source = source
        self.title = title
        self.description = description
        self.image = image
        self.date = date
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.author = try container.decodeIfPresent(String.self, forKey: .author)
        self.url = try container.decode(String.self, forKey: .url)
        self.source = try container.decode(String.self, forKey: .source)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.image = try container.decodeIfPresent(String.self, forKey: .image)
        let dateSting = try container.decode(String.self, forKey: .date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        self.date = dateFormatter.date(from: dateSting)!
    }
    
    required convenience init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let value = try? JSONDecoder().decode(Article.self, from: data)
        else {
            return nil
        }
        
        self.init(author: value.author, url: value.url, source: value.source, title: value.title, description: value.description, image: value.image, date: value.date)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.author, forKey: .author)
        try container.encode(self.url, forKey: .url)
        try container.encode(self.source, forKey: .source)
        try container.encode(self.title, forKey: .title)
        try container.encodeIfPresent(self.description, forKey: .description)
        try container.encodeIfPresent(self.image, forKey: .image)
        try container.encode(self.date, forKey: .date)
    }
    
    var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let json = String(data: data, encoding: .utf8)
        else {
            return "{}"
        }
        return json
    }
}
