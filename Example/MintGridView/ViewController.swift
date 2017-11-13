//
//  ViewController.swift
//  MintGridView
//
//  Created by jihq on 11/07/2017.
//  Copyright (c) 2017 jihq. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var menus = [String]()
    var funcs = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Demo"
        view.backgroundColor = UIColor.white
        view.addSubview(tableView)
        
        menus.append("普通")
        funcs.append("normal")
        
        menus.append("红点")
        funcs.append("hotCount")
        
        menus.append("更新")
        funcs.append("update")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    //MARK: -
    //MARK: action
    @objc func normal() {
        let vc = NormalViewController()
        vc.navigationItem.title = "普通"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func hotCount() {
        let vc = HotCountViewController()
        vc.navigationItem.title = "红点"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func update() {
        let vc = UpdateViewController()
        vc.navigationItem.title = "更新"
        navigationController?.pushViewController(vc, animated: true)
    }

    lazy var tableView: UITableView = {
        let tv = UITableView.init(frame: CGRect(), style: .plain)
        tv.dataSource = self
        tv.delegate = self
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tv
    }()
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = menus[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.perform(Selector(funcs[indexPath.row]))
    }
}

