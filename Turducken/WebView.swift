import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    var url: URL

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

//struct WebView: UIViewRepresentable {
//    var url: URL
//    @Binding var rect: CGRect  // Assume this gets updated with the current frame size
//
//    func makeUIView(context: Context) -> WKWebView {
//        let webView = WKWebView()
//        return webView
//    }
//
//    func updateUIView(_ webView: WKWebView, context: Context) {
//        let jsString = "document.body.style.width = '\(rect.width)px'; document.body.style.height = '\(rect.height)px';"
//        webView.evaluateJavaScript(jsString, completionHandler: nil)
//
//        if webView.url == nil {
//            let request = URLRequest(url: url)
//            webView.load(request)
//        }
//    }
//}
