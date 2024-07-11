
-- Author: skyAllen
-- Date: 2023-09-07 15:01:08
-- Email: 894982165@qq.com
-- Copyright: © 2023 skyAllen


do
    local res =list{1,2};
    local res2 =list{3,4};
--[[    local resAdd= res+res2;
    print(resAdd,resAdd:toStr());]]


    local res3={{2,3,5},{6,7,0},{9,8,5},{2,1,1}};

    local res4 =List.MatrixByTable(res3);
    assert(List.MatrixToStr(res4)=="[2,3,5 | 6,7,0 | 9,8,5 | 2,1,1]");
end

do
    local res = list { 1, 2, 3 };
    assertAll(res:get(-1) == 3, res:get(-2) == 2, res:get(-3) == 1, res:get(0) == 1)
end

do
    local res = list { 1, 2, 3, 4, 5 };
    assert(res:all(function(item)
        return item >= 1
    end));
    assert(not res:all(function(item)
        return item >= 2
    end));
    assert(res:any(function(item)
        return item >= 5
    end));
    assert(not res:any(function(item)
        return item >= 6
    end));

    assert(res:reduce(function(a, b)
        return a + b
    end) == 15);
    assert(res:reduce(function(a, b)
        return a * b
    end) == 120);

    local res2 = list { 3, 2, 1 };
    local res3 = list {};
    for i in range(res2:len() - 1, -1, -2) do
        res3:append(i);
    end
    assert(res3:toStr() == "[2,0]");
end

do
    local res = list { 'H', 'e', 'l', 'l', 'o', 'w', 'o', 'l', 'd' };
    assert(res:slice(0, -5):toStr() == "[H,e,l,l]");
    assert(res:slice(0, res:len(), 3):toStr() == "[H,l,o]")
end

do
    local res = list { 2, 3 };
    local res2 = res:mulSign(2);
    assert(res2:toStr() == "[2,3,2,3]");
end

do
    local res = list { 3, 2, 1 };
    assertAll(res:max() == 3, res:min() == 1);
    --print("max","min",res:max(),res:min());
end

do
    local res = List.Matrix(2, 3, 1);
    --print(List.MatrixToStr(res));
    assertAll(res:len() == 2, res:get(0):len() == 3, res:get(0):get(0) == 1);
end

do
    local tList = list({ "a", "b", "c" });

    tList:set(0, "A");
    tList:set(1, "B");
    tList:set(2, "C");

    tList:append("D");

    assertAll(tList:len() == 4, tList:get(0) == "A", tList:get(1) == "B", tList:get(2) == "C", tList:get(3) == "D");

    local tListIndex = list {};
    for i, item in enumerate(tList) do
        tListIndex:append(i);
    end

    assert(List.ContentEqual(list { 0, 1, 2, 3 }, tListIndex))
    assert(not List.ContentEqual(list { 0, 1, 3, 4 }, tListIndex))

    local tList2 = list({ "aa", "bb" })
    assertAll(tList2:get(0) == "aa", tList2:get(1) == "bb", tList2:len() == 2)
    tList2:append("cc");

    assertAll(tList2:get(0) == "aa", tList2:get(1) == "bb", tList2:get(2) == "cc", tList2:len() == 3)
end ;

do
    local tList3 = list({ 'aa', 'bb' });
    assert(tList3:toStr() == "[aa,bb]");
    tList3:clear();
    assertAll(tList3:toStr() == "{}");
    assert(tList3:len() == 0);
    tList3:append("a");
    tList3:append("b");
    assert(tList3:index("b") == 1);
    assert(tList3:index("a") == 0);
    assert(tList3:index("c") == -1);
    assert(tList3:toStr() == "[a,b]");
    assert(tList3:inList("b"));
    assert(tList3:inList("a"));
    assert(not tList3:inList("c"));

    tList3:extend(list { "c", "d" });
    assert(tList3:toStr() == "[a,b,c,d]");
    assert(tList3:pop() == "d");
    assert(tList3:len() == 3);
    assert(tList3:pop(0) == "a");

    assert(tList3:toStr() == "[b,c]");
    tList3:remove("b");
    assert(tList3:toStr() == "[c]");
    assert(not tList3:remove("k"));
end

do
    local tList4 = list { '1', '2', 'a', 'b', 'c' }
    tList4:reverse();
    assert(tList4:toStr() == "[c,b,a,2,1]");
    local tList5 = list { { x = 3 }, { x = 2 }, { x = 5 }, { x = 1 } };

    tList5:sort(function(a, b)
        return a.x <= b.x
    end);
    assertAll(List.ContentEqual(tList5:map(function(item)
        return item.x
    end), list { 1, 2, 3, 5 }));

    local tList5Copy = tList5:copy();--这个里面包含切片了
    assertAll(tList5 ~= tList5Copy);
end

do
    local tList6 = list { 3, 5, 6, 7, 2, 3, 5 };
    local tList6A = tList6:filter(function(a)
        return a > 3
    end);
    local tList6B = tList6A:map(function(a)
        return a * 2;
    end);
    assertAll(tList6A:toStr() == "[5,6,7,5]");
    assertAll(tList6B:toStr() == "[10,12,14,10]");

end

do
    --print("tList7 start");
    local tList7 = list { 'a', 'b' };
    tList7:insert(3, 'c');
    assertAll(tList7:toStr() == "[a,b]");
    tList7:insert(2, "c")
    assertAll(tList7:toStr() == "[a,b,c]");
    tList7:insert(0, "d");
    assertAll(tList7:toStr() == "[d,a,b,c]");
end
