//
//  SwiftyDropdownMenu.swift
//  SwiftyDropdownMenu
//
//  Created by lip on 17/4/19.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit


protocol SwiftyDropdownMenuDelegate {
    func swiftyDropdownMenu(_ swiftyDropdownMenu: SwiftyDropdownMenu, didSelectRowAt indexPath: IndexPath)
}

class SwiftyDropdownMenu: UIView {
    
    lazy var tableview = UITableView()
    
    var buttondatasource:[[String]] = [[]]
    
    /// 当前点击的是那个button
    var datasourceIndex = 0{
        didSet{
            buttonarray[oldValue].isSelected = false
            buttonarray[datasourceIndex].isSelected = true
        }
    }
    
    /// button 数组
    lazy var buttonarray = [SwiftyTitleButton]()
    
    /// 选择框视图
    let dropdownmenu = UIView()
    
    /// 背景遮罩视图
    let shadowview = UIView()
    
    /// 判断选择框视图是否展开中
    var menuIsOnView:Bool = false
    
    /// 代理
    var delegate:SwiftyDropdownMenuDelegate?
    
    init(orgin:CGPoint,array:[[String]]) {
        super.init(frame: UIScreen.main.bounds)
        
        self.buttondatasource = array
        // 初始化界面
        dropdownmenu.frame = CGRect(origin: orgin, size: CGSize(width: UIScreen.main.bounds.width, height: 40))
        dropdownmenu.backgroundColor = UIColor.white
        shadowview.frame = CGRect(origin: orgin, size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        shadowview.backgroundColor = UIColor.black
        shadowview.alpha = 0
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

// MARK: - UI 相关方法
extension SwiftyDropdownMenu{
    
    fileprivate func setupUI(){
        

        
        let tapgasture = UITapGestureRecognizer(target: self, action: #selector(hideTableView))
        shadowview.addGestureRecognizer(tapgasture)
        
        addSubview(shadowview)
        addSubview(tableview)
        
        // 边框线
        let toplineview = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0.5))
        toplineview.backgroundColor = UIColor.init(red: 178/255, green: 178/255, blue: 178/255, alpha: 1)
        dropdownmenu.addSubview(toplineview)
        
        let bottomlineview = UIView(frame: CGRect(x: 0, y: 40, width: UIScreen.main.bounds.width, height: 0.5))
        bottomlineview.backgroundColor = UIColor.init(red: 178/255, green: 178/255, blue: 178/255, alpha: 1)
        dropdownmenu.addSubview(bottomlineview)
        
        let buttonwidth = UIScreen.main.bounds.width/CGFloat(buttondatasource.count)
        let buttonheight:CGFloat = 40
        
        // 将按钮添加到选择条上
        for (index,array) in buttondatasource.enumerated(){
            
            let btn = SwiftyTitleButton(frame: CGRect(x: CGFloat(index)*buttonwidth, y: 0, width: buttonwidth, height: buttonheight))
            btn.backgroundColor = UIColor.white
            btn.setTitle((array.first ?? "") + " ", for: .normal)
            btn.setTitleColor(UIColor.init(red: 137/255, green: 137/255, blue: 137/255, alpha: 1), for: .normal)
            btn.setTitleColor(UIColor.init(red: 246/255, green: 79/255, blue: 0, alpha: 1), for: .selected)
            btn.setImage(UIImage(named: "cm_indicatormini"), for: .normal)
            btn.setImage(UIImage(named: "cm_indicatorminiup"), for: .selected)
            btn.tag = index
            btn.addTarget(self, action: #selector(didClickMenuButton(btn:)), for: .touchUpInside)
            btn.layoutSubviews()
            buttonarray.append(btn)
            dropdownmenu.addSubview(btn)
            
            if index != 0{
                let line = UIView(frame: CGRect(x: 0, y: 10, width: 0.5, height: btn.frame.height - 20))
                line.backgroundColor = UIColor.init(red: 243/255, green: 241/255, blue: 238/255, alpha: 1)
                btn.addSubview(line)
            }
        }
        
        addSubview(dropdownmenu)
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.backgroundColor = UIColor.init(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        
        
    }
    
    @objc fileprivate func hideTableView(){
        
        menuIsOnView = false
        buttonarray[datasourceIndex].isSelected = false
        UIView.animate(withDuration: 0.25) { 
            self.tableview.frame.origin = CGPoint(x: 0, y: -self.tableview.frame.height)
            self.shadowview.alpha = 0
        }
        
    }
    
}

// MARK: - 监听相关方法
extension SwiftyDropdownMenu{
    
    @objc fileprivate func didClickMenuButton(btn:UIButton){
        
        if menuIsOnView && datasourceIndex == btn.tag{
            menuIsOnView = false
            hideTableView()
            return
        }
        
        menuIsOnView = true
        datasourceIndex = btn.tag
        let count = CGFloat(buttondatasource[datasourceIndex].count)
        tableview.frame = CGRect(x: 0, y: -count*CGFloat(44), width: UIScreen.main.bounds.width, height: count*CGFloat(44))
        tableview.reloadData()
        shadowview.alpha = 0.5
        UIView.animate(withDuration: 0.5) { 
            self.tableview.frame.origin = CGPoint(x: 0, y: self.dropdownmenu.frame.minY + self.dropdownmenu.frame.height)
        }
        
    }
    
}

// MARK: - 代理方法
extension SwiftyDropdownMenu:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return buttondatasource[datasourceIndex].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = buttondatasource[datasourceIndex][indexPath.row]
        cell.backgroundColor = UIColor.init(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let result = buttondatasource[datasourceIndex][indexPath.row]
        buttonarray[datasourceIndex].setTitle(result, for: .normal)
        let sindexpath = IndexPath(row: indexPath.row, section: datasourceIndex)
        delegate?.swiftyDropdownMenu(self, didSelectRowAt: sindexpath)
        hideTableView()
        
    }
    
}
