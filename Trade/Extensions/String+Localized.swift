import Foundation

extension String {
    
    func localized(with comment: String = "") -> String {
        
        return NSLocalizedString(self, comment: comment)
    }
}
