//
//  ViewController.swift
//  RxSwiftTest
//
//  Created by Jaap Mengers on 14/03/2017.
//  Copyright © 2017 Jaap Mengers. All rights reserved.
//

import UIKit
import RxSwift
import Alamofire
import RxAlamofire

class ViewController: UIViewController {
  
  let refreshSubject = PublishSubject<Observable<String>>()
  
  let loadQuick = request(.get, "http://localhost:3000/quick")
    .observeOn(MainScheduler.instance)
    .flatMap {
      $0.rx.string()
  }
  
  let loadSlow = request(.get, "http://localhost:3000/slow")
    .observeOn(MainScheduler.instance)
    .flatMap {
      $0.rx.string()
    }

  func refresh(_ fn: Observable<String>) {
    refreshSubject.onNext(fn)
  }

  @IBAction func slowButtonTouched(_ sender: Any) {
    refresh(loadSlow)
  }
  
  @IBAction func quickButtonTouched(_ sender: Any) {
    refresh(loadQuick)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    let _ = refreshSubject
      .switchLatest()
      .subscribe { res in
          print("Res \(res)")
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

