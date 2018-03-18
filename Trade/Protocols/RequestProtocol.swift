protocol RequestProtocol {
    
    associatedtype ResponseType
    
    static func get(identifier: String,
                    completionHandler: @escaping (Response<ResponseType>) -> Void)
}
