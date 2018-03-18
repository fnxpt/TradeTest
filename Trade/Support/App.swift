import UIKit

class App {
    
    static let shared: App = App()
    
    var client: TradeClientProtocol = Client()
    var subscribed: [Product] = [] {
        didSet {
            let encoder = JSONEncoder()
            let subscriptions = try? encoder.encode(subscribed)
            let defaults = UserDefaults.standard
            defaults.set(subscriptions, forKey: "subscriptions")
            defaults.synchronize()
        }
    }
    
    private init() { }
    
    func didFinishLauching() {
        
        theme()
        loadSubscriptions()
    }
    
    private func loadSubscriptions() {
        let defaults = UserDefaults.standard
        
        if let subscriptions = defaults.data(forKey: "subscriptions") {
            
            let tmp = try? [Product].decode(data: subscriptions)
            subscribed = tmp ?? []
            
            subscribed.forEach({ product in
                
                self.client.load(product: product.securityId, completion: { item, _ in
                    
                    if let item = item {
                        
                        product.closingPrice = item.closingPrice
                    }
                })
            })
        }
    }
}

extension App {
    
    func theme() {
        
        let navAppearance = UINavigationBar.appearance()
        navAppearance.isTranslucent = true
        navAppearance.tintColor = Palette.secondary.color()
        navAppearance.barTintColor = Palette.primary.color()
        navAppearance.titleTextAttributes =
            [NSAttributedStringKey.foregroundColor: Palette.secondary.color()]
        
        if #available(iOS 11, *) {
            
            navAppearance.prefersLargeTitles = true
            navAppearance.largeTitleTextAttributes = [
                NSAttributedStringKey.foregroundColor: Palette.secondary.color(),
                NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 26)
            ]
        }
        
        UISegmentedControl.appearance().tintColor = Palette.secondary.color()
        UIActivityIndicatorView.appearance().color = Palette.primary.color()
        
        UISearchBar.appearance().tintColor = Palette.secondary.color()
        UITableView.appearance().sectionIndexColor = Palette.primary.color()
        
        let searchTextfieldAppearance = UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        
        searchTextfieldAppearance.defaultTextAttributes = [
            NSAttributedStringKey.foregroundColor.rawValue: Palette.secondary.color()
        ]
    }
}
