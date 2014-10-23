//
//  homeViewController.swift
//  BaseApp-Quattro_1.0
//
//  Created by Josafat Vargas Origuela on 21/10/14.
//  Copyright (c) 2014 Brand Quest S.A. C.V. All rights reserved.
//

import UIKit

class homeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    var scrollView = UIScrollView() as UIScrollView
    var scrollGaleriaView = UIScrollView() as UIScrollView
    let tableViewMenu = UITableView()
    var arrayMenu: [String] = ["Reservaciones", "Evaular", "Eventos", "Promociones", "Galería"]
    var logo_demo = UIImageView() as UIImageView
    var viewScrollBlur = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
    var heigthGaleriaScroll:CGFloat = 0
    var yGaleriaScroll_Logo:CGFloat = 0
    let minimunScalegallery:CGFloat = 140
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureHome()
        configureMenuTabla()
        //tableViewMenu.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarUpdateAnimation() -> UIStatusBarAnimation {
        return .Fade
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    func configureHome(){
        scrollView.frame = view.bounds
        scrollView.backgroundColor = .clearColor()
        scrollView.contentSize = CGSizeMake(scrollView.frame.width, scrollView.frame.height)
        scrollView.scrollsToTop = true
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        view.addSubview(scrollView)
        
        var widthGaleria = view.frame.width
        var heightGaleria = (Int)((widthGaleria / 4) * 3) // Format 4:3
        scrollGaleriaView.frame = CGRectMake(0, 0, view.frame.width, (CGFloat)(heightGaleria))
        view.addSubview(scrollGaleriaView)
        
        var foto_demo = UIImageView() as UIImageView
        foto_demo.frame = scrollGaleriaView.bounds
        foto_demo.image = UIImage(named: "foto_demo_quattro.jpg")
        foto_demo.contentMode = UIViewContentMode.ScaleAspectFill
        scrollGaleriaView.addSubview(foto_demo)
        
        heigthGaleriaScroll = scrollGaleriaView.frame.size.height
        
        var frameLogo_demo = CGRectMake(scrollGaleriaView.frame.width / 2, scrollGaleriaView.frame.height / 2, scrollGaleriaView.frame.width - 40, 100)
        frameLogo_demo.origin.x = frameLogo_demo.origin.x - (frameLogo_demo.size.width / 2)
        frameLogo_demo.origin.y = frameLogo_demo.origin.y - (frameLogo_demo.size.height / 2)
        
        viewScrollBlur.frame = scrollGaleriaView.bounds
        viewScrollBlur.alpha = 0.0
        scrollGaleriaView.addSubview(viewScrollBlur)
        
        logo_demo.frame = frameLogo_demo
        logo_demo.contentMode = UIViewContentMode.ScaleAspectFit
        logo_demo.image = UIImage(named: "logo_general.png")
        logo_demo.backgroundColor = .clearColor()
        logo_demo.alpha = 0.0
        scrollGaleriaView.addSubview(logo_demo)
        
        yGaleriaScroll_Logo = logo_demo.frame.origin.y
    }
    
    func configureMenuTabla(){
        var heigthRowtable:CGFloat = 80
        var frameTable = CGRectMake(scrollView.frame.width / 2, scrollGaleriaView.frame.height + 20, scrollView.frame.width - 40, (heigthRowtable * (CGFloat)(arrayMenu.count)))
        frameTable.origin.x = frameTable.origin.x - (frameTable.size.width / 2)
        
        tableViewMenu.frame = frameTable
        tableViewMenu.backgroundColor = .clearColor()
        tableViewMenu.delegate = self
        tableViewMenu.dataSource = self
        tableViewMenu.rowHeight = heigthRowtable
        tableViewMenu.scrollEnabled = false
        tableViewMenu.layer.cornerRadius = 10
        tableViewMenu.layer.masksToBounds = true
        scrollView.addSubview(tableViewMenu)

        integrateSizeInterScroll(tableViewMenu.frame.height, yElimitante: tableViewMenu.frame.origin.y, margenFinal: 20)
    }
    
    func integrateSizeInterScroll(sizeIntegrate: CGFloat, yElimitante: CGFloat, margenFinal: CGFloat){
        var sizeHeigth = (sizeIntegrate + yElimitante + margenFinal)
        var sizeScrollHeigth = scrollView.frame.height - scrollView.contentSize.height
        sizeHeigth = sizeHeigth - sizeScrollHeigth
        println(sizeHeigth)
        scrollView.contentSize = CGSizeMake(scrollView.frame.width, sizeHeigth)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMenu.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell_ : UITableViewCell? = tableViewMenu.dequeueReusableCellWithIdentifier("CELL_ID") as? UITableViewCell
        if(cell_ == nil)
        {
            cell_ = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "CELL_ID")
        }
        
        cell_!.textLabel.text = arrayMenu[indexPath.row]
        cell_!.textLabel.textColor = .whiteColor()
        cell_!.textLabel.font = UIFont.boldSystemFontOfSize(20)
        cell_!.backgroundColor = UIColor(red:  0, green: 0, blue: 0, alpha: 0.6)
        cell_!.selectedBackgroundView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        
        
        return cell_!
        
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if(scrollView == self.scrollView){
            let ScrollPointY:CGFloat = scrollView.contentOffset.y
            let heigthScrollGaleri:CGFloat = scrollGaleriaView.frame.height
            if(ScrollPointY < heigthGaleriaScroll){
                if(ScrollPointY < minimunScalegallery){
                    scrollGaleriaView.frame.size.height = heigthGaleriaScroll - ScrollPointY
                    viewScrollBlur.alpha =  ((ScrollPointY*2) / heigthGaleriaScroll)
                    logo_demo.alpha =  ((ScrollPointY*2) / heigthGaleriaScroll)
                }
                if(ScrollPointY < (yGaleriaScroll_Logo + 40)){
                    logo_demo.frame.origin.y = yGaleriaScroll_Logo - (ScrollPointY/2)
                }
                println("\(ScrollPointY) > \(heigthGaleriaScroll)")
            }
        }
    }
    
    
}

