import XCTest
@testable import Trade

class ListViewControllerTest: XCTestCase {
    
    var viewController: UIViewController!
    
    override func setUp() {
        super.setUp()
        
        viewController = StoryboardScene.Main.listViewController.instantiate()
        _ = viewController.view // To call viewDidLoad
    }
}
