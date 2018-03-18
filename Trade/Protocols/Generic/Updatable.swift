protocol Updatable {
    
    associatedtype UpdateType

    func update(model: UpdateType)
}
