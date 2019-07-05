//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

/*
 给出两个 非空 的链表用来表示两个非负的整数。其中，它们各自的位数是按照 逆序 的方式存储的，并且它们的每个节点只能存储 一位 数字。

 如果，我们将这两个数相加起来，则会返回一个新的链表来表示它们的和。

 您可以假设除了数字 0 之外，这两个数都不会以 0 开头。

 示例：

 输入：(2 -> 4 -> 3) + (5 -> 6 -> 4)
 输出：7 -> 0 -> 8
 原因：342 + 465 = 807

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/add-two-numbers
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

class Solution {

    /* 思路:
     * 遍历节点
     * 链表的处理, 通过新建头结点
     * 进位
     */

    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        let result = ListNode(0)

        var leftNode = l1
        var rightNode = l2
        var advanceValue = 0
        var tmpList = result

        while leftNode != nil || rightNode != nil {

            let sum = (leftNode?.val ?? 0) + (rightNode?.val ?? 0 ) + advanceValue
            advanceValue = sum / 10

            tmpList.next = ListNode(sum % 10)
            tmpList = tmpList.next!

            leftNode = leftNode?.next
            rightNode = rightNode?.next
        }

        if (advanceValue > 0) {
            tmpList.next = ListNode(advanceValue)
        }

        return result.next
    }
}

//: [Next](@next)
