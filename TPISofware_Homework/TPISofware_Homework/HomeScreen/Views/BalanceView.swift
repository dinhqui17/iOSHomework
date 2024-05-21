//
//  BalanceView1.swift
//  TPISofware_Homework
//
//  Created by vfa on 21/05/2024.
//

import UIKit
import Combine

class BalanceView: UIView {
    @IBOutlet weak var khrShimmerView: ShimmerView!
    @IBOutlet weak var usdShimmerView: ShimmerView!
    @IBOutlet private weak var showHideBtn: UIButton!
    @IBOutlet private weak var khrValueLabel: UILabel!

    @IBOutlet weak var usdValueLabel: UILabel!
    @IBOutlet private weak var contentView: UIView!
    
    weak var viewModel: BalanceViewModel! {
        didSet {
            if let viewModel = viewModel {
                bindingViewModel(viewModel: viewModel)
            } else {
                disposeBag.removeAll()
            }
            
        }
    }

    private var disposeBag = Set<AnyCancellable>()
    
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
        }
    
     func bindingViewModel(viewModel: BalanceViewModel) {
        
        Publishers.CombineLatest(viewModel.$isShowBalance, viewModel.$usdBalanceValue.map({"\($0)"}))
            .receive(on: DispatchQueue.main)
            .map({(isShowBalance, usdBalanceValue) -> String in
                isShowBalance ? usdBalanceValue : "*******"
            })
            .assign(to: \.text, on: self.usdValueLabel)
            .store(in: &disposeBag)
        
        Publishers.CombineLatest(viewModel.$isShowBalance, viewModel.$khrBalanceValue.map({"\($0)"}))
            .receive(on: DispatchQueue.main)
            .map({(isShowBalance, khrBalanceValue) -> String in
                isShowBalance ? khrBalanceValue : "*******"
            })
            .assign(to: \.text, on: self.khrValueLabel)
            .store(in: &disposeBag)
        
         // Use debound for optimize UI/UX
        viewModel.$isLoading.debounce(for: 3, scheduler: DispatchQueue.main)
            .sink { [weak self] isLoading in
                self?.showLoading(isLoading: isLoading)
            }
            .store(in: &disposeBag)
        
        viewModel.$error.receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                if let error = error {
                    self?.showError(error: error)
                }
            }
            .store(in: &disposeBag)
    }
    

    @IBAction func touchUpInsideShowBalanceButton(_ sender: Any) {
        viewModel.toggleShowBalance()
    }
    
    private func showLoading(isLoading: Bool) {
        khrShimmerView.isHidden = !isLoading
        usdShimmerView.isHidden = !isLoading
        print(Self.self,#function,isLoading)
    }
    
    private func showError(error: Error) {
        print(Self.self,#function,error.localizedDescription)
    }
}
