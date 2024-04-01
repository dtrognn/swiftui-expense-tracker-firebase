//
//  SSNavigationPath.swift
//  SpendSmart
//
//  Created by dtrognn on 01/04/2024.
//

import SwiftUI

public enum NavigationType {
    case push
    case pop
    case present
    case dismiss
}


/** The manager behind the `DGNavigationStackView`. It also enables programmatic navigation.

 A `DGNavigationPath` is automatically injected as an `@EnvironmentObject` into a `DGNavigationStackView` hierarchy.

 Also, it can be created outside of a `DGNavigationStackView` hierarchy and injected manually into it during the `DGNavigationStackView` initialization process.
*/
public class SSNavigationPath: ObservableObject {

    /// The default easing function for push and pop transitions.
    /// - Tag: defaultEasing
    public static let defaultEasing = Animation.easeOut(duration: 0.3)

    @Published var currentView: ViewElement?
    @Published private(set) var navigationType = NavigationType.push
    private let easing: Animation

    /// Creates a DGNavigationPath.
    /// - Parameter easing: The easing function to apply to push and pop transitions. By default, the [default easing function](x-source-tag://defaultEasing) will be used.
    public init(easing: Animation = defaultEasing) {
        self.easing = easing
    }

    public func lastViewID() -> String? {
        return currentView?.id
    }

    private var viewStack = ViewStack() {
        didSet {
            currentView = viewStack.peek()
        }
    }

    /// The current depth of the navigation stack.
    /// Root has depth = 0
    public var depth: Int {
        viewStack.depth
    }

    /// Returns a Boolean value indicating whether the stack contains a view with the specified ID.
    /// - Parameter id: The ID of the view to look for.
    /// - Returns: **true**  if the stack contains a view with the specified ID; otherwise, **false**.
    public func containsView(withId id: String) -> Bool {
        viewStack.indexForView(withId: id) != nil
    }

    /// Navigates to a view.
    /// - Parameters:
    ///   - element: The destination view.
    ///   - identifier: The ID of the destination view (used to easily come back to it if needed).
    public func push<Element: View>(_ element: Element, withId identifier: String? = nil) {
        let identifier = identifier ?? UUID().uuidString
        navigationType = .push
        withAnimation(easing) {
            viewStack.push(ViewElement(id: identifier,
                wrappedElement: AnyView(element)))
        }
    }

    /// Navigates back to a previous view.
    /// - Parameter to: The destination type of the transition operation.
    public func pop(to: PopDestination = .previous) {
        navigationType = .pop
        withAnimation(easing) {
            switch to {
            case .root:
                viewStack.popToRoot()
            case .view(let viewId):
                viewStack.popToView(withId: viewId)
            default:
                viewStack.popToPrevious()
            }
        }
    }

    public func present<Element: View>(_ element: Element, withId identifier: String? = nil) {
        let identifier = identifier ?? String(describing: type(of: element))
        navigationType = .present
        withAnimation(easing) {
            viewStack.push(ViewElement(id: identifier,
                wrappedElement: AnyView(element)))
        }
    }

    public func dismiss() {
        navigationType = .dismiss
        withAnimation(easing) {
            viewStack.popToPrevious()
        }
    }
}

private struct ViewStack {
    private var views = [ViewElement]()

    func peek() -> ViewElement? {
        views.last
    }

    var depth: Int {
        views.count
    }

    mutating func push(_ element: ViewElement) {
        guard indexForView(withId: element.id) == nil else {
            print("Duplicated view identifier: \"\(element.id)\". You are trying to push a view with an identifier that already exists on the navigation stack.")
            return
        }
        views.append(element)
    }

    mutating func popToPrevious() {
        _ = views.popLast()
    }

    mutating func popToView(withId identifier: String) {
        guard let viewIndex = indexForView(withId: identifier) else {
            print("Identifier \"\(identifier)\" not found. You are trying to pop to a view that doesn't exist.")
            return
        }
        views.removeLast(views.count - (viewIndex + 1))
    }

    mutating func popToRoot() {
        views.removeAll()
    }

    func indexForView(withId identifier: String) -> Int? {
        views.firstIndex {
            $0.id == identifier
        }
    }
}

struct ViewElement: Identifiable, Equatable {
    let id: String
    let wrappedElement: AnyView

    static func == (lhs: ViewElement, rhs: ViewElement) -> Bool {
        lhs.id == rhs.id
    }
}
