//
//  EUSystemSettingsController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/18.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUSystemSettingsController: EUBaseViewController {
    
    let settings = ["清理缓存","消息设置"]

    override func viewDidLoad() {
        super.viewDidLoad()
        navitem.title = "系统设置"
        tableview.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

}

// MARK: - 代理
extension EUSystemSettingsController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        cell.textLabel?.text = settings[indexPath.row]
        if indexPath.row == 0{
            cell.detailTextLabel?.text = caculateCacheSize()
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0{
            
            let alert = UIAlertController(title: "清理缓存", message: nil, preferredStyle: .alert)
            let confirm = UIAlertAction(title: "确定", style: .default, handler: { (_) in
                
                if self.clearFile(){
                    SwiftyProgressHUD.showSuccessHUD(duration: 1)
                    tableView.cellForRow(at: indexPath)?.detailTextLabel?.text = self.caculateCacheSize()
                }else{
                    SwiftyProgressHUD.showFaildHUD(text: "清理失败", duration: 1)
                }
                
            })
            let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            alert.addAction(confirm)
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
            
        }
        
    }
    
}

// MARK: - 清理缓存
extension EUSystemSettingsController{
 
    
    func fileSizeAtPath(path : String) -> Float{
        
        let fileMgr = FileManager.default
        
        if fileMgr.fileExists(atPath: path) {
            
            if let fileProperty = try? fileMgr.attributesOfItem(atPath: path) {
                
                return (fileProperty[FileAttributeKey.size] as? Float) ?? 0.0
                
            }
        }
        
        return 0.0
    }
    
    
    func caculateCacheSize() -> String{
        
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!
        
        let fileMgr = FileManager.default
        var folderSize : Float = 0.0
        
        if fileMgr.fileExists(atPath: path) {
            
            if let childerFiles = fileMgr.subpaths(atPath: path){
                
                for name in childerFiles {
                    let absolutePath = path + "/\(name)"
                    
                    folderSize += self.fileSizeAtPath(path: absolutePath)
                }
            }
            
        }
        
        let cacheSize = NSString(format: "%.1f MB缓存", folderSize / 1024.0 / 1024.0 )as String
        return cacheSize
    }
    
    
    
    
    
    
    func clearFile() -> Bool{
        let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!
        let fileMgr = FileManager.default
        if let childerFiles = fileMgr.subpaths(atPath: cachePath){
            
            for name in childerFiles{
                // 拼接路径
                let path = cachePath.appendingFormat("/\(name)")
                // 判断是否可以删除
                if(FileManager.default.fileExists(atPath: path)){
                    // 删除
                    if let _ = try? FileManager.default.removeItem(atPath: path) {
                        
                        
                    }else {
                        
                    }
                }
            }
            
        }
        
        
        return true
    }
    
}
