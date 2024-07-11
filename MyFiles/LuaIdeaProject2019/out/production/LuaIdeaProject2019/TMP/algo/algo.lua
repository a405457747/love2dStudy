
-- Author: skyAllen
-- Date: 2023-09-07 15:01:08
-- Email: 894982165@qq.com
-- Copyright: © 2023 skyAllen

--快速排序
local quickSort;
function quickSort(lst)
    if (lst:len() < 1) then
        return lst;
    else
        local pivot = lst:get(0);
        local less = lst:slice(1):filter(function(item)
            return item <= pivot
        end);
        local greater = lst:slice(1):filter(function(item)
            return item > pivot
        end);
        return quickSort(less):addSign(list { pivot }):addSign(quickSort(greater));
    end
end

local fib;
function fib(n)
    if (n <= 2) then
        return 1;
    else
        return fib(n - 2) + fib(n - 1);
    end
end

local binaryFind
function binaryFind(list, target)
    local left = 0;
    local right = list:len() - 1;
    while left <= right do
        local mid = math.floor((left + right) / 2);
        if (list:get(mid) == target) then
            return mid;
        elseif list:get(mid) > target then
            right = mid - 1;
        else
            left = mid + 1;
        end
    end
end

local gcd
function gcd(a, b)
    --print(a,b);
    if (b == 0) then
        return a;
    else
        return gcd(b, a % b);
    end
end

--素数筛法，这个实现暂时看不懂
local function countPrimes(n)
    local isPrimes = list { 1 }:mulSign(n);
    local res = 0;

    for i in range(2, n) do
        if (isPrimes:get(i) == 1) then
            res = res + 1;
        end
        local j = i;
        while i * j < n do
            isPrimes:set(i * j, 0);
            j = j + 1;
        end
    end
    return res;
end


--全排列
local function permute(nums)
    local function permute_helper(nums, start)
        if (start >= nums:len()) then
            print(nums:toStr());
            return;
        end
        for i in range(start, nums:len()) do
            nums:swap(start, i);
            permute_helper(nums, start + 1);
            nums:swap(start, i);
        end
    end
    permute_helper(nums, 0);
end

--堆排序，不是很懂这个
local heapify;
function heapify(tree, n, i)
    if (i >= n) then
        return ;
    end

    local c1, c2 = 2 * i + 1, 2 * i + 2;
    local max = i;

    if (c1 < n and tree:get(c1) > tree:get(max)) then
        max = c1;
    end

    if (c2 < n and tree:get(c2) > tree:get(max)) then
        max = c2;
    end

    if (max ~= i) then
        tree:swap(max, i);
        heapify(tree, n, max);
    end
end

local function buildHeap(tree, n)--tree其实是我封装的list的
    local last_node = n - 1;
    local parent = math.floor((last_node - 1) / 2);

    local i = parent;

    while i >= 0 do
        heapify(tree, n, i);
        i = i - 1;
    end
end

local function heapSort(tree, n)
    buildHeap(tree, n);
    local i = n - 1;
    while i >= 0 do
        tree:swap(i, 0);
        heapify(tree, i, 0);
    end
end

local ListNode = class("ListNode");
function ListNode:ctor(val, next)
    self.val = val;
    self.next = next;
end

function ListNode:printStr()
    local l = self;

    while l ~= nil do
        print(l.val);
        l = l.next;
    end
end

function ListNode:reverse()
    local cur = self;
    local prev = nil;
    while (cur ~= nil) do
        local temp = cur.next;
        cur.next = prev;
        prev = cur;
        cur = temp;
    end
    return prev;
end

local TreeNode = class("TreeNode");
function TreeNode:ctor(val, left, right)
    self.val = val;
    self.left = left;
    self.right = right;
end

return {
    gcd = gcd,
    ListNode = ListNode,
    TreeNode = TreeNode,
}