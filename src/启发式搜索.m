function [] = wcy( Missionary,Savage,Boat)
%wcy
%params: Missionary：传教士数目,Savage：野人数目,Boat：船的数目
%output:the result

%定义估价函数值
f = 6.01;

%定义Open表
global n open_node index;
open_node(1,:)=[Missionary,Savage,Boat,1,-1,0.01];%初始化 将初始节点放入拓展节点表Open中，并计算f（S）= 0.01
%1左岸传教士数 2左岸野人数 3船（1为左岸，0为右岸）
%4是否可扩展(1为可扩展) 5父节点号（-1表示无父节点，即为初始节点）
n = 1;
index = 1;

%定义Close表
global close_n close_node close_index;
%同上进行预设置
close_index = 0;
close_n = 0;
close_node = [-1,-1,-1,-1,-1,-1];
%开始进行循环
while (1)
    
    % 计算出open表中的节点数目
    [row,~]=size(open_node);
   
    % 在数目等于 0 的时候退出
    if row==0
        fprintf('all the nodes in open list have been expanded.');
        return
    end
    
    % 计算f（S）并排序
    open_node = sortrows(open_node,-6);
    %新增一个Close项目
    close_index = close_index + 1;
    close_node(close_index,:) = open_node(1,:);
    
    %首节点   拓展节点一共只有：
    %一个传教士、两个传教士、一个传教士+一个野人、一个野人、两个野人 五种情况
    %在全部运输过去之后设置船只不可用，即达到目标节点
    if (open_node(1,1) == 0 && open_node(1,2) == 0 && open_node(1,5) ~= 0)
        fprintf('传教士野人过河问题解决方案\n');
        findTheWay(close_node,open_node(1,:));
        
    end
    
    %否则进行节点的拓展，这个时候注意野人人数不能多于传教士的限制
    tempMissionaryLeft = open_node(1,1);
    tempSavageLeft = open_node(1,2);
    tempMissionaryRight = Missionary - tempMissionaryLeft;
    tempSavageRight = Savage - tempSavageLeft;
    tempBoatLeft = open_node(1,3);
      
     % 减少一个节点
    open_node(1,:) = [];
    index = index - 1;
    
    
    %下面为各种情况
    %一个传教士
    if tempBoatLeft == 1 %船在左岸
        tempMissionaryLeft_1 = tempMissionaryLeft - 1;
        tempMissionaryRight_1 = tempMissionaryRight + 1;
        if tempMissionaryLeft_1 < 0 || (tempMissionaryLeft_1 ~= 0 && tempMissionaryLeft_1 < tempSavageLeft) || (tempMissionaryRight_1 ~=0 && tempMissionaryRight_1 < tempSavageRight) || tempMissionaryRight > Missionary
        else
            %进行了这一步操作以后的结果：从右岸过来一个一个传教士
            node = [tempMissionaryLeft_1,tempSavageLeft,0,1,close_index,f-tempMissionaryLeft_1-tempSavageLeft];
            if whetherInClose(close_node,node) == -1 && whetherInOpen(open_node,node) == -1
                %如果都不在，在Open中加入
                index = index + 1;
                open_node(index,:) = node;
            end
        end 
    end
    if tempBoatLeft == 0 %船在右岸
        tempMissionaryRight_1 = tempMissionaryRight - 1;
        tempMissionaryLeft_1 = tempMissionaryLeft + 1;
        if tempMissionaryRight_1 < 0 || (tempMissionaryRight_1 ~= 0 && tempMissionaryRight_1 < tempSavageRight) || (tempMissionaryLeft_1 ~= 0 && tempMissionaryLeft_1 < tempSavageLeft) || tempMissionaryLeft_1 > Missionary
        else
            %进行了这一步操作以后的结果：从右岸过来一个一个传教士 
            node = [tempMissionaryLeft_1,tempSavageLeft,1,1,close_index,f-tempMissionaryLeft_1-tempSavageLeft];
            %判断是否在Closed中，这里如果是，不用加入Open中（因为f（S）是不变的） 判断是否在Open中
            if whetherInClose(close_node,node) == -1 && whetherInOpen(open_node,node) == -1
               %如果都不在，在Open中加入
                index = index + 1;
                open_node(index,:) = node;
            end
        end
    end
    
    %两个传教士
    if tempBoatLeft == 1 %船在左岸
        tempMissionaryLeft_1 = tempMissionaryLeft - 2;
        tempMissionaryRight_1 = tempMissionaryRight + 2;
        if tempMissionaryLeft_1 < 0 || (tempMissionaryLeft_1 ~= 0 && tempMissionaryLeft_1 < tempSavageLeft) || (tempMissionaryRight_1 ~=0 && tempMissionaryRight_1 < tempSavageRight) || tempMissionaryRight_1 > Missionary
        else
            %进行了这一步操作以后的结果：从右岸过来一个2个传教士
            node = [tempMissionaryLeft_1,tempSavageLeft,0,1,close_index,f-tempMissionaryLeft_1-tempSavageLeft];
            if whetherInClose(close_node,node) == -1 && whetherInOpen(open_node,node) == -1
                %如果都不在，在Open中加入
                index = index + 1;
                open_node(index,:) = node;
            end
        end 
    end
    
    if tempBoatLeft == 0 %船在右岸
        tempMissionaryRight_1 = tempMissionaryRight - 2;
        tempMissionaryLeft_1 = tempMissionaryLeft + 2;
        if tempMissionaryRight_1 < 0 || (tempMissionaryRight_1 ~= 0 && tempMissionaryRight_1 < tempSavageRight) || (tempMissionaryLeft_1 ~= 0 && tempMissionaryLeft_1 < tempSavageLeft) || tempMissionaryLeft_1 > Missionary
        else
            %进行了这一步操作以后的结果：从右岸过来一个2个传教士 
            node = [tempMissionaryLeft_1,tempSavageLeft,1,1,close_index,f-tempMissionaryLeft_1-tempSavageLeft];
            %判断是否在Closed中，这里如果是，不用加入Open中（因为f（S）是不变的） 判断是否在Open中
            if whetherInClose(close_node,node) == -1 && whetherInOpen(open_node,node) == -1
                %如果都不在，在Open中加入
                index = index + 1;
                open_node(index,:) = node;
            end
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
            
            node = [tempMissionaryLeft_1,tempSavageLeft_1,0,1,close_index,f-tempMissionaryLeft_1-tempSavageLeft_1];
           
            if whetherInClose(close_node,node) == -1 && whetherInOpen(open_node,node) == -1
                %如果都不在，在Open中加入
                index = index + 1;
                open_node(index,:) = node;
            end
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
            node = [tempMissionaryLeft_1,tempSavageLeft_1,1,1,close_index,f-tempMissionaryLeft_1-tempSavageLeft_1];
            %判断是否在Closed中，这里如果是，不用加入Open中（因为f（S）是不变的） 判断是否在Open中
            if whetherInClose(close_node,node) == -1 && whetherInOpen(open_node,node) == -1
               %如果都不在，在Open中加入
                index = index + 1;
                open_node(index,:) = node;
            end
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
            node = [tempMissionaryLeft_1,tempSavageLeft_1,0,1,close_index,f-tempMissionaryLeft_1-tempSavageLeft_1];
            if whetherInClose(close_node,node) == -1 && whetherInOpen(open_node,node) == -1
                %如果都不在，在Open中加入
                index = index + 1;
                open_node(index,:) = node;
            end
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
            node = [tempMissionaryLeft_1,tempSavageLeft_1,1,1,close_index,f-tempMissionaryLeft_1-tempSavageLeft_1];
            %判断是否在Closed中，这里如果是，不用加入Open中（因为f（S）是不变的） 判断是否在Open中
            if whetherInClose(close_node,node) == -1 && whetherInOpen(open_node,node) == -1
                %如果都不在，在Open中加入
                index = index + 1;
                open_node(index,:) = node;
            end
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
            node = [tempMissionaryLeft_1,tempSavageLeft_1,0,1,close_index,f-tempMissionaryLeft_1-tempSavageLeft_1];
            if whetherInClose(close_node,node) == -1 && whetherInOpen(open_node,node) == -1
                %如果都不在，在Open中加入
                index = index + 1;
                open_node(index,:) = node;
            end
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
            node = [tempMissionaryLeft_1,tempSavageLeft_1,1,1,close_index,f-tempMissionaryLeft_1-tempSavageLeft_1];
            %判断是否在Closed中，这里如果是，不用加入Open中（因为f（S）是不变的） 判断是否在Open中
            if whetherInClose(close_node,node) == -1 && whetherInOpen(open_node,node) == -1
                %如果都不在，在Open中加入
                index = index + 1;
                open_node(index,:) = node;
            end
        end
    end
end

end


function [whetherInClose] = whetherInClose(close_node,node)
[row,~]=size(close_node);
whetherInClose = -1;
for i = 1:row
    if close_node(i,1) == node(1,1) && close_node(i,2) == node(1,2) && close_node(i,3) == node(1,3)
        whetherInClose = 1;
    end
end
end

function [whetherInOpen] = whetherInOpen(open_node,node)
[row,~]=size(open_node);
whetherInOpen = -1;
for i = 1:row
    if open_node(i,1) == node(1,1) && open_node(i,2) == node(1,2) && open_node(i,3) == node(1,3)
        whetherInOpen = 1;
    end
end
end

function [] = findTheWay(close_node,node)
time = 0;
index = node(1,5);
while index ~= -1
    time = time + 1;
    index = close_node(index,5);
end
size = time;
BoatNum = zeros(size,3);
time = 0;
index = node(1,5);
while index ~= -1
    time = time + 1;
    BoatNum(time,:) = [close_node(index,1)-node(1,1), close_node(index,2)-node(1,2),node(1,3)];
    node(1,1) = close_node(index,1);
    node(1,2) = close_node(index,2);
    node(1,3) = close_node(index,3);
    index = close_node(index,5);
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
