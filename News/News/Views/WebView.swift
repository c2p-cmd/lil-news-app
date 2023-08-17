//
//  WebView.swift
//  News
//
//  Created by Sharan Thakur on 16/08/23.
//

import SwiftUI
import SafariServices

struct WebView: UIViewControllerRepresentable {
    // to display an article's website
    let url: URL
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<WebView>) -> SFSafariViewController {
        let webview = SFSafariViewController(url: url)
        return webview
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<WebView>) {
        // nothing to do
    }
}
