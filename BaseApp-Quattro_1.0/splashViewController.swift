//
//  splashViewController.swift
//  BaseApp-Quattro_1.0
//
//  Created by Josafat Vargas Origuela on 15/10/14.
//  Copyright (c) 2014 Brand Quest S.A. C.V. All rights reserved.
//

import UIKit
import MediaPlayer

class splash: UIViewController {
    
    var moviePlayer:MPMoviePlayerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        createVideoSplash()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func createVideoSplash(){
        // Notification video status
        // Notifica Cuando acaba el video
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("finaliceVideo"), name: MPMoviePlayerPlaybackDidFinishNotification, object: moviePlayer)
        // Add Tap Video Sender
        var tapVideo:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "finaliceVideo")
        

        // Crate Video Load
            // Video Path
        let pathVideo = NSBundle.mainBundle().pathForResource("splash_dqm", ofType: "m4v")
        var urlvideo:NSURL = NSURL(fileURLWithPath: pathVideo!, isDirectory: true)!
        
            // Show Video in View
        moviePlayer = MPMoviePlayerController(contentURL: urlvideo)
        moviePlayer.view.frame = view.bounds
        view.addSubview(moviePlayer.view)
        moviePlayer.fullscreen = true
        moviePlayer.controlStyle = MPMovieControlStyle.None
        
        var viewButtonVideo:UIView = UIView(frame: moviePlayer.view.bounds)
        viewButtonVideo.addGestureRecognizer(tapVideo)
        moviePlayer.view.addSubview(viewButtonVideo)
    }
    func createVideoSplashB(){
        // Create Splas B
        // Create Back Splash
        var back_splash = UIImageView() as UIImageView
        back_splash.frame = view.bounds
        back_splash.image = UIImage(named: "back_splash.jpg")
        back_splash.backgroundColor = .blackColor()
        back_splash.contentMode = UIViewContentMode.ScaleAspectFill
        view.addSubview(back_splash)
        
        // Frame Logo Splash
        var frameLogo_splash = CGRectMake(view.frame.width / 2, view.frame.height / 2, view.frame.width - 40, 200)
        frameLogo_splash.origin.x = frameLogo_splash.origin.x - (frameLogo_splash.size.width / 2)
        frameLogo_splash.origin.y = frameLogo_splash.origin.y - (frameLogo_splash.size.height / 2)
        
        // Create Logo Splash
        var logo_splash = UIImageView() as UIImageView
        logo_splash.frame = frameLogo_splash
        logo_splash.backgroundColor = .clearColor()
        logo_splash.image = UIImage(named: "logo_general.png")
        logo_splash.contentMode = UIViewContentMode.ScaleAspectFit
        view.addSubview(logo_splash)
        
        back_splash.alpha = 0.0
        logo_splash.alpha = 0.0
        
        // Animate Splash B
        UIView.animateWithDuration(0.45, animations: {back_splash.alpha = 1})
        UIView.animateWithDuration(0.55, delay: 0.45, options: UIViewAnimationOptions.CurveEaseOut, animations: {logo_splash.alpha = 1}, completion: {finished in
            if (finished){
                NSTimer.scheduledTimerWithTimeInterval(4, target: self, selector: Selector("finaliceSplashB"), userInfo: nil, repeats: false)
                // Add Tap Splas B Sender
                var tapSplashB:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "finaliceSplashB")
                self.view.addGestureRecognizer(tapSplashB)
            }
        })
    }
    var boolVideo = 0 // Bool Plus Video Notifica 0!
    func finaliceVideo(){
        boolVideo = boolVideo + 1
        if(boolVideo == 1){
            moviePlayer.stop()
            moviePlayer.view.removeFromSuperview()
            moviePlayer = nil
            createVideoSplashB()
        }
    }
    var boolSplashB = 0 // Bool Plus Video Notifica 0!
    func finaliceSplashB(){
        boolSplashB = boolSplashB + 1
        if(boolSplashB == 1){
            performSegueWithIdentifier("home", sender: self)
        }
    }
    
}