//
//  TableViewCell.swift
//  interview
//
//  Created by Ara Hakobyan on 3/29/24.
//

import UIKit
import TinyConstraints

struct CellModel {
    let image: UIImage?
    let title: String
    let desc: String
}

class TableViewCell: UITableViewCell {
    private let offset: CGFloat = 16

    private let iconView = UIImageView()
    private let titleLabel = UILabel()
    private let descLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewConfiguration()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func update(with model: CellModel) {
        iconView.image = model.image
        titleLabel.text = model.title
        descLabel.text = model.desc
    }
}

// MARK: - ViewConfiguration

extension TableViewCell: ViewConfiguration {
    func configureViews() {
        selectionStyle = .none
        backgroundColor = .white
        
        titleLabel.backgroundColor = .red
        titleLabel.font = .systemFont(ofSize: 20)
        
        descLabel.backgroundColor = .orange
        descLabel.font = .systemFont(ofSize: 16)
    }
    
    func buildViewHierarchy() {
        let stackView = makeStack(items: [iconView, titleLabel, descLabel], axis: .vertical, spacing: offset)
        stackView.setCustomSpacing(offset / 2, after: titleLabel)
        stackView.layoutMargins = UIEdgeInsets(top: offset, left: offset, bottom: offset, right: offset)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.backgroundColor = .lightGray
        
        contentView.addSubview(stackView)
        stackView.edgesToSuperview(usingSafeArea: true)
    }
}
