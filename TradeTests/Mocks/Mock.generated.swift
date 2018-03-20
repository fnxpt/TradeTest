// Generated using Sourcery 0.10.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


//swiftlint:disable vertical_whitespace
//swiftlint:disable closure_spacing
//swiftlint:disable trailing_newline
//swiftlint:disable switch_case_alignment
//swiftlint:disable switch_case_on_newline
//swiftlint:disable identifier_name
//swiftlint:disable line_length

#if MockyCustom
import SwiftyMocky
@testable import Trade

    public final class MockyAssertion {
        public static var handler: ((Bool, String, StaticString, UInt) -> Void)?
    }

    func MockyAssert(_ expression: @autoclosure () -> Bool, _ message: @autoclosure () -> String = "Verification failed", file: StaticString = #file, line: UInt = #line) {
        guard let handler = MockyAssertion.handler else {
            assert(expression, message, file: file, line: line)
            return
        }

        handler(expression(), message(), file, line)
    }
#elseif Mocky
import SwiftyMocky
import XCTest
@testable import Trade

    func MockyAssert(_ expression: @autoclosure () -> Bool, _ message: @autoclosure () -> String = "Verification failed", file: StaticString = #file, line: UInt = #line) {
        XCTAssert(expression(), message(), file: file, line: line)
    }
#else
import Sourcery
import SourceryRuntime
#endif



// MARK: - GroupableDataSource
class GroupableDataSourceMock: GroupableDataSource, Mock {
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    var matcher: Matcher = Matcher.default


    typealias Property = Swift.Never


    func numberOfGroups() -> Int {
        addInvocation(.inumberOfGroups)
		let perform = methodPerformValue(.inumberOfGroups) as? () -> Void
		perform?()
		let givenValue: (value: Any?, error: Error?) = methodReturnValue(.inumberOfGroups)
		let value = givenValue.value as? Int
		return value.orFail("stub return value not specified for numberOfGroups(). Use given")
    }

    func numberOfItems(for group: Int) -> Int {
        addInvocation(.inumberOfItems__for_group(Parameter<Int>.value(group)))
		let perform = methodPerformValue(.inumberOfItems__for_group(Parameter<Int>.value(group))) as? (Int) -> Void
		perform?(group)
		let givenValue: (value: Any?, error: Error?) = methodReturnValue(.inumberOfItems__for_group(Parameter<Int>.value(group)))
		let value = givenValue.value as? Int
		return value.orFail("stub return value not specified for numberOfItems(for group: Int). Use given")
    }

    func heightForItem(index: IndexPath) -> CGFloat {
        addInvocation(.iheightForItem__index_index(Parameter<IndexPath>.value(index)))
		let perform = methodPerformValue(.iheightForItem__index_index(Parameter<IndexPath>.value(index))) as? (IndexPath) -> Void
		perform?(index)
		let givenValue: (value: Any?, error: Error?) = methodReturnValue(.iheightForItem__index_index(Parameter<IndexPath>.value(index)))
		let value = givenValue.value as? CGFloat
		return value.orFail("stub return value not specified for heightForItem(index: IndexPath). Use given")
    }

    func item(index: IndexPath) -> Any? {
        addInvocation(.iitem__index_index(Parameter<IndexPath>.value(index)))
		let perform = methodPerformValue(.iitem__index_index(Parameter<IndexPath>.value(index))) as? (IndexPath) -> Void
		perform?(index)
		let givenValue: (value: Any?, error: Error?) = methodReturnValue(.iitem__index_index(Parameter<IndexPath>.value(index)))
		let value = givenValue.value as? Any?
		return value.orFail("stub return value not specified for item(index: IndexPath). Use given")
    }

    func emptyString() -> NSAttributedString? {
        addInvocation(.iemptyString)
		let perform = methodPerformValue(.iemptyString) as? () -> Void
		perform?()
		let givenValue: (value: Any?, error: Error?) = methodReturnValue(.iemptyString)
		let value = givenValue.value as? NSAttributedString?
		return value.orFail("stub return value not specified for emptyString(). Use given")
    }

    fileprivate enum MethodType {
        case inumberOfGroups
        case inumberOfItems__for_group(Parameter<Int>)
        case iheightForItem__index_index(Parameter<IndexPath>)
        case iitem__index_index(Parameter<IndexPath>)
        case iemptyString

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
                case (.inumberOfGroups, .inumberOfGroups):
                    return true 
                case (.inumberOfItems__for_group(let lhsGroup), .inumberOfItems__for_group(let rhsGroup)):
                    guard Parameter.compare(lhs: lhsGroup, rhs: rhsGroup, with: matcher) else { return false } 
                    return true 
                case (.iheightForItem__index_index(let lhsIndex), .iheightForItem__index_index(let rhsIndex)):
                    guard Parameter.compare(lhs: lhsIndex, rhs: rhsIndex, with: matcher) else { return false } 
                    return true 
                case (.iitem__index_index(let lhsIndex), .iitem__index_index(let rhsIndex)):
                    guard Parameter.compare(lhs: lhsIndex, rhs: rhsIndex, with: matcher) else { return false } 
                    return true 
                case (.iemptyString, .iemptyString):
                    return true 
                default: return false
            }
        }

        func intValue() -> Int {
            switch self {
                case .inumberOfGroups: return 0
                case let .inumberOfItems__for_group(p0): return p0.intValue
                case let .iheightForItem__index_index(p0): return p0.intValue
                case let .iitem__index_index(p0): return p0.intValue
                case .iemptyString: return 0
            }
        }
    }

    struct Given {
        fileprivate var method: MethodType
        var returns: Any?
        var `throws`: Error?

        private init(method: MethodType, returns: Any?, throws: Error?) {
            self.method = method
            self.returns = returns
            self.`throws` = `throws`
        }

        static func numberOfGroups(willReturn: Int) -> Given {
            return Given(method: .inumberOfGroups, returns: willReturn, throws: nil)
        }
        static func numberOfItems(for group: Parameter<Int>, willReturn: Int) -> Given {
            return Given(method: .inumberOfItems__for_group(group), returns: willReturn, throws: nil)
        }
        static func heightForItem(index: Parameter<IndexPath>, willReturn: CGFloat) -> Given {
            return Given(method: .iheightForItem__index_index(index), returns: willReturn, throws: nil)
        }
        static func item(index: Parameter<IndexPath>, willReturn: Any?) -> Given {
            return Given(method: .iitem__index_index(index), returns: willReturn, throws: nil)
        }
        static func emptyString(willReturn: NSAttributedString?) -> Given {
            return Given(method: .iemptyString, returns: willReturn, throws: nil)
        }
    }

    struct Verify {
        fileprivate var method: MethodType

        static func numberOfGroups() -> Verify {
            return Verify(method: .inumberOfGroups)
        }
        static func numberOfItems(for group: Parameter<Int>) -> Verify {
            return Verify(method: .inumberOfItems__for_group(group))
        }
        static func heightForItem(index: Parameter<IndexPath>) -> Verify {
            return Verify(method: .iheightForItem__index_index(index))
        }
        static func item(index: Parameter<IndexPath>) -> Verify {
            return Verify(method: .iitem__index_index(index))
        }
        static func emptyString() -> Verify {
            return Verify(method: .iemptyString)
        }
    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        static func numberOfGroups(perform: () -> Void) -> Perform {
            return Perform(method: .inumberOfGroups, performs: perform)
        }
        static func numberOfItems(for group: Parameter<Int>, perform: (Int) -> Void) -> Perform {
            return Perform(method: .inumberOfItems__for_group(group), performs: perform)
        }
        static func heightForItem(index: Parameter<IndexPath>, perform: (IndexPath) -> Void) -> Perform {
            return Perform(method: .iheightForItem__index_index(index), performs: perform)
        }
        static func item(index: Parameter<IndexPath>, perform: (IndexPath) -> Void) -> Perform {
            return Perform(method: .iitem__index_index(index), performs: perform)
        }
        static func emptyString(perform: () -> Void) -> Perform {
            return Perform(method: .iemptyString, performs: perform)
        }
    }

    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
        methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }
    public func verify(property: Property, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) { }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) -> (value: Any?, error: Error?) {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher)  }
        return (value: matched?.returns, error: matched?.`throws`)
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
}

