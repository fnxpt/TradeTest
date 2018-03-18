import UIKit

protocol GroupableDataSource {
    func numberOfGroups() -> Int
    func numberOfItems(for group: Int) -> Int
    func heightForItem(index: IndexPath) -> CGFloat
    func heightForHeader(group: Int) -> CGFloat
    func header(for group: Int) -> UIView?
    func item(index: IndexPath) -> Any?
    func emptyString() -> NSAttributedString?
}

extension GroupableDataSource {
    
    func emptyString() -> NSAttributedString? {
        return nil
    }
    
    func heightForHeader(group: Int) -> CGFloat {
        return 0
    }
    
    func header(for group: Int) -> UIView? {
        return nil
    }
}
