//
//  WebView.swift
//  HackerNewsExample
//
//  Created by Francisco Ochoa on 24/08/2024.
//

import WebKit
import SwiftUI

struct WebView: UIViewRepresentable {
    let url: String?

    func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: url ?? "") {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }
}
