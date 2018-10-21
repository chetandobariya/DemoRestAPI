//
//  UtilityHelper.swift
//  DemoRest
//
//  Created by Dobariya, Chetankumar || mytheresa.com on 20.10.18.
//  Copyright © 2018 Chetan Dobariya. All rights reserved.
//

import UIKit

// MARK: - Global funcs


/// Load viewController from Storyboard for given storyboardId
///
/// - Parameters:
///   - id: storyboardId of viewcontroller
///   - storyboardName: default is "Main"
/// - Returns: instance of UIViewController
func viewController(forStoryboardId id: String, storyboardName: String = "Main") -> UIViewController
{
    let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
    return storyboard.instantiateViewController(withIdentifier: id)
}


/// Load viewController from Storyboard for given viewcontroller class
/// - storyboardId must be the class-name
/// - Parameters:
///   - c: viewcontroller class
///   - storyboardName: default is "Main"
/// - Returns: instance of UIViewController
func viewController(fromStoryboard c: AnyClass, storyboardName: String = "Main") -> UIViewController
{
    return viewController(forStoryboardId: string(fromClass: c), storyboardName: storyboardName)
}


/// duplicate of viewController(fromStoryboard:) to avoid hockeyApp problems in Appdelegate
func af_viewController(fromStoryboard c: AnyClass, storyboardName: String = "Main") -> UIViewController
{
    return viewController(forStoryboardId: string(fromClass: c), storyboardName: storyboardName)
}


/// Dispatch delay and process closure after given timeinterval
///
/// - Parameters:
///   - seconds: timeinterval
///   - completion: completion closure processed after timerinterval
func delay(_ seconds: TimeInterval, dispatchQueue: DispatchQueue = .main, completion: @escaping () -> Void)
{
    dispatchQueue.asyncAfter(deadline: .now() + seconds) {
        
        completion()
    }
}


/// Shorthand for NSLocalizedString
///
/// - Parameter string: localization key
/// - Returns: localized string
func localize(_ string: String) -> String
{
    let localizedString = NSLocalizedString(string, comment: "")
    return localizedString
}



/// Get class name as String
///
/// - Parameter c: class
/// - Returns: string
func string(fromClass c: AnyClass) -> String
{
    let nameSpaceClassName = NSStringFromClass(c)
    let className = nameSpaceClassName.components(separatedBy: ".").last! as String
    return className
}


// MARK: - Extensions


// MARK: - UIDevice

extension UIDevice
{
    enum ScreenSize: Int // width + height
    {
        case unknown = 0
        case iPhone3_5Inch = 800 //320 + 480
        case iPhone4Inch = 888 //320 + 568
        case iPhone4_7Inch = 1042 //375 + 667
        case iPhone5_5Inch = 1150 //414 + 736
        case iPad = 1792 //768 + 1024
        case iPadLarge = 2390 //1024 + 1366
    }
    
    
    class func screenSize() -> ScreenSize
    {
        if let size = ScreenSize(rawValue: Int(UIScreen.main.bounds.size.width + UIScreen.main.bounds.size.height))
        {
            return size
        }
        
        return .unknown
    }
    
    
    class func isPad() -> Bool
    {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    
    class func isPhone() -> Bool
    {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    
    class func isLandScape()->Bool{
        
        if UIDevice.current.orientation.isLandscape{
            return true
        }
        return false
    }
    
    class func forceOrientation(_ orientation: UIInterfaceOrientation)
    {
        if UIApplication.shared.statusBarOrientation != orientation
        {
            UIDevice.current.setValue(orientation.rawValue, forKey: "orientation")
        }
    }
    
}


// MARK: - Data

extension Data
{
    /// Convert push deviceToken to readable String
    ///
    /// - Returns: string
    func convertDeviceTokenToString() -> String
    {
        var token: String = ""
        for i in 0..<self.count
        {
            token += String(format: "%02.2hhx", self[i] as CVarArg)
        }
        
        return token
    }
}
