import XCTest
@testable import Trade

class DetailViewControllerTest: XCTestCase {
    
    var viewController: DetailViewController!
    
    override func setUp() {
        super.setUp()
        
        let price = Price(amount: 10, currency: "EUR")
        let product = Product(identifier: "TEST", symbol: "TEST", displayName: "TEST", closingPrice: price)
        
        viewController = StoryboardScene.Main.detailViewController.instantiate()
        viewController.item = product
        _ = viewController.view // To call viewDidLoad
    }
    
    func testToggleSubscription() {
        viewController.toggleSubscription(self)
        //CHECK IF ITS MARKED AS FAVORITE
        
        viewController.toggleSubscription(self)
        //CHECK IF ITS NOT MARKED AS FAVORITE
    }
    
    func testSubscribe() {
        viewController.viewWillAppear(false)
        //CHECK IF IS SUBSCRIBED
        
        viewController.viewWillDisappear(false)
        //CHECK IF IS UNSUBSCRIBED
    }
}
