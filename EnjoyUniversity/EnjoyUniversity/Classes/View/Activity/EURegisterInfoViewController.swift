//
//  EURegisterInfoViewController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/13.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EURegisterInfoViewController: EUBaseViewController {
    
    /// 活动参与者数据源
    var participatorlist:UserInfoListViewModel?
    
    /// 用于更改上层数据
    var activityviewmodel:ActivityViewModel?
    
    
    /// 活动 ID
    var avid = 0
    
    /// 签到码
    var code = 0
    
    /// 活动名称
    var activityName = ""
    /// 未签到人数
    let notfinishednum = UILabel(frame: CGRect(x: 131, y: 51, width: 80, height: 12))
    
    /// 已签到人数
    let finishednum = UILabel(frame: CGRect(x: 25, y: 51, width: 80, height: 12))


    
    let REGISTERCELL = "REGISTERCELL"

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.init(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        navitem.title = "签到详情"
        let rightBtn = UIBarButtonItem(title: "结束", style: .plain, target: nil, action: #selector(didClickFinishActivityBtn))
        navitem.rightBarButtonItem = rightBtn
        tableview.tableFooterView = UIView()
        tableview.register(EUActivityMemberCell.self, forCellReuseIdentifier: REGISTERCELL)
        setupTableHeadView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func loadData() {
        
        guard let participatorlist = participatorlist else {
            return
        }
        
        participatorlist.loadWaitingRegisterMemberInfoList(avid: avid) { (isSuccess, hasMember) in
            
            if !isSuccess{
                SwiftyProgressHUD.showFaildHUD(text: "网络异常", duration: 1)
                return
            }
            var num = participatorlist.activityParticipatorList.count - participatorlist.waitingRegisterParticipatorList.count
            num = num < 0 ? 0 : num
            self.tableview.reloadData()
            self.notfinishednum.text = "未签到:\(participatorlist.waitingRegisterParticipatorList.count)"
            self.finishednum.text = "已签到:\(num)"
            self.refreshControl?.endRefreshing()
        }
        
    }
    
}

// MARK: - UI 相关方法
extension EURegisterInfoViewController{
    
    fileprivate func setupTableHeadView(){
        
        let headview = UIView(frame: CGRect(x: 10, y: 0, width: UIScreen.main.bounds.width, height: 89))
        headview.backgroundColor = UIColor.white
        
        let registerlabel = UILabel(frame: CGRect(x: 11, y: 22, width: 150, height: 17))
        registerlabel.text = "活动签到"
        registerlabel.textColor = UIColor.init(red: 50/255, green: 50/255, blue: 50/255, alpha: 1)
        registerlabel.font = UIFont.boldSystemFont(ofSize: 16)
        headview.addSubview(registerlabel)
        
        let greenpoint = UIImageView(frame: CGRect(x: 11, y: 54, width: 11, height: 11))
        greenpoint.image = UIImage(named: "register_pointgreen")
        headview.addSubview(greenpoint)
        
        finishednum.text = "加载中"
        finishednum.font = UIFont.boldSystemFont(ofSize: 14)
        finishednum.textColor = UIColor.init(red: 70/255, green: 70/255, blue: 70/255, alpha: 1)
        finishednum.center.y = greenpoint.center.y
        headview.addSubview(finishednum)
        
        let graypoint = UIImageView(frame: CGRect(x: 116, y: 54, width: 11, height: 11))
        graypoint.image = UIImage(named: "register_pointgray")
        headview.addSubview(graypoint)
        
        notfinishednum.textColor = UIColor.init(red: 70/255, green: 70/255, blue: 70/255, alpha: 1)
        notfinishednum.font = UIFont.boldSystemFont(ofSize: 14)
        notfinishednum.text = "加载中"
        notfinishednum.center.y = greenpoint.center.y
        headview.addSubview(notfinishednum)
        
        let qrcodeBtn = UIButton(frame: CGRect(x: UIScreen.main.bounds.width - 60, y: 10, width: 50, height: 50))
        qrcodeBtn.setImage(UIImage(named: "register_qrcode"), for: .normal)
        qrcodeBtn.addTarget(nil, action: #selector(didClickShowQRCodeBtn), for: .touchUpInside)
        headview.addSubview(qrcodeBtn)
        
        let codeLabel = UILabel(frame: CGRect(x: UIScreen.main.bounds.width - 60, y: 62, width: 50, height: 12))
        codeLabel.text = "\(code)"
        codeLabel.textColor = UIColor.init(red: 50/255, green: 50/255, blue: 50/255, alpha: 1)
        codeLabel.textAlignment = .center
        headview.addSubview(codeLabel)
        
        tableview.tableHeaderView = headview
        tableview.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
        
    }
}

/// MARK: - 代理
extension EURegisterInfoViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return participatorlist?.waitingRegisterParticipatorList.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: REGISTERCELL) as? EUActivityMemberCell ?? EUActivityMemberCell()
        cell.userinfo = participatorlist?.waitingRegisterParticipatorList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "尚未签到"
    }
    
}

// MARK: - 监听方法
extension EURegisterInfoViewController{
    
    /// 结束活动
    @objc fileprivate func didClickFinishActivityBtn(){
        
        let alert = UIAlertController(title: nil, message: "确定结束本次活动吗？", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let confirm = UIAlertAction(title: "确定", style: .destructive) { (_) in
            EUNetworkManager.shared.closeActivity(avid: self.avid) { (isSuccess, hasPermission) in
                
                if !isSuccess{
                    SwiftyProgressHUD.showFaildHUD(text: "网络异常", duration: 1)
                    return
                }
                if !hasPermission{
                    SwiftyProgressHUD.showFaildHUD(text: "没有权限", duration: 1)
                    return
                }
                SwiftyProgressHUD.showSuccessHUD(duration: 1)
                self.activityviewmodel?.activitymodel.avState = -1
                _ = self.navigationController?.popViewController(animated: true)
            }
        }
        alert.addAction(cancel)
        alert.addAction(confirm)
        present(alert, animated: true, completion: nil)
        
    }
    
    /// 显示二维码
    @objc fileprivate func didClickShowQRCodeBtn(){
        
        let vc = EUShowQRCodeViewController()
        vc.activityName = activityName + "の签到"
        vc.qrLabelText = "扫一扫二维码，快速完成签到"
        vc.qrString = "www.euswag.com?avid=\(avid)&code=\(code)"
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
