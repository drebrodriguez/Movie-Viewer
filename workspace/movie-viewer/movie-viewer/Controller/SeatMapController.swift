//
//  SeatMapController.swift
//  movie-viewer
//
//  Created by Dreb Rodriguez on 16/06/2018.
//  Copyright © 2018 Dreb Rodriguez. All rights reserved.
//

import UIKit

class SeatMapController: UIViewController {
    
    var movie: Movie?, selectedDate: String?, selectedCinema: String?, selectedTime: String?
    let sampleDates = ["Apr 05, Wed","Apr 06, Thu"]
    let sampleCinema = ["Cinema 3", "Cinema 4", "Cinema 5"]
    let sampleTime = ["10:30 AM", "12:00 PM"]
    let samplePrice = 1234
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.Custom.edgarWhite
        setupViews()
    }
    
    let theaterLabel: UILabel = {
        let lb = UILabel()
        return lb
    }()
    
    lazy var dateLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Date"
        lb.font = UIFont.boldSystemFont(ofSize: 16)
        lb.textAlignment = .center
        lb.backgroundColor = UIColor.Custom.freeSpeechBlue
        lb.textColor = .white
        lb.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        lb.isUserInteractionEnabled = true
        return lb
    }()
    
    lazy var cinemaLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Cinema"
        lb.font = UIFont.boldSystemFont(ofSize: 16)
        lb.textAlignment = .center
        lb.backgroundColor = UIColor.Custom.freeSpeechBlue
        lb.textColor = .white
        lb.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        lb.isUserInteractionEnabled = true
        return lb
    }()
    
    lazy var timeLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Time"
        lb.font = UIFont.boldSystemFont(ofSize: 16)
        lb.textAlignment = .center
        lb.backgroundColor = UIColor.Custom.freeSpeechBlue
        lb.textColor = .white
        lb.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        lb.isUserInteractionEnabled = true
        return lb
    }()
    
    let scheduleStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.spacing = 1
        return sv
    }()
    
    let schedulePickerView: UIPickerView = {
        let pv = UIPickerView()
        pv.isHidden = true
        pv.backgroundColor = UIColor.Custom.edgarWhite
        return pv
    }()
    
    
    let iconBounds = CGRect(x: 0, y: -5, width: 20, height: 20)
    
    lazy var availableLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .right
        lb.textColor = .lightGray
        lb.font = UIFont.systemFont(ofSize: 14)
        
        let attributedText = NSMutableAttributedString()
        let icon = NSTextAttachment()
        icon.image = UIImage(named: "available")
        icon.bounds = iconBounds
        attributedText.append(NSAttributedString(attachment: icon))
        attributedText.append(NSAttributedString(string: "  " + "Available"))
        
        lb.attributedText = attributedText
        return lb
    }()

    lazy var reservedLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.textColor = .lightGray
        lb.font = UIFont.systemFont(ofSize: 14)
        
        let attributedText = NSMutableAttributedString()
        let icon = NSTextAttachment()
        icon.image = UIImage(named: "reserved")
        icon.bounds = iconBounds
        attributedText.append(NSAttributedString(attachment: icon))
        attributedText.append(NSAttributedString(string: "  " + "Reserved"))
        
        lb.attributedText = attributedText
        return lb
    }()
    
    lazy var selectedLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .left
        lb.textColor = .lightGray
        lb.font = UIFont.systemFont(ofSize: 14)
        
        let attributedText = NSMutableAttributedString()
        let icon = NSTextAttachment()
        icon.image = UIImage(named: "selected")
        icon.bounds = iconBounds
        attributedText.append(NSAttributedString(attachment: icon))
        attributedText.append(NSAttributedString(string: "  " + "Selected"))
        
        lb.attributedText = attributedText
        return lb
    }()
    
    let seatLabelStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = UIStackViewAlignment.center
        sv.distribution = .fillProportionally
        return sv
    }()
    
    let totalLabel: UILabel = {
        let lb = UILabel()
        lb.text = "  " + "Total"
        lb.backgroundColor = .white
        return lb
    }()
    
    let priceLabel: UILabel = {
        let lb = UILabel()
        lb.text = "1234"
        lb.textAlignment = .right
        lb.backgroundColor = .white
        return lb
    }()
    
    let totalStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        return sv
    }()
    
    fileprivate func setupPickerView() {
        schedulePickerView.delegate = self
        schedulePickerView.dataSource = self
    }
    
    @objc fileprivate func handleTap() {
        if schedulePickerView.isHidden {
            schedulePickerView.isHidden = false
            view.bringSubview(toFront: schedulePickerView)
            
            dateLabel.text = sampleDates[schedulePickerView.selectedRow(inComponent: 0)]
            cinemaLabel.text = sampleCinema[schedulePickerView.selectedRow(inComponent: 1)]
            timeLabel.text = sampleTime[schedulePickerView.selectedRow(inComponent: 2)]
        } else {
            schedulePickerView.isHidden = true
            view.sendSubview(toBack: schedulePickerView)
        }
    }
    
    fileprivate func setupTheaterLabelAttributedText() {
        guard let movieTheater = movie?.theater else { return }
        let attributedText =  NSMutableAttributedString(string: "   " + "Theater:" + "\t", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: "\(movieTheater)", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)]))
        
        theaterLabel.attributedText = attributedText
    }
    
    fileprivate func setupViews() {
        setupTheaterLabelAttributedText()
        setupPickerView()
        
        [theaterLabel, scheduleStackView, schedulePickerView, seatLabelStackView, totalStackView].forEach({view.addSubview($0)})
        
        theaterLabel.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: CGSize(width: 0, height: 40))
        
        [dateLabel, cinemaLabel, timeLabel].forEach({scheduleStackView.addArrangedSubview($0)})
        
        scheduleStackView.anchor(top: theaterLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: CGSize(width: 0, height: 40))
        
        schedulePickerView.anchor(top: scheduleStackView.bottomAnchor, leading: scheduleStackView.leadingAnchor, bottom: nil, trailing: scheduleStackView.trailingAnchor, size: CGSize(width: 0, height: 80))
        
        [availableLabel, reservedLabel, selectedLabel].forEach({seatLabelStackView.addArrangedSubview($0)})

        seatLabelStackView.anchor(top: scheduleStackView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: CGSize(width: 0, height: 40))
        
        [totalLabel, priceLabel].forEach({totalStackView.addArrangedSubview($0)})
        
        totalStackView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, size: CGSize(width: 0, height: 50))
    }
}

extension SeatMapController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return sampleDates.count
        } else if component == 1 {
            return sampleCinema.count
        } else {
            return sampleTime.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return sampleDates[row]
        } else if component == 1 {
            return sampleCinema[row]
        } else {
            return sampleTime[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedDate = sampleDates[pickerView.selectedRow(inComponent: 0)]
        selectedCinema = sampleCinema[pickerView.selectedRow(inComponent: 1)]
        selectedTime = sampleTime[pickerView.selectedRow(inComponent: 2)]
        
        dateLabel.text = selectedDate
        cinemaLabel.text = selectedCinema
        timeLabel.text = selectedTime
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel: UILabel = {
            let lb = UILabel()
            lb.adjustsFontSizeToFitWidth = true
            lb.textAlignment = .center
            return lb
        }()
        
        if component == 0 {
            pickerLabel.text = sampleDates[row]
        } else if component == 1 {
            pickerLabel.text = sampleCinema[row]
        } else {
            pickerLabel.text = sampleTime[row]
        }
        return pickerLabel
    }
    
}
