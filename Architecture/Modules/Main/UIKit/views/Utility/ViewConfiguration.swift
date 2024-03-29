//
//  ViewConfiguration.swift
//  interview
//
//  Created by Ara Hakobyan on 3/29/24.
//

import UIKit

public typealias Completion<T> = (T) -> Void

public protocol ViewConfiguration: AnyObject {
    func setupViewConfiguration()
    func configureViews()
    func buildViewHierarchy()
}

public extension ViewConfiguration {
    func setupViewConfiguration() {
        configureViews()
        buildViewHierarchy()
    }
}

public func makeStack(
    items: [UIView],
    axis: NSLayoutConstraint.Axis,
    distribution: UIStackView.Distribution = .fill,
    alignment: UIStackView.Alignment = .leading,
    spacing: CGFloat = 0
) -> UIStackView {
    let stackView = UIStackView()
    stackView.axis = axis
    stackView.distribution = distribution
    stackView.alignment = alignment
    stackView.spacing = spacing
    items.forEach { stackView.addArrangedSubview($0) }
    return stackView
}
