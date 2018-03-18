import UIKit
import SwiftChart

class DetailViewController: UIViewController {
    
    @IBOutlet private weak var closurePriceLabel: UILabel?
    @IBOutlet private weak var currentPriceLabel: UILabel?
    @IBOutlet private weak var lineChart: Chart?
    @IBOutlet private weak var toggleButton: UIButton?
    
    var points: ChartSeries = ChartSeries([])
    
    var item: Product? {
        didSet {
            guard let item = item else { return }
            title = item.symbol
            if points.data.count == 0 {
                points.data.append((x: 0, y: item.closingPrice.amount))
            }
            update()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let item = item {
            
            App.shared.client.subscribe(products: [item])
            NotificationCenter.default.addObserver(self, selector: #selector(update(notification:)),
                                                   name: Notification.Name(rawValue: "notification_\(item.securityId)"),
                                                   object: nil)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        App.shared.client.unsubscribe()
        //swiftlint:disable:next notification_center_detachment
        NotificationCenter.default.removeObserver(self)
    }
    
    func configView() {
        reset()
        
        points.colors = (
            above: Palette.positive.color(),
            below: Palette.negative.color(),
            zeroLevel: item?.closingPrice.amount ?? 0
        )
        lineChart?.xLabels = []
        lineChart?.yLabelsFormatter = { [unowned self] _, amount in
            guard let formatter = self.item?.closingPrice.formatter else { return "\(amount)" }
            
            return formatter.string(for: amount) ?? "\(amount)"
        }
        self.lineChart?.add(self.points)

        updateToggleButton()
        toggleButton?.tintColor = Palette.star.color()
    }
    
    func updateToggleButton() {
        guard let item = item else { return }
        
        let index = App.shared.subscribed.index(of: item)
        
        DispatchQueue.main.async {
            self.toggleButton?.isSelected = index != nil
        }
    }
    
    @IBAction func toggleSubscription(_ sender: Any) {
        guard let item = item else { return }
        
        if let index = App.shared.subscribed.index(of: item) {
            App.shared.subscribed.remove(at: index)
        } else {
            App.shared.subscribed.append(item)
        }
        
        updateToggleButton()
    }
    
    func update() {
        guard let item = item else {
            
            reset()
            return
        }

        points.data.append((x: Double(points.data.count), y: item.currentPrice.amount))

        let currentText = "\(item.currentPrice.description) (\(String(format: "%.2f%", item.percentage))%)"
        
        DispatchQueue.main.async {
            self.closurePriceLabel?.text = item.closingPrice.description
            self.currentPriceLabel?.text = currentText
            self.currentPriceLabel?.textColor = item.isWinning ? Palette.positive.color() : Palette.negative.color()
            self.lineChart?.setNeedsDisplay()
        }
    }
    
    @objc
    private func update(notification: Notification) {
        
        if let item = notification.object as? Product {
            self.item = item
        }
    }
}

extension DetailViewController: Resetable {
    
    func reset() {
        
        self.closurePriceLabel?.text = nil
        self.currentPriceLabel?.text = nil
    }
}
