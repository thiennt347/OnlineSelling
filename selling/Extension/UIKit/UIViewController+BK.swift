///
/// Project: BKCore
/// File: UIViewController+BK.swift
/// Created by DuyLe on 6/14/18.
/// Copyright © 2018-2019 Beeknights Co., Ltd. All rights reserved.
///

import UIKit

extension UIViewController {
    public func displayContentController(containerView: UIView, controller: UIViewController) {
        self.addChild(controller)
        controller
            .view.frame = containerView.bounds
        controller.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        controller.view.translatesAutoresizingMaskIntoConstraints = true
        containerView.addSubview(controller.view)
        controller.didMove(toParent: self)
    }

    public func hideContentController(controller: UIViewController) {
        controller.willMove(toParent: nil)
        controller.view.removeFromSuperview()
        controller.removeFromParent()
    }

    public func presentModalControllerWithAnimationPush(controller: UIViewController, completion: (() -> Void)?) {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.fillMode = CAMediaTimingFillMode.both
        controller.modalPresentationStyle = .fullScreen
        self.view.window!.backgroundColor = UIColor.clear
        self.view.window!.layer.add(transition, forKey: kCATransition)
        self.present(controller, animated: false, completion: completion)
    }

    public func dismissModalControllerWithAnimationPop(controller: UIViewController, completion: (() -> Void)?) {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        transition.fillMode = CAMediaTimingFillMode.both
        controller.view.window!.backgroundColor = UIColor.clear
        controller.view.window!.layer.add(transition, forKey: kCATransition)
        self.dismiss(animated: false, completion: completion)
    }

    public func showDialog(title: String = String.empty, message: String, buttonTitle btnTitle: String = String.empty) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: btnTitle, style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }

    public func showOpenSettingDialog(title: String = String.empty, message: String, confirmCompletion completion: (() -> Void)?) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: BKConfiguration.instance.alertCancelBtn, style: .cancel, handler: nil))
        alertVC.addAction(UIAlertAction(title: BKConfiguration.instance.alertOkBtn, style: .default, handler: { _ in
            completion?()
        }))
        self.present(alertVC, animated: true, completion: nil)
    }

    public func showYesNoConfirmationDialog(title: String = String.empty, message: String, confirmCompletion completion: (() -> Void)?) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        alertVC.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
            completion?()
        }))
        self.present(alertVC, animated: true, completion: nil)
    }

    // show alert with text field
    public func showAlertWithTextField(title: String? = nil, message: String? = nil, btnTitleOK: String = BKConfiguration.instance.alertOkBtn, btnTitleCancel: String = BKConfiguration.instance.alertCancelBtn, placeholder: String? = nil, completion: ((_ field: String) -> Swift.Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: btnTitleOK, style: .default, handler: { _ in
            if let field = alert.textFields?.first {
                // handler
                completion?(field.text!)
            }
        })
        alert.addAction(OKAction)
        alert.preferredAction = OKAction
        alert.addAction(UIAlertAction(title: btnTitleCancel, style: .cancel) { _ in })
        alert.addTextField { textField in
            textField.placeholder = placeholder
        }
        self.present(alert, animated: true, completion: nil)
    }

    public func showAlert(message: String) {
        self.showDialog(title: BKConfiguration.instance.appName, message: message, buttonTitle: BKConfiguration.instance.alertOkBtn)
    }

    public func showError(message: String) {
        self.showDialog(title: BKConfiguration.instance.appName, message: message, buttonTitle: BKConfiguration.instance.alertOkBtn)
    }

    public func showError(error: NSError) {
        let msg = error.localizedFailureReason ?? error.localizedDescription
        self.showDialog(title: BKConfiguration.instance.appName, message: msg, buttonTitle: BKConfiguration.instance.alertOkBtn)
    }

    public func addMenuButton(animated: Bool, with image: UIImage) {
        // self.navigationController?.navigationBar.tintColor = Constants.Colors.textColor
        let menuBtn = UIBarButtonItem(image: image.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(btnMenuTapped(_:)))
        self.navigationItem.setLeftBarButtonItems([menuBtn], animated: animated)
    }

    public func addBackButton(animated: Bool, with image: UIImage) {
        let backBtn = UIBarButtonItem(image: image.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(btnBackTapped(_:)))
        self.navigationItem.setLeftBarButtonItems([backBtn], animated: animated)
    }

    public func addRightNavigation(animated: Bool, with image: UIImage) {
        let rightBtn = UIBarButtonItem(image: image.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(btnRightTapped(_:)))
        self.navigationItem.setRightBarButtonItems([rightBtn], animated: animated)
    }

    @objc open func btnBackTapped(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }

    @objc open func btnMenuTapped(_ sender: Any?) {

    }

    @objc open func btnRightTapped(_ sender: Any?) {

    }

    public func transitStackItem(view: UIView, isHidden: Bool) {
        if view.isHidden != isHidden {
            view.alpha = 0
            UIView.animate(withDuration: 0.3, animations: {
                view.isHidden = isHidden
            }, completion: { _ in
                    view.alpha = 1
                })
        }
    }
}
