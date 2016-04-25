//
//  AsyncTest.swift
//  speedxSwift
//
//  Created by speedx on 16/4/25.
//  Copyright © 2016年 speedx. All rights reserved.
//

import UIKit
import Async    // 基于GCD封装的库

class AsyncTest: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 代替下面的
        Async.background {
            print("This is run on the background queue")
            }.main {
                print("This is run on the main queue , after the previous block")
        }
        // GCD 的
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {
            print("This is run on the background queue")
            dispatch_async(dispatch_get_main_queue(), {
                print("This is run on the main queue , after the previous block")
            })
        })
        
    
        // AsyncGroup sugar looks like this:
        let group = AsyncGroup()
        group.background {
            print("This is run on the background queue")
        }
        group.background {
            print("This is run on the background queue in parallel")
        }
        group.wait()
        print("Both asynchronous blocks are complete")
     
        // Custom queues:
        let customQueue1 = dispatch_queue_create("CustemQueue1", DISPATCH_QUEUE_CONCURRENT)
        let customQueue2 = dispatch_queue_create("CustemQueue2", DISPATCH_QUEUE_CONCURRENT)
        Async.customQueue(customQueue1) {
            print("Custom queue")
            }.customQueue(customQueue2){
                print("Custom queue 2")
        }
        
        // 延迟
        Async.main(after: 0.5) {
            print("Is called after 0.5 seconds")
            }.background(after: 0.4) {
                print("At least 0.4 seconds after previous block, and 0.9 after Async code is called")
        }
        
        // Cancel blocks not yet dispatched
        let block1 = Async.background {
            // Heavy work
            for i in 0...1000 {
                print("A \(i)")
            }
        }
        let block2 = block1.background {
            print("B – shouldn't be reached, since cancelled")
        }
        Async.main {
            // Cancel async to allow block1 to begin
            block1.cancel() // First block is _not_ cancelled
            block2.cancel() // Second block _is_ cancelled
        }
        
        
        
        
        
        
        
    }
    
    
    
    
}
