function [] = wcy2( Missionary,Savage,Boat)
%wcy
%params: Missionary：传教士数目,Savage：野人数目,Boat：船的数目
%output:the result

open_node = [Missionary,Savage,Boat,-1];
getWay(open_node,[],Missionary,Savage)
end

function[] = getWay(open_node,totalNode,Missionary,Savage)
[row,~]=size(totalNode);
for i = 1:row
    if totalNode(i,1) == open_node(1,1) && totalNode(i,2) == open_node(1,2) && totalNode(i,3) == open_node(1,3) && totalNode(i,4) ~= open_node(1,4)
        return
    end
end
row = row + 1;
totalNode(row,:) = open_node;
%进行判断是否完成
if(open_node(1,1) == 0 && open_node(1,2) == 0 && open_node(1,4) ~= 0)
    fprintf('传教士野人过河问题解决方案\n');
    findTheWay(totalNode,open_node)
end
%否则进行节点的拓展，这个时候注意野人人数不能多于传教士的限制
tempMissionaryLeft = open_node(1,1);
tempSavageLeft = open_node(1,2);
tempMissionaryRight = Missionary - tempMissionaryLeft;
tempSavageRight = Savage - tempSavageLeft;
tempBoatLeft = open_node(1,3);

%下面为各种情况
%一个传教士
if tempBoatLeft == 1 %船在左岸
    tempMissionaryLeft_1 = tempMissionaryLeft - 1;
    tempMissionaryRight_1 = tempMissionaryRight + 1;
    if tempMissionaryLeft_1 < 0 || (tempMissionaryLeft_1 ~= 0 && tempMissionaryLeft_1 < tempSavageLeft) || (tempMissionaryRight_1 ~=0 && tempMissionaryRight_1 < tempSavageRight) || tempMissionaryRight > Missionary
    else
        %进行了这一步操作以后的结果：从右岸过来一个一个传教士
        node = [tempMissionaryLeft_1,tempSavageLeft,0,row];
        getWay(node,totalNode,Missionary,Savage)
    end 
end
if tempBoatLeft == 0 %船在右岸
    tempMissionaryRight_1 = tempMissionaryRight - 1;
    tempMissionaryLeft_1 = tempMissionaryLeft + 1;
    if tempMissionaryRight_1 < 0 || (tempMissionaryRight_1 ~= 0 && tempMissionaryRight_1 < tempSavageRight) || (tempMissionaryLeft_1 ~= 0 && tempMissionaryLeft_1 < tempSavageLeft) || tempMissionaryLeft_1 > Missionary
    else
        %进行了这一步操作以后的结果：从右岸过来一个一个传教士 
        node = [tempMissionaryLeft_1,tempSavageLeft,1,row];
        getWay(node,totalNode,Missionary,Savage)
    end
end

%两个传教士
if tempBoatLeft == 1 %船在左岸
    tempMissionaryLeft_1 = tempMissionaryLeft - 2;
    tempMissionaryRight_1 = tempMissionaryRight + 2;
    if tempMissionaryLeft_1 < 0 || (tempMissionaryLeft_1 ~= 0 && tempMissionaryLeft_1 < tempSavageLeft) || (tempMissionaryRight_1 ~=0 && tempMissionaryRight_1 < tempSavageRight) || tempMissionaryRight_1 > Missionary
    else
        %进行了这一步操作以后的结果：从右岸过来一个2个传教士
        node = [tempMissionaryLeft_1,tempSavageLeft,0,row];
        getWay(node,totalNode,Missionary,Savage)
    end 
end

if tempBoatLeft == 0 %船在右岸
    tempMissionaryRight_1 = tempMissionaryRight - 2;
    tempMissionaryLeft_1 = tempMissionaryLeft + 2;
    if tempMissionaryRight_1 < 0 || (tempMissionaryRight_1 ~= 0 && tempMissionaryRight_1 < tempSavageRight) || (tempMissionaryLeft_1 ~= 0 && tempMissionaryLeft_1 < tempSavageLeft) || tempMissionaryLeft_1 > Missionary
    else
        %进行了这一步操作以后的结果：从右岸过来2个传教士 
        node = [tempMissionaryLeft_1,tempSavageLeft,1,row];
        getWay(node,totalNode,Missionary,Savage)
    end
end

%一个传教士和一个野
if tempBoatLeft == 1 %船在左岸
    tempMissionaryLeft_1 = tempMissionaryLeft - 1;
    tempSavageLeft_1 = tempSavageLeft - 1;
    tempMissionaryRight_1 = tempMissionaryRight + 1;
    tempSavageRight_1 = tempSavageRight + 1;
    if  tempSavageLeft_1 < 0 || tempMissionaryLeft_1 < 0 || (tempMissionaryLeft_1 ~= 0 && tempMissionaryLeft_1 < tempSavageLeft_1) || (tempMissionaryRight_1 ~= 0 &&tempMissionaryRight_1 < tempSavageRight_1) || tempMissionaryRight_1  > Missionary || tempSavageRight_1 > Savage
    else
        %进行了这一步操作以后的结果：从右岸过来一个一个传教士一个野人

        node = [tempMissionaryLeft_1,tempSavageLeft_1,0,row];
        getWay(node,totalNode,Missionary,Savage)
    end 
end
if tempBoatLeft == 0 %船在右岸
    tempMissionaryRight_1 = tempMissionaryRight - 1;
    tempMissionaryLeft_1 = tempMissionaryLeft + 1;
    tempSavageLeft_1 = tempSavageLeft + 1;
    tempSavageRight_1 = tempSavageRight - 1; 
    if tempMissionaryLeft_1 > Missionary || tempSavageLeft_1 > Savage || tempSavageRight_1 < 0 || tempMissionaryRight_1 < 0 || (tempMissionaryRight_1 ~= 0 && tempMissionaryRight_1 < tempSavageRight_1) || (tempMissionaryLeft_1 ~= 0 && tempMissionaryLeft_1 < tempSavageLeft_1)
    else
        %进行了这一步操作以后的结果：从右岸过来一个一个传教士一个野人 
        node = [tempMissionaryLeft_1,tempSavageLeft_1,1,row];
        getWay(node,totalNode,Missionary,Savage)
    end
end

%两个野人
if tempBoatLeft == 1 %船在左岸
    tempMissionaryLeft_1 = tempMissionaryLeft;
    tempMissionaryRight_1 = tempMissionaryRight;
    tempSavageRight_1 = tempSavageRight + 2;
    tempSavageLeft_1 = tempSavageLeft - 2;
    if tempSavageRight_1 > Savage || tempSavageLeft_1 < 0 || (tempSavageLeft_1 ~= 0 && tempMissionaryRight_1 < tempSavageRight_1) || (tempMissionaryLeft_1 ~= 0 && tempMissionaryLeft_1 < tempSavageLeft_1)
    else
        %进行了这一步操作以后的结果：从右岸过来2个野人
        node = [tempMissionaryLeft_1,tempSavageLeft_1,0,row];
        getWay(node,totalNode,Missionary,Savage)
    end 
end
if tempBoatLeft == 0 %船在右岸
    tempMissionaryLeft_1 = tempMissionaryLeft;
    tempSavageRight_1 = tempSavageRight - 2;
    tempMissionaryRight_1 = tempMissionaryRight;
    tempSavageLeft_1 = tempSavageLeft + 2;
    if tempSavageLeft_1 > Savage || tempSavageLeft_1 < 0 || (tempSavageRight_1 ~= 0 && tempMissionaryLeft_1 < tempSavageLeft_1) || (tempMissionaryRight_1 ~= 0 && tempMissionaryRight_1 < tempSavageRight_1)
    else
        %进行了这一步操作以后的结果：从右岸过来一个2个野人
        node = [tempMissionaryLeft_1,tempSavageLeft_1,1,row];
        getWay(node,totalNode,Missionary,Savage)
    end
end
%一个野人
if tempBoatLeft == 1 %船在左岸
    tempMissionaryLeft_1 = tempMissionaryLeft;
    tempMissionaryRight_1 = tempMissionaryRight;
    tempSavageRight_1 = tempSavageRight + 1;
    tempSavageLeft_1 = tempSavageLeft - 1;
    if tempSavageRight_1 > Savage || tempSavageLeft_1 < 0 || (tempSavageLeft_1 ~= 0 && tempMissionaryRight_1 < tempSavageRight_1)  || tempMissionaryLeft_1 < tempSavageLeft_1
    else
        %进行了这一步操作以后的结果：从右岸过来1个野人
        node = [tempMissionaryLeft_1,tempSavageLeft_1,0,row];
        getWay(node,totalNode,Missionary,Savage)
    end 
end
if tempBoatLeft == 0 %船在右岸
    tempMissionaryLeft_1 = tempMissionaryLeft;
    tempSavageRight_1 = tempSavageRight - 1;
    tempSavageLeft_1 = tempSavageLeft + 1;        
    tempMissionaryRight_1 = tempMissionaryRight;
    if tempSavageLeft_1 > Savage || tempSavageLeft_1 < 0 || (tempMissionaryLeft_1 ~= 0 && tempMissionaryLeft_1 < tempSavageLeft_1) || (tempMissionaryRight_1 ~= 0 && tempMissionaryRight_1 < tempSavageRight_1)
    else
        %进行了这一步操作以后的结果：从右岸过来一个1个野人
        node = [tempMissionaryLeft_1,tempSavageLeft_1,1,row];
        getWay(node,totalNode,Missionary,Savage)
    end
end
end


function [] = findTheWay(close_node,node)
time = 0;
index = node(1,4);
while index ~= -1
    time = time + 1;
    index = close_node(index,4);
end
size = time;
BoatNum = zeros(size,3);
time = 0;
index = node(1,4);
while index ~= -1
    time = time + 1;
    BoatNum(time,:) = [close_node(index,1)-node(1,1), close_node(index,2)-node(1,2),node(1,3)];
    node(1,1) = close_node(index,1);
    node(1,2) = close_node(index,2);
    node(1,3) = close_node(index,3);
    index = close_node(index,4);
end
for i = 1:size
    xx = size - i + 1;
    if BoatNum(xx,3) == 0
    fprintf('第%d次：左岸到右岸，传教士过去%d人，野人过去%d人\n',...
                    i,abs(BoatNum(xx,1)),abs(BoatNum(xx,2))); 
    end
    if BoatNum(xx,3) == 1
    fprintf('第%d次：右岸到左岸，传教士过去%d人，野人过去%d人\n',...
                    i,abs(BoatNum(xx,1)),abs(BoatNum(xx,2))); 
    end
end
end