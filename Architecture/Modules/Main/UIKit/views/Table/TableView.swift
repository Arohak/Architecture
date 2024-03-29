//
//  BaseTableView.swift
//  interview
//
//  Created by Ara Hakobyan on 3/29/24.
//

import UIKit

enum TableViewEvent {
    case didSelect(Int)
    case loadMore
}

class TableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    private var rows: [CellModel] = []
    public var event: Completion<TableViewEvent>?

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        configure()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        backgroundColor = .white
        separatorStyle = .none
        dataSource = self
        delegate = self
        registerCell(TableViewCell.self)
    }

    public func update(with rows: [CellModel]) {
        self.rows = rows
        reloadData()
    }

    private func scrollToTop() {
        scrollToRow(at: .init(row: 0, section: 0), at: .top, animated: true)
    }
    
    // MARK: - UITableViewDataSource, UITableViewDelegate
    
    func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let row = rows[safe: indexPath.row] else { fatalError() }
        let cell: TableViewCell = tableView.dequeueReusableCell(indexPath)
        cell.update(with: row)
        return cell
    }

    func tableView(_: UITableView, willDisplay _: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard rows.count - 1 == indexPath.row else { return }
        event?(.loadMore)
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        event?(.didSelect(indexPath.row))
    }

    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 44
        return UITableView.automaticDimension
    }

    func tableView(_: UITableView, viewForHeaderInSection _: Int) -> UIView? {
        return nil
    }

    func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
        return 0
    }
}

