//
//  EUActivityParticipatorsViewController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/11.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUActivityParticipatorsViewController: EUBaseViewController {
    
    let ACTIVITYPARTICIPATORCELL = "ACTIVITYPARTICIPATORCELL"
    
    /// 参与者数据源
    var participatorslist:UserInfoListViewModel?
    
    /// 社团 ID
    var avid:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if participatorslist?.activityParticipatorList.count == 0{
            tableview.removeFromSuperview()
            let imageview = UIImageView(image: UIImage(named: "av_nomember"))
            imageview.frame.size = CGSize(width: 50, height: 50)
            imageview.center.x = view.center.x
            imageview.center.y = view.center.y - 30
            view.addSubview(imageview)
            let label = UILabel(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: UIScreen.main.bounds.width, height: 15)))
            label.textAlignment = .center
            label.text = "暂无小伙伴参加"
            label.font = UIFont.boldSystemFont(ofSize: 13)
            label.center.y = view.center.y + 10
            view.addSubview(label)
            return
        }
        
        
        tableview.register(EUActivityMemberCell.self, forCellReuseIdentifier: ACTIVITYPARTICIPATORCELL)
        tableview.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        navitem.title = "审核"
        tableview.tableFooterView = UIView()
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}

// MARK: - 代理相关方法
extension EUActivityParticipatorsViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return participatorslist?.activityParticipatorList.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: ACTIVITYPARTICIPATORCELL) as? EUActivityMemberCell
        cell?.userinfo = participatorslist?.activityParticipatorList[indexPath.row]
        return cell ?? UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let phone = participatorslist?.activityParticipatorList[indexPath.row].model?.uid else{
            return
        }
        
        // 点击直接弹出拨打电话界面
        UIApplication.shared.open(URL(string: "telprompt://\(phone)")!, options: [:], completionHandler: nil)
    }
    
    /// 左滑删除
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    /// 定义文字
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "拒绝参加"
    }
    
    /// T 人
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        guard let uid = participatorslist?.activityParticipatorList[indexPath.row].model?.uid else{
            return
        }
        
        let alert = UIAlertController(title: nil, message: "请填写拒绝理由", preferredStyle: .alert)
        alert.addTextField { (textfield) in
            textfield.placeholder = "拒绝理由"
        }
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let confirm = UIAlertAction(title: "确定", style: .destructive) { (alertaction) in
            
            let reason = alert.textFields![0].text
            SwiftyProgressHUD.showLoadingHUD()
            EUNetworkManager.shared.removeSomeOneFromMyActovoty(uid: uid, avid: self.avid, reason: reason, completion: { (isSuccess, isRemoved) in
                SwiftyProgressHUD.hide()
                if !isSuccess{
                    SwiftyProgressHUD.showFaildHUD(text: "网络异常", duration: 1)
                    return
                }
                if !isRemoved{
                    SwiftyProgressHUD.showFaildHUD(text: "异常操作", duration: 1)
                    return
                }
                SwiftyProgressHUD.showSuccessHUD(duration: 1)
                self.participatorslist?.activityParticipatorList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            
        }
        alert.addAction(cancel)
        alert.addAction(confirm)
        
        present(alert, animated: true) { 
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
    }
    
    
}
