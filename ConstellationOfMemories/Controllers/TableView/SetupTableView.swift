//
//  SetupTableView.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/19.
//

import UIKit

final class SetupTableView: UIView {
    
    // MARK: - Properties
    
    
    
    // MARK: - Setup_Table
    private lazy var setupTableView: UITableView = {
        let setupTableFrame = CGRect(x: 0,
                                     y: 0,
                                     width: self.frame.width,
                                     height: self.frame.height)
        let headerFrame = CGRect(x: 0,
                           y: 0,
                           width: self.frame.width,
                           height: 80)
        let view = UITableView(frame: setupTableFrame)
            view.delegate = self
            view.dataSource = self

            view.separatorStyle = .none
            view.backgroundColor = .clear

            view.register(SetupTableviewCell.self,
                          forCellReuseIdentifier: ReuseIdentifier.setupTableViewCell)
        
            // setupTableview - headerView 추가
            view.tableHeaderView = UserInfoTableHeader(frame: headerFrame)
            view.isScrollEnabled = false
        return view
    }()
    
    
    
    
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.setupTableView)
        
        self.backgroundColor = .clear
        
        self.alpha = 0
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    // MARK: - Helper Functions
    
    
    
    
    
    
    // MARK: - API
    
    
    
}





// MARK: - UITableView
extension SetupTableView: UITableViewDelegate, UITableViewDataSource {
    // MARK: - Section
    // 섹션의 _개수
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // 섹션 _타이틀 이름
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "알림 설정"
    }
    
    // 섹션 헤더 설정
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            // background Color
            headerView.contentView.backgroundColor = UIColor(white: 1, alpha: 0.2)
            // section 헤더의 글자색 바꾸기
            headerView.textLabel?.textColor = .nightFontColor
        }
    }
    
    
    
    
    
    // MARK: - Cell
    // 셀의 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    
    // 셀의 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    
    
    
    // MARK: - cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.setupTableViewCell, for: indexPath) as! SetupTableviewCell
            cell.titleLabel.text = "알림"
        return cell
    }
    
    
    
    
    
    // MARK: - didSelectRowAt
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        print(#function)
//    }
}
