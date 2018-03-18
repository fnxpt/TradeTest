import UIKit
import Starscream

class Client: TradeClientProtocol {
    
    private var socket: WebSocket
    private var subscribed: [Product] = []
    
    init() {
        
        var request = URLRequest(url: URL(string: "http://localhost:8080/subscriptions/me")!)
        request.timeoutInterval = 5
        request.setValue(API.token, forHTTPHeaderField: "Authorization")
        socket = WebSocket(request: request)
        socket.callbackQueue = DispatchQueue(label: "pt.fnx.socket")
        
        socket.onConnect = { //[unowned self]
            
        }
        
        socket.onDisconnect = { error in
            print(error?.localizedDescription ?? "")
        }
        
        socket.onText = { [unowned self] text in
            
            if let data = text.data(using: .utf8),
                let response = SocketResponse(data: data),
                let quote = response.body as? QuoteResponse {
                
                if let product = self.subscribed.first(where: { "\($0.securityId)" == quote.identifier }) {
                    
                    product.update(model: quote.amount)
                }
            }
        }
        
        self.socket.connect()
    }
    
    func load(product identifier: String,
              completion: @escaping (_ product: Product?, _ error: Error?) -> Void) {
        
        ProductRequest.get(identifier: identifier.lowercased()) { response in
            
            DispatchQueue.main.async {
                
                switch response {
                case .error(let error):
                    completion(nil, error)
                case .success(let item):
                    completion(item, nil)
                }
            }
        }
    }
    
    func subscribe(products: [Product]) {

        let subscriptions = Subscriptions(subscribed: products, removed: [])
        let encoder = JSONEncoder()
        let data = try? encoder.encode(subscriptions)
        if let data = data {
            self.socket.write(data: data)
            subscribed = products
        }
    }
    
    func unsubscribe() {
        
        let subscriptions = Subscriptions(subscribed: [], removed: subscribed)
        let encoder = JSONEncoder()
        let data = try? encoder.encode(subscriptions)
        if let data = data {
            self.socket.write(data: data)
            subscribed = []
        }
    }
}
