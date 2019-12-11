//: [Previous](@previous)

import Foundation

var str = "Hello, playground"
/*
## 实现步骤
1. 申请空间, 使其大小为两个**已经排序序列**之和, 用来存放合并后的序列
2. 设定两个指针, 最初位置分别为两个一级排序序列的起始位置
3. 比较两个指针所指元素, 选择相对小的元素放入合并空间,并移动指针到下一位置
4. 重复 3,直到某一指针达到序列尾
5. 将另一个序列剩下的所有元素直接复制到合并序列尾
*/


func mergeSort(_ array: [Int]) -> [Int] {
    let count = array.count
    guard count > 1 else { return array }
    let middleIndex = count / 2
    let left = Array(array[0..<middleIndex])
    let right = Array(array[middleIndex..<count])
    return merge(mergeSort(left), mergeSort(right))
}

func merge(_ left: [Int], _ right: [Int]) -> [Int] {
    var result = [Int]()
    var leftArr = left
    var rightArr = right
    while !leftArr.isEmpty && !rightArr.isEmpty {
        if leftArr[0] <= rightArr[0] {
            result.append(leftArr[0])
            leftArr.removeFirst()
        } else {
            result.append(rightArr[0])
            rightArr.removeFirst()
        }
    }
    if !leftArr.isEmpty {
        result.append(contentsOf: leftArr)
    }

    if !rightArr.isEmpty {
        result.append(contentsOf: rightArr)
    }
    return result
}

let m = mergeSort([3, 2, 4, 5, 3, 8, 6, 7, 9])


//: [Next](@next)
