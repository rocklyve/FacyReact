//
//  Created by David Laubenstein on 24.04.19.
//  Copyright © 2019 Jamit Labs GmbH. All rights reserved.
//

import Imperio
import SnapKit
import UIKit

struct ManualConnectionScanCellModel {
    var title: String?
    var buttonTitle: String?
    weak var flowDelegate: ManualConnectionFlowDelegate?
}

class ManualConnectionScanCell: UITableViewCell {
    lazy var background: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.GrayScale.white
        return view
    }()

    lazy var elementStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.addArrangedSubview(cellLabel)
        stackView.alignment = .top
        return stackView
    }()

    lazy var cellLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = Colors.GrayScale.darkGray
        return label
    }()

    lazy var cellButton: UIButton = {
        let button = UIButton()
        button.contentHorizontalAlignment = .center
        button.backgroundColor = Colors.Vibrants.deepBlue
        button.addTarget(self, action: #selector(discoveryStateChanged), for: .touchUpInside)
        button.layer.cornerRadius = 30
        button.layer.borderWidth = 0
        return button
    }()

    var cellModel: ManualConnectionScanCellModel? {
        didSet {
            cellLabel.text = cellModel?.title
            cellButton.setTitle(cellModel?.buttonTitle, for: .normal)
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(background)
        background.addSubview(elementStackView)
        addSubview(cellButton)
        backgroundColor = .clear
        if cellModel?.buttonTitle == L10n.ManualConnection.stopScan {
            // enable loadingElement
        }
        setupConstraints()
    }

    @objc
    func discoveryStateChanged() {
        if cellModel?.buttonTitle == L10n.ManualConnection.scanCellTitle {
            cellModel?.flowDelegate?.startSearch()
            cellModel?.buttonTitle = L10n.ManualConnection.stopScan
            cellButton.isHighlighted = false
            cellModel?.title = L10n.ManualConnection.stopTitle
        } else {
            cellModel?.flowDelegate?.stopSearch()
            cellButton.isHighlighted = false
            cellModel?.buttonTitle = L10n.ManualConnection.scanCellTitle
            cellModel?.title = L10n.ManualConnection.searchTitle
        }
    }

    func setupConstraints() {
        background.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(40)
        }

        cellButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(30)
            make.height.equalTo(60).priority(.high)
            make.centerY.equalTo(background.snp.bottom)
        }

        elementStackView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(10)
            make.top.equalTo(background.snp.top).inset(10)
            make.bottom.equalTo(cellButton.snp.top).offset(-10)
        }

        cellLabel.snp.makeConstraints { make in
            make.left.equalTo(elementStackView.snp.left)
            make.right.equalTo(elementStackView.snp.right)
        }
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
