//
//  SetupTableView.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/19.
//

import UIKit

final class SetupTableView: UIView {
    
    // MARK: - Properties
    var setupMainDelegate: SetupMainDelegate?
    
    var user: User? {
        didSet {
            self.setupinfoHeaderDelegate?.configInfoHeader(user: self.user)
        }
    }
    
    var setupinfoHeaderDelegate: SetupInfoHeaderDelegate?
    
    
    private var fontColor: UIColor = .white
    
    
    
    
    
    
    // MARK: - Setup_Header
    private lazy var setupHeader: SetupHeaderView = {
        let headerFrame = CGRect(x: 0,
                           y: 0,
                           width: self.frame.width,
                           height: 80)
        let header = SetupHeaderView(frame: headerFrame)
        
        
        return header
    }()
    
    
    
    // MARK: - Setup_Table
    private lazy var setupTableView: UITableView = {
        let setupTableFrame = CGRect(x: 0,
                                     y: 0,
                                     width: self.frame.width,
                                     height: self.frame.height)
        let view = UITableView(frame: setupTableFrame)
            view.delegate = self
            view.dataSource = self

            view.separatorStyle = .none
            view.backgroundColor = .clear

            view.register(SetupTableviewCell.self,
                          forCellReuseIdentifier: ReuseIdentifier.setupTableViewCell)
        
            // setupTableview - headerView 추가
//        let header = SetupHeaderView(frame: headerFrame)
        self.setupinfoHeaderDelegate = self.setupHeader
            view.tableHeaderView = self.setupHeader
            view.isScrollEnabled = false
        return view
    }()
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    // MARK: - Helper Functions
    private func configureUI() {
        self.addSubview(self.setupTableView)
        
        self.backgroundColor = .clear
        
        self.alpha = 0
    }
    
    func setupColor(_ color: UIColor) {
        self.setupHeader.fontColor = color
        self.fontColor = color
        self.setupTableView.reloadData()
    }
}




















// MARK: - Black_View
extension SetupTableView: SetupCellSetupDelegate {
    // setup_View -> BlackView
    func logoutBtnTapped() {
        // black_View 보이게 하기
            // 일관성을 위해 MainVC에서 작업
        self.setupMainDelegate?.setupBlackViewShow()
    }
}




















// MARK: - UITableView

extension SetupTableView: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Section
    // 섹션의 _개수
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    
    // 섹션 _타이틀 이름
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0
            ? "알림 설정"
            : "계정"
    }
    
    
    
    // 섹션 헤더 설정
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            // background Color
            headerView.contentView.backgroundColor = UIColor(white: 1, alpha: 0.2)
            // section 헤더의 글자색 바꾸기
            headerView.textLabel?.textColor = self.fontColor
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
        
        // info
        if indexPath.section == 0 {
            cell.setupCellTitle = .info
            cell.titleLabel.text = "알림"
            cell.cellButton.setTitle(self.user?.notiString, for: .normal)
            
        // logout
        } else {
            cell.setupCellTitle = .logout
            cell.titleLabel.text = "로그아웃"
        }
        
        cell.setupCellSetupDelegate = self
        cell.fontColor = self.fontColor
        return cell
    }
}
