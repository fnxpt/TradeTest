import Foundation

enum ServiceError: Error {
    case unexpected
    case unableToParse
    case failed(reason: FailedReasonProtocol)
}

extension ServiceError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .unexpected:
            return "unexpected".localized()
        case .unableToParse:
            return "unableToParse".localized()
        case .failed(let reason):
            return reason.message
        }
    }
}
