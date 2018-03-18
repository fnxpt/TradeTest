protocol TradeClientProtocol {
    
    func load(product identifier: String,
              completion: @escaping (_ product: Product?, _ error: Error?) -> Void)
    
    func subscribe(products: [Product])
    
    func unsubscribe()
}
