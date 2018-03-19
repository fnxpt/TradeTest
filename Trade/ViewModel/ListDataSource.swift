import Foundation
import CoreGraphics
import UIKit

class ListDataSource: GroupableDataSource {
    
    func numberOfGroups() -> Int {
        return 1
    }
    
    func numberOfItems(for group: Int) -> Int {
        return App.shared.subscribed.count
    }
    
    func heightForItem(index: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func item(index: IndexPath) -> Any? {
        guard App.shared.subscribed.count > index.item else { return nil }
        
        let item = App.shared.subscribed[index.item]
        
        return item
    }
    
    func emptyString() -> NSAttributedString? {
        
        let attributedString = NSMutableAttributedString()
        
        let icon = NSAttributedString(string: "◉_◉",
                                      attributes: [NSAttributedStringKey.foregroundColor: Palette.primary.color(),
                                                   NSAttributedStringKey.font: UIFont.systemFont(ofSize: 48) ])
        let message = NSAttributedString(string: "no_results".localized(),
                                         attributes: [NSAttributedStringKey.foregroundColor: Palette.primary.color(),
                                                      NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18) ])
        
        attributedString.append(icon)
        attributedString.append(NSAttributedString(string: "\n\n"))
        attributedString.append(message)
        
        return attributedString
    }
}
