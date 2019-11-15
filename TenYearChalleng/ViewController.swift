//
//  ViewController.swift
//  TenYearChalleng
//
//  Created by 林伯翰 on 2019/11/15.
//  Copyright © 2019 Bruce Lin. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var autoPlaySwitch: UISwitch!
    
    @IBOutlet weak var backwardBtn: UIButton!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var forwardBtn: UIButton!
    @IBOutlet weak var songNameTextView: UITextView!
    
    let dateFormatter = DateFormatter()
    var dateString:String = ""
    var timer:Timer?
    let dateImageView = ["20101225","20111217","20111224","20121007","20130410","20140115","20140427","20150301","20160818","20170909","20181010","20190113"]
    var dateImageViewNum = 0
    let songAry = ["LittleSoldier","DrinkTea","Aesthetic","9277"]
    var songNum = 0
    var songPlayer = AVPlayer()
    var playerItem:AVPlayerItem?
    var songLooper: AVPlayerLooper?
    var time:CMTime?
    var isPlaying = false  //music play?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.locale = Locale(identifier: "zh_TW")
        dateFormatter.dateFormat = "yyyy/MM/dd"
        pictureView.image = UIImage(named: dateImageView[dateImageViewNum])
        autoPlaySwitch.isOn = false
        initPlaySong()
        
        // Do any additional setup after loading the view.
    }
    func initPlaySong(){
        let nowSong = songAry[songNum]
        songNameTextView.text = songAry[songNum]
        let sound = Bundle.main.path(forResource: nowSong, ofType: "mp3", inDirectory: "music")
        playerItem = AVPlayerItem(url: URL(fileURLWithPath: sound!))
        songPlayer = AVPlayer(playerItem: playerItem!)
        }
    
    func autoPlayImage(){
        if dateImageViewNum >= dateImageView.count{
            dateImageViewNum = 0
            chooseImage(date: dateImageViewNum)
            pictureView.image = UIImage(named: dateImageView[dateImageViewNum])
        }else{
            chooseImage(date: dateImageViewNum)
            pictureView.image = UIImage(named: dateImageView[dateImageViewNum])
        }
        dateImageViewNum += 1
    }
    func setTimer(){
        timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true){ (timer) in
            self.autoPlayImage()
            
        }
    }
    
    
    func chooseImage(date:Int){
        switch date{
        case 0:
            dateString = "2010/12/25"
        case 1:
            dateString = "2011/12/17"
        case 2:
            dateString = "2011/12/24"
        case 3:
            dateString = "2012/10/07"
        case 4:
            dateString = "2013/04/10"
        case 5:
            dateString = "2014/01/15"
        case 6:
            dateString = "2014/04/27"
        case 7:
            dateString = "2015/03/01"
        case 8:
            dateString = "2016/08/18"
        case 9:
            dateString = "2017/09/09"
        case 10:
            dateString = "2018/10/10"
        default:
            dateString = "2019/01/13"
        }
        //modified datePicker date
        let Pdate = dateFormatter.date(from: dateString)
        datePicker.date = Pdate!
    }
    override func viewDidDisappear(_ animated: Bool) {
        timer?.invalidate()
    }
    
    @IBAction func datePickerChange(_ sender: UIDatePicker) {
    }

    @IBAction func dateSwitchChange(_ sender: UISwitch) {
        if sender.isOn{
            setTimer()
            songPlayer.play()
            playBtn.setImage(UIImage(systemName: "pause.fill"), for: UIControl.State.normal)
            isPlaying = true
        }else{
            songPlayer.pause()
            playBtn.setImage(UIImage(systemName: "play.fill"), for: UIControl.State.normal)
            isPlaying = false
            timer?.invalidate()
        }
    }
    
    @IBAction func playSongBtn(_ sender: UIButton) {
        if isPlaying == false{
            playBtn.setImage(UIImage(systemName: "pause.fill"), for: UIControl.State.normal)
            isPlaying = true
            songPlayer.play()
            
        }else{
            playBtn.setImage(UIImage(systemName: "play.fill"), for: UIControl.State.normal)
            isPlaying = false
            songPlayer.pause()
        }
        
    }
    
    @IBAction func previousSongBtn(_ sender: Any) {
        if songNum == 0{
            songNum = songAry.count-1
        }else{
            songNum -= 1
        }
        initPlaySong()
        playBtn.setImage(UIImage(systemName: "pause.fill"), for: UIControl.State.normal)
        isPlaying = true
        songPlayer.play()
    }
    @IBAction func nextSongBtn(_ sender: Any) {
        if songNum == songAry.count-1{
            songNum = 0
        }else{
            songNum += 1
        }
        initPlaySong()
        playBtn.setImage(UIImage(systemName: "pause.fill"), for: UIControl.State.normal)
        isPlaying = true
        songPlayer.play()
    }
}


