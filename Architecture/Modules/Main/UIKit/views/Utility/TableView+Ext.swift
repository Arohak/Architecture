//
//  TableView+Ext.swift
//  interview
//
//  Created by Ara Hakobyan on 3/29/24.
//

import UIKit

public extension UITableViewCell {
    static var reuseId: String { return String(describing: self) }
}

public extension UITableView {
    func registerCell<Cell: UITableViewCell>(_ cellClass: Cell.Type) {
        register(cellClass, forCellReuseIdentifier: Cell.reuseId)
    }

    func dequeueReusableCell<Cell: UITableViewCell>(_ indexPath: IndexPath) -> Cell {
        guard let cell = dequeueReusableCell(withIdentifier: Cell.reuseId, for: indexPath) as? Cell else {
            fatalError("fatal error for cell at \(indexPath)")
        }
        return cell
    }
}
