//
//  WebView.swift
//  FitnessMasterApp
//
//  Created by Franchesco Cabrera on 4/11/24.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    var urlString: String

    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: urlString) else {
            return WKWebView()
        }

        // Create a WKWebViewConfiguration object to allow media playback.
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true // Allow videos to play inline
        configuration.mediaTypesRequiringUserActionForPlayback = [] // Autoplay without requiring user action

        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        // This function can be left empty for this use case.
    }
}
