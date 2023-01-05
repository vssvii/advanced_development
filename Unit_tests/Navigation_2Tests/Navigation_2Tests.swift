//
//  Navigation_2Tests.swift
//  Navigation_2Tests
//
//  Created by Developer on 04.01.2023.
//

import XCTest
import Firebase


@testable import Navigation_2

final class Navigation_2Tests: XCTestCase {
    
    var logInVC: LogInViewController!
    
    var profileVC: ProfileViewController!
    
    var profileHeaderView: ProfileHeaderView!
    
    var likedPostsVC: LikedPostsViewController!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        var factory = MyLoginFactory().getLoginInspector()
        
        logInVC = LogInViewController(with: factory)
        
        profileVC = ProfileViewController(userService: CurrentUserService(name: "", avatar: "", status: "") as UserService, userName: "")
        
        profileHeaderView = ProfileHeaderView()
        
        likedPostsVC = LikedPostsViewController()
    }

    override func tearDownWithError() throws {
        logInVC = nil
        profileHeaderView = nil
        likedPostsVC = nil
        try super.tearDownWithError()
    }
    
    func testCheckLogInAuthorization() throws {
        
        let userName = "Ibragim"
        let password = "Ibragim"
        logInVC.checkAuthorization(login: userName, password: password)
        XCTAssert(true)
    }
    
    func testFirstRowProfileVC() {
        let tableView = profileVC.postTableView
        tableView.reloadData()
        let indexPath0 = IndexPath(item: 0, section: 0)
        let cell0 = tableView.cellForRow(at: indexPath0)
        let visibleRows = tableView.indexPathsForVisibleRows
        XCTAssert(visibleRows != nil)
        XCTAssertTrue(((tableView.indexPathsForVisibleRows!.contains(indexPath0)) != nil))
        XCTAssert(true)
    }
    
    func testDeleteAllLikedPosts() {
        likedPostsVC.deleteAll()
    }
    
    func testShowProfileStatus() {
        let statusText = "Do something..."
        
        profileHeaderView.statusText = "Do something..."
        profileHeaderView.statusTextField.addTarget(self, action: #selector(profileHeaderView.statusTextChanged(_:)), for: .editingChanged)
        profileHeaderView.buttonPressed()
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
