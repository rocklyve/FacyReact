//
//  Created by David Laubenstein on 15.04.19.
//  Copyright © 2019 Jamit Labs GmbH. All rights reserved.
//

import Imperio
import SnapKit
import UIKit

struct MenuCellModel {
    var title: String?
    var icon: UIImage?
}

class MenuCell: UITableViewCell {
    lazy var icon: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        return imageView
    }()

    lazy var cellLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .white
        return label
    }()

    var cellModel: MenuCellModel? {
        didSet {
            icon.image = cellModel?.icon
            cellLabel.text = cellModel?.title
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(cellLabel)
        addSubview(icon)
        setupConstraints()
    }

    func setupConstraints() {
        icon.snp.makeConstraints { make in
            make.left.equalTo(24)
            make.width.height.equalTo(24)
            // make.centerY.equalToSuperview()
            make.top.equalTo(10)
        }

        cellLabel.snp.makeConstraints { make in
            make.left.equalTo(icon.snp.right).offset(24)
            //            make.centerY.equalToSuperview()
            //            make.right.equalToSuperview()
            make.height.equalTo(20)
            make.top.equalTo(10)
            make.width.equalTo(150)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
