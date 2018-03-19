import XCTest
@testable import Trade

class DetailViewControllerTest: XCTestCase {
    
    var viewController: UIViewController!
    
    override func setUp() {
        super.setUp()
        
        viewController = StoryboardScene.Main.detailViewController.instantiate()
        _ = viewController.view // To call viewDidLoad
    }
    
    //TEST SUBSCRIPTIONS
    //TEST UNSUBSCRIPTIONS
    //TEST TOGGLE FAVORITES
}
