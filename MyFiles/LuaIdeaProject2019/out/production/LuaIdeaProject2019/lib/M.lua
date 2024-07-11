local M ={}

local function tri_area(a,b,c)
   local p=(a+b+c)/2;
   local res=math.sqrt(p*(p-a)*(p-b)*(p-c));
   return res;
end

local function is_tri(a,b,c)
   local b1=(a+b)>c;
   local b2=(a+c)>b;
   local b3=(b+c)>a;
   return b1 and b2 and b3;
end

local function printTable(t)
   print(table.concat(t," "));
end

local function printList(t)
   printTable(t)
end

local function printMatrix(t)
   for i, v in ipairs(t) do
      printTable(v);
   end
end

local function initMatrix(row,col)
   local res={};
   for i=1,row do
      local t ={};
      for j=1,col do
         t[#t+1]=0;
      end
      res[#res+1]=t;
   end
   return res,row,col;
end

local function snakeMatrix(row,col,step)
   step =step or 1;

   local martix =initMatrix(row,col);
   local row_start=1;
   local row_end=row;
   local col_start=1;
   local col_end=col;

   while(step<=row*col) do
      for i=col_start,col_end do
         martix[row_start][i]=step;
         step=step+1;
      end
      row_start=row_start+1;

      for i=row_start,row_end do
         martix[i][col_end]=step;
         step=step+1;
      end
      col_end=col_end-1;

      for i=col_end,col_start,-1 do
         martix[row_end][i]=step;
         step=step+1;
      end
      row_end=row_end-1;

      for i=row_end,row_start,-1 do
         martix[i][col_start]=step;
         step=step+1;
      end
      col_start=col_start+1;
   end

   --printMatrix(martix);
   return martix;
end

local function listSum(t)
   local res =0;
   for i, v in ipairs(t) do
     res =res+v;
   end
   return res;
end

local function randomItem(t)
   local idx =math.random(1,#t);
   return t[idx];
end

--双等差数列通项公式
local function doubleArithmeticSeqItem(first2,d1,n)
   return math.floor( first2+ d1*((n*(n-1))/2));
end

M.printList=printList;
M.doubleArithmeticSeqItem=doubleArithmeticSeqItem;
M.listSum=listSum;
M.randomItem=randomItem;
M.snakeMatrix=snakeMatrix;
M.printMatrix=printMatrix;
M.is_tri=is_tri;
M.tri_area=tri_area;
M.initMatrix=initMatrix;
return M;