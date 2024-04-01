//
//  SSNavigationStackView.swift
//  SpendSmart
//
//  Created by dtrognn on 01/04/2024.
//

import SwiftUI

/// The transition type for the whole NavigationStackView.
public enum NavigationTransition {
    /// Transitions won't be animated.
    case none

    /// Use the [default transition](x-source-tag://defaultTransition).
    case `default`

    /// Use a custom transition (the transition will be applied both to push and pop operations).
    case custom(AnyTransition)

    /// A right-to-left slide transition on push, a left-to-right slide transition on pop.
    /// - Tag: defaultTransition
    public static var defaultTransitions: (push: AnyTransition, pop: AnyTransition, present: AnyTransition, dismiss: AnyTransition) {
        let pushTrans = AnyTransition.asymmetric(insertion: .move(edge: .trailing),
            removal: .move(edge: .leading))
        let popTrans = AnyTransition.asymmetric(insertion: .move(edge: .leading),
            removal: .move(edge: .trailing))

        let dismissTrans = AnyTransition.asymmetric(insertion: .move(edge: .top),
            removal: .move(edge: .bottom))
        let presentTrans = AnyTransition.asymmetric(insertion: .move(edge: .bottom),
            removal: .move(edge: .top))
        return (pushTrans, popTrans, presentTrans, dismissTrans)
    }
}

/// An alternative SwiftUI NavigationView implementing classic stack-based navigation giving also some more control on animations and programmatic navigation.
///
public struct SSNavigationStackView<Root>: View where Root: View {
    @ObservedObject private var navigationPath: SSNavigationPath
    private let rootView: Root
    private let transitions: (push: AnyTransition, pop: AnyTransition, present: AnyTransition, dismiss: AnyTransition)

    /// Creates a NavigationStackView.
    /// - Parameters:
    ///   - transitionType: The type of transition to apply between views in every push and pop operation.
    ///   - easing: The easing function to apply to every push and pop operation.
    ///   - rootView: The very first view in the NavigationStack.
    public init(transitionType: NavigationTransition = .default,
        easing: Animation = SSNavigationPath.defaultEasing,
        @ViewBuilder rootView: () -> Root) {

        self.init(transitionType: transitionType,
                  navigationPath: SSNavigationPath(easing: easing),
            rootView: rootView)
    }

    /// Creates a NavigationStackView with the provided DGNavigationPath.
    /// - Parameters:
    ///   - transitionType: The type of transition to apply between views in every push and pop operation.
    ///   - navigationStack: the shared DGNavigationPath.
    ///   - rootView: The very first view in the NavigationStack.
    public init(transitionType: NavigationTransition = .default,
                navigationPath: SSNavigationPath,
        @ViewBuilder rootView: () -> Root) {

        self.rootView = rootView()
        self.navigationPath = navigationPath
        switch transitionType {
        case .none:
            self.transitions = (.identity, .identity, .identity, .identity)
        case .custom(let trans):
            self.transitions = (trans, trans, trans, trans)
        default:
            self.transitions = NavigationTransition.defaultTransitions
        }
    }

    public var body: some View {
        let showRoot = navigationPath.currentView == nil
        let navigationType = navigationPath.navigationType

        return ZStack {
            Group {
                if showRoot {
                    rootView
                        .transition(getTransition(navigationType))
                        .environmentObject(navigationPath)
                } else {
                    navigationPath.currentView!.wrappedElement
                        .transition(getTransition(navigationType))
                        .environmentObject(navigationPath)
                }
            }
        }
    }

    private func getTransition(_ navigationType: NavigationType) -> AnyTransition {
        switch navigationType {
        case .push:
            return transitions.push
        case .pop:
            return transitions.pop
        case .present:
            return transitions.present
        case .dismiss:
            return transitions.dismiss
        }
    }
}
