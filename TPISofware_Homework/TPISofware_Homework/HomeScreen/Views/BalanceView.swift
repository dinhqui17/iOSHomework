//
//  BalanceView.swift
//  TPISofware_Homework
//
//  Created by vfa on 17/05/2024.
//

import UIKit
import Combine

class BalanceView: UIView {
    
    @IBOutlet weak var showHideBtn: UIButton!
    @IBOutlet weak var khrValueLabel: UILabel!
    @IBOutlet weak var usdValueLabel: UILabel!
    @IBOutlet var contentView: UIView!
    
    private let viewModel = HomeViewModel()
    
    var totalUSD: Double = 0.0
    var totalKHR: Double = 0.0
    var hiddenSymbols: String = "******"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }
    
    private func setUpView() {
        Bundle.main.loadNibNamed("BalanceView", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        getUsdBalance1()
        getKhrBalance1()
        setUpShowHideBalance()
    }
    
    private func getUsdBalance1() {
        // Get USD Savings 1
        viewModel.getBalance(endpoint: .usdSavings1, type: .Saving)
            .catch{ _ in Just(0.0) }
            .sink(receiveValue: { [self] value in
                totalUSD += value
                usdValueLabel.text = String(totalUSD)
            })
            .store(in: &viewModel.subscriptions)
        
        // Get USD Fixed 1
        viewModel.getBalance(endpoint: .usdFixedDeposited1, type: .Fixed)
            .catch{ _ in Just(0.0) }
            .sink(receiveValue: { [self] value in
                totalUSD += value
                usdValueLabel.text = String(totalUSD)
            })
            .store(in: &viewModel.subscriptions)
        
        // Get USD Digital 1
        viewModel.getBalance(endpoint: .usdDigital1, type: .Digital)
            .catch{ _ in Just(0.0) }
            .sink(receiveValue: { [self] value in
                totalUSD += value
                usdValueLabel.text = String(totalUSD)
            })
            .store(in: &viewModel.subscriptions)
    }
    
    private func getKhrBalance1() {
        // Get KHR Savings 1
        viewModel.getBalance(endpoint: .khrSavings1, type: .Saving)
            .catch{ _ in Just(0.0) }
            .sink(receiveValue: { [self] value in
                totalKHR += value
                khrValueLabel.text = String(totalKHR)
            })
            .store(in: &viewModel.subscriptions)
        
        // Get KHR Fixed 1
        viewModel.getBalance(endpoint: .khrFixedDeposited1, type: .Fixed)
            .catch{ _ in Just(0.0) }
            .sink(receiveValue: { [self] value in
                totalKHR += value
                khrValueLabel.text = String(totalKHR)
            })
            .store(in: &viewModel.subscriptions)
        
        // Get KHR Digital 1
        viewModel.getBalance(endpoint: .khrDigital1, type: .Digital)
            .catch{ _ in Just(0.0) }
            .sink(receiveValue: { [self] value in
                totalKHR += value
                khrValueLabel.text = String(totalKHR)
            })
            .store(in: &viewModel.subscriptions)
    }
    
    private func setUpShowHideBalance() {
        viewModel.$isShowBalance
            .sink(receiveValue: { [self] isShow in
                usdValueLabel.text = isShow ? String(totalUSD) : hiddenSymbols
                khrValueLabel.text = isShow ? String(totalKHR) : hiddenSymbols
                showHideBtn.setImage(isShow ? UIImage(named: "iconEye01On") : UIImage(named: "iconEye02Off"), for: .normal)
                
            })
            .store(in: &viewModel.subscriptions)
    }
    
    @IBAction func showHideBtn(_ sender: Any) {
        viewModel.isShowBalance = !viewModel.isShowBalance
    }
}
