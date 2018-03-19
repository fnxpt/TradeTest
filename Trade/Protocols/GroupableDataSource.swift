import UIKit

protocol GroupableDataSource {
    
    func numberOfGroups() -> Int
    func numberOfItems(for group: Int) -> Int
    func heightForItem(index: IndexPath) -> CGFloat
    func item(index: IndexPath) -> Any?
    func emptyString() -> NSAttributedString?
}
