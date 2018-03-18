import UIKit

class ProductCell: UITableViewCell {
    
    weak var product: Product? {
        didSet {
            update()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        reset()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    
    private func update() {
        guard let product = product else {
            reset()
            return
        }
        
        DispatchQueue.main.async {
            self.textLabel?.text = product.displayName
            self.detailTextLabel?.text = product.currentPrice.description
            self.detailTextLabel?.textColor = product.isWinning ? Palette.positive.color() : Palette.negative.color()
            self.setNeedsLayout()
        }
    }
    
    @objc
    private func update(notification: Notification) {
        if let item = notification.object as? Product {
            product = item
        }
    }
}

extension ProductCell: Resetable {
    
    func reset() {
        textLabel?.text = nil
        detailTextLabel?.text = nil
        NotificationCenter.default.removeObserver(self)
    }
}

extension ProductCell: Updatable {
    
    typealias UpdateType = Product
    
    func update(model: UpdateType) {
        
        product = model
        NotificationCenter.default.addObserver(self, selector: #selector(update(notification:)),
                                               name: Notification.Name(rawValue: "notification_\(model.securityId)"),
                                               object: nil)
    }
}
