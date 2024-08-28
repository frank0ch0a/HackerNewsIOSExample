import Foundation
enum Constants {
    enum URLConstant {
        static let baseURL = "https://hn.algolia.com/api/v1/search_by_date?query=mobile"
    }
    
    enum HomeConstants {
        static let offlineTitle = "Offline Mode: Showing Cached Articles"
        static let navBarTitle =  "Articles"
        static let loadingText = "Loading articles..."
    }
    
    enum ArticleItemConstants {
        static let unKnownAuthorString = "Unknown author"
        static let hyphen = "-"
    }
}
