import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    var datasource: GroupableDataSource = ListDataSource()
    var cellType: UITableViewCell.Type = ProductCell.self
    var backgroundView: UIView?
    
    fileprivate var searchController: UISearchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        App.shared.client.subscribe(products: App.shared.subscribed)
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if datasource.numberOfItems(for: 0) == 0 {
            searchController.isActive = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        App.shared.client.unsubscribe()
    }
    
    func configView() {
        
        title = "products".localized()
        
        tableView.tableFooterView = UIView()
        tableView.register(identifier: cellType.className)
        
        if let emptyString = datasource.emptyString() {
            
            let label = UILabel()
            label.textAlignment = .center
            label.numberOfLines = 0
            label.attributedText = emptyString
            backgroundView = label
        }
        
        searchController.delegate = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }
    
    func load(product: String) {
        
        view.isUserInteractionEnabled = false
        activityIndicator.isHidden = false
        searchController.isActive = false
        
        App.shared.client.load(product: product,
                                completion: { [unowned self] item, error in
                                    
                                    self.activityIndicator.isHidden = true
                                    self.view.isUserInteractionEnabled = true
                                    
                                    if let error = error {
                                        self.show(error: error)
                                    } else if let item = item {
                                        self.goToDetail(item: item)
                                    }
        })
    }
    
    func goToDetail(item: Product) {
        let segue = StoryboardSegue.Main.segueDetail
        perform(segue: segue, sender: item)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let item = sender as? Product,
            let destination = segue.destination as? DetailViewController {
            
            destination.item = item
        }
    }
}

extension ListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return datasource.numberOfGroups()
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        let items = datasource.numberOfItems(for: section)
        tableView.backgroundView = items == 0 ? backgroundView : nil
        
        return items
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellType.className, for: indexPath)
        
        if let item = datasource.item(index: indexPath) as? Product,
            let cell = cell as? ProductCell {
            
            cell.update(model: item)
        }
        
        return cell
    }
}

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = datasource.item(index: indexPath) as? Product {
            
            goToDetail(item: item)
        }
    }
}

extension ListViewController: UISearchControllerDelegate {
    
    func didPresentSearchController(_ searchController: UISearchController) {
        
        DispatchQueue.main.async {
            searchController.searchBar.becomeFirstResponder()
        }
    }
}

extension ListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            load(product: text)
        }
    }
}
