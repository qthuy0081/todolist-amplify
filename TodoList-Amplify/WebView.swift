//
//  WebView.swift
//  
//
//  Created by Dinh Quoc Thuy on 6/9/20.
//

import Foundation
import WebKit
import SwiftUI

struct WebView: UIViewRepresentable {
    var url:String
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string:self.url) else {
            return WKWebView()
        }
        let request = URLRequest(url: url)
        let wkWebView = WKWebView()
        wkWebView.load(request)
        return wkWebView
    }
    func updateUIView(_ uiView: WebView.UIViewType, context: UIViewRepresentableContext<WebView>) {
        
    }
}
