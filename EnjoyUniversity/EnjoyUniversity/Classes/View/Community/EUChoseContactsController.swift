//
//  EUChoseContactsController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/23.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUChoseContactsController: EUBaseViewController {
    
    lazy var viewmodellist = UserInfoListViewModel()
    
    /// 是否需要发送短信，上层传入
    var shouleSendSms:Bool = false
    
    /// 发送通知内容，上层传入
    var notifycationText:String = ""
    
    /// 社团 ID，上层传入
    var cmid:Int = 0
    
    /// 头部视图数组
    lazy var sectionarray = [FoldSectionView]()
    
    /// 保存选中的 index
    var selectIndexArray = [[Int]]()
    
    /// 可重用cell ID
    var EUCHOSECONTACTSCELL = "EUCHOSECONTACTSCELL"

    override func viewDidLoad() {
        super.viewDidLoad()

        navitem.title = "选择联系人"
        tableview.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        
        let rightBtn = UIBarButtonItem(title: "fas", style: .plain, target: nil, action: #selector(sendNotification))
        navitem.rightBarButtonItem = rightBtn
        
        // 开启多选
        tableview.allowsMultipleSelection = true
        tableview.register(EUCommunityMemberCell.self, forCellReuseIdentifier: EUCHOSECONTACTSCELL)
    }
    
    override func loadData() {
        viewmodellist.loadCommunityContactsInfoList(cmid: cmid) { (isSuccess, hasData) in
            self.refreshControl?.endRefreshing()
            if !isSuccess{
                SwiftyProgressHUD.showFaildHUD(text: "网络异常", duration: 1)
                return
            }
            if !hasData{
                // 理论上不可能没人（至少有社长，所有不需要做）
                return
            }
            self.groupContacts()
        }
    }
    
    func groupContacts(){
        
        // 获取当前年份
        let currentdate = Date().timeIntervalSince1970 * 1000
        let currentyear = Int(timeStampToString(timeStamp: "\(currentdate)", formate: "YYYY") ?? "") ?? 0
        
        for _ in 0...4{
            sectionarray.append(FoldSectionView(frame: CGRect(x: 0, y: 0, width: tableview.frame.width, height: 44)))
        }
        
        for viewmodel in viewmodellist.communityContactsList{
            guard let grade = viewmodel.model?.grade else {
                continue
            }
            let index = 4 - (currentyear - grade)
            sectionarray[index].datasource.append(viewmodel)
        }
        var i = 0
        for _ in 0..<sectionarray.count{
            sectionarray[i].titleLabel.text = "\(currentyear - i) 级"
            selectIndexArray.append(Array(repeating: 0, count: sectionarray[i].datasource.count))
            i += 1
        }
     
        tableview.reloadData()
    }
    
}

// MARK: - 代理相关方法
extension EUChoseContactsController:FoldSectionViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionarray.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let sectionview = sectionarray[section]
        
        return sectionview.isExpand ? sectionview.datasource.count : 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: EUCHOSECONTACTSCELL) as? EUCommunityMemberCell) ?? EUCommunityMemberCell()
        cell.viewmodel = sectionarray[indexPath.section].datasource[indexPath.row]
        cell.selectionStyle = .none
        if ((tableview.indexPathsForSelectedRows?.index(of: indexPath)) != nil){
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        if selectIndexArray[indexPath.section][indexPath.row] == 1{
            cell.accessoryType = .checkmark
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionview = sectionarray[section]
        sectionview.section = section
        sectionview.delegate = self
        return sectionview
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectIndexArray[indexPath.section][indexPath.row] = 1
        tableview.cellForRow(at: indexPath)?.accessoryType = .checkmark
        if (selectIndexArray[indexPath.section].min() ?? 0) == 1{
            sectionarray[indexPath.section].circleBtn.isSelected = true
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        selectIndexArray[indexPath.section][indexPath.row] = 0
        tableview.cellForRow(at: indexPath)?.accessoryType = .none
        sectionarray[indexPath.section].circleBtn.isSelected = false
    }
    
    
    
    func foldSectionViewdidClicked(sectionView: FoldSectionView, isExpand: Bool) {
        
        tableview.reloadSections(IndexSet(integer: sectionView.section), with: .automatic)
    }
    
    func foldSectionViewSelectButtondidClicked(sectionView: FoldSectionView, isSelected: Bool) {
        
        let replace = isSelected ? 1 : 0
        for (index,_) in selectIndexArray[sectionView.section].enumerated(){
            selectIndexArray[sectionView.section][index] = replace
        }
        tableview.reloadSections(IndexSet(integer: sectionView.section), with: .automatic)
        
    }

}

// MARK: - 监听相关方法
extension EUChoseContactsController{
    
    @objc fileprivate func sendNotification(){
        
    }
    
}








// MARK : -头部视图类
protocol FoldSectionViewDelegate {
    
    func foldSectionViewdidClicked(sectionView:FoldSectionView,isExpand:Bool)
    
    func foldSectionViewSelectButtondidClicked(sectionView:FoldSectionView,isSelected:Bool)
    
}
class FoldSectionView: UIView {
    
    var titleLabel = UILabel()
    
    let circleBtn = UIButton(frame: CGRect(x: UIScreen.main.bounds.width - 36, y: 0, width: 24, height: 24))
    
    var section:Int = 0
    
    var isExpand:Bool = false
    
    var indicatorview = UIImageView()
    
    lazy var datasource = [UserinfoViewModel]()
    
    var delegate:FoldSectionViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        indicatorview.image = UIImage(named: "cm_contactsindicator")
        indicatorview.frame.size = CGSize(width: 12, height: 12)
        indicatorview.frame.origin.x = 18
        indicatorview.center.y = center.y
        addSubview(indicatorview)
        
        titleLabel.frame = CGRect(x: 50, y: 15, width: 100, height: 15)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        titleLabel.textColor = UIColor.black
        addSubview(titleLabel)
        
        circleBtn.setImage(UIImage(named: "cm_circle"), for: .normal)
        circleBtn.setImage(UIImage(named: "cm_circleselect"), for: .selected)
        circleBtn.addTarget(nil, action: #selector(didClickSelectAllButton(btn:)), for: .touchUpInside)
        addSubview(circleBtn)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didClickSectionView))
        addGestureRecognizer(tap)
        
        
        
    }
    
    @objc private func didClickSectionView(){
        
        isExpand = !isExpand
        if isExpand{
            UIView.animate(withDuration: 0.25, animations: {
                self.indicatorview.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI/2.0))
            })
        }else{
            UIView.animate(withDuration: 0.25, animations: {
                self.indicatorview.transform = CGAffineTransform.identity
            })
        }
        delegate?.foldSectionViewdidClicked(sectionView: self, isExpand: isExpand)
        
    }
    
    @objc private func didClickSelectAllButton(btn:UIButton){
        
        btn.isSelected = !btn.isSelected
        delegate?.foldSectionViewSelectButtondidClicked(sectionView: self, isSelected: btn.isSelected)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
