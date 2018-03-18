import UIKit

enum Palette {
    
    case primary
    case secondary
    case positive
    case negative
    case star
    
    func color() -> UIColor {
        switch self {
        case .primary:
            return UIColor(rgbaValue: 0x4E4D4Aff)
        case .secondary:
            return .white
        case .positive:
            return UIColor(rgbaValue: 0x7ED321ff)
        case .negative:
            return UIColor(rgbaValue: 0xD0021Bff)
        case .star:
            return UIColor(rgbaValue: 0xF8E71Cff)
        }
    }
}
