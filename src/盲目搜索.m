function [] = wcy2( Missionary,Savage,Boat)
%wcy
%params: Missionary������ʿ��Ŀ,Savage��Ұ����Ŀ,Boat��������Ŀ
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
%�����ж��Ƿ����
if(open_node(1,1) == 0 && open_node(1,2) == 0 && open_node(1,4) ~= 0)
    fprintf('����ʿҰ�˹�������������\n');
    findTheWay(totalNode,open_node)
end
%������нڵ����չ�����ʱ��ע��Ұ���������ܶ��ڴ���ʿ������
tempMissionaryLeft = open_node(1,1);
tempSavageLeft = open_node(1,2);
tempMissionaryRight = Missionary - tempMissionaryLeft;
tempSavageRight = Savage - tempSavageLeft;
tempBoatLeft = open_node(1,3);

%����Ϊ�������
%һ������ʿ
if tempBoatLeft == 1 %������
    tempMissionaryLeft_1 = tempMissionaryLeft - 1;
    tempMissionaryRight_1 = tempMissionaryRight + 1;
    if tempMissionaryLeft_1 < 0 || (tempMissionaryLeft_1 ~= 0 && tempMissionaryLeft_1 < tempSavageLeft) || (tempMissionaryRight_1 ~=0 && tempMissionaryRight_1 < tempSavageRight) || tempMissionaryRight > Missionary
    else
        %��������һ�������Ժ�Ľ�������Ұ�����һ��һ������ʿ
        node = [tempMissionaryLeft_1,tempSavageLeft,0,row];
        getWay(node,totalNode,Missionary,Savage)
    end 
end
if tempBoatLeft == 0 %�����Ұ�
    tempMissionaryRight_1 = tempMissionaryRight - 1;
    tempMissionaryLeft_1 = tempMissionaryLeft + 1;
    if tempMissionaryRight_1 < 0 || (tempMissionaryRight_1 ~= 0 && tempMissionaryRight_1 < tempSavageRight) || (tempMissionaryLeft_1 ~= 0 && tempMissionaryLeft_1 < tempSavageLeft) || tempMissionaryLeft_1 > Missionary
    else
        %��������һ�������Ժ�Ľ�������Ұ�����һ��һ������ʿ 
        node = [tempMissionaryLeft_1,tempSavageLeft,1,row];
        getWay(node,totalNode,Missionary,Savage)
    end
end

%��������ʿ
if tempBoatLeft == 1 %������
    tempMissionaryLeft_1 = tempMissionaryLeft - 2;
    tempMissionaryRight_1 = tempMissionaryRight + 2;
    if tempMissionaryLeft_1 < 0 || (tempMissionaryLeft_1 ~= 0 && tempMissionaryLeft_1 < tempSavageLeft) || (tempMissionaryRight_1 ~=0 && tempMissionaryRight_1 < tempSavageRight) || tempMissionaryRight_1 > Missionary
    else
        %��������һ�������Ժ�Ľ�������Ұ�����һ��2������ʿ
        node = [tempMissionaryLeft_1,tempSavageLeft,0,row];
        getWay(node,totalNode,Missionary,Savage)
    end 
end

if tempBoatLeft == 0 %�����Ұ�
    tempMissionaryRight_1 = tempMissionaryRight - 2;
    tempMissionaryLeft_1 = tempMissionaryLeft + 2;
    if tempMissionaryRight_1 < 0 || (tempMissionaryRight_1 ~= 0 && tempMissionaryRight_1 < tempSavageRight) || (tempMissionaryLeft_1 ~= 0 && tempMissionaryLeft_1 < tempSavageLeft) || tempMissionaryLeft_1 > Missionary
    else
        %��������һ�������Ժ�Ľ�������Ұ�����2������ʿ 
        node = [tempMissionaryLeft_1,tempSavageLeft,1,row];
        getWay(node,totalNode,Missionary,Savage)
    end
end

%һ������ʿ��һ��Ұ
if tempBoatLeft == 1 %������
    tempMissionaryLeft_1 = tempMissionaryLeft - 1;
    tempSavageLeft_1 = tempSavageLeft - 1;
    tempMissionaryRight_1 = tempMissionaryRight + 1;
    tempSavageRight_1 = tempSavageRight + 1;
    if  tempSavageLeft_1 < 0 || tempMissionaryLeft_1 < 0 || (tempMissionaryLeft_1 ~= 0 && tempMissionaryLeft_1 < tempSavageLeft_1) || (tempMissionaryRight_1 ~= 0 &&tempMissionaryRight_1 < tempSavageRight_1) || tempMissionaryRight_1  > Missionary || tempSavageRight_1 > Savage
    else
        %��������һ�������Ժ�Ľ�������Ұ�����һ��һ������ʿһ��Ұ��

        node = [tempMissionaryLeft_1,tempSavageLeft_1,0,row];
        getWay(node,totalNode,Missionary,Savage)
    end 
end
if tempBoatLeft == 0 %�����Ұ�
    tempMissionaryRight_1 = tempMissionaryRight - 1;
    tempMissionaryLeft_1 = tempMissionaryLeft + 1;
    tempSavageLeft_1 = tempSavageLeft + 1;
    tempSavageRight_1 = tempSavageRight - 1; 
    if tempMissionaryLeft_1 > Missionary || tempSavageLeft_1 > Savage || tempSavageRight_1 < 0 || tempMissionaryRight_1 < 0 || (tempMissionaryRight_1 ~= 0 && tempMissionaryRight_1 < tempSavageRight_1) || (tempMissionaryLeft_1 ~= 0 && tempMissionaryLeft_1 < tempSavageLeft_1)
    else
        %��������һ�������Ժ�Ľ�������Ұ�����һ��һ������ʿһ��Ұ�� 
        node = [tempMissionaryLeft_1,tempSavageLeft_1,1,row];
        getWay(node,totalNode,Missionary,Savage)
    end
end

%����Ұ��
if tempBoatLeft == 1 %������
    tempMissionaryLeft_1 = tempMissionaryLeft;
    tempMissionaryRight_1 = tempMissionaryRight;
    tempSavageRight_1 = tempSavageRight + 2;
    tempSavageLeft_1 = tempSavageLeft - 2;
    if tempSavageRight_1 > Savage || tempSavageLeft_1 < 0 || (tempSavageLeft_1 ~= 0 && tempMissionaryRight_1 < tempSavageRight_1) || (tempMissionaryLeft_1 ~= 0 && tempMissionaryLeft_1 < tempSavageLeft_1)
    else
        %��������һ�������Ժ�Ľ�������Ұ�����2��Ұ��
        node = [tempMissionaryLeft_1,tempSavageLeft_1,0,row];
        getWay(node,totalNode,Missionary,Savage)
    end 
end
if tempBoatLeft == 0 %�����Ұ�
    tempMissionaryLeft_1 = tempMissionaryLeft;
    tempSavageRight_1 = tempSavageRight - 2;
    tempMissionaryRight_1 = tempMissionaryRight;
    tempSavageLeft_1 = tempSavageLeft + 2;
    if tempSavageLeft_1 > Savage || tempSavageLeft_1 < 0 || (tempSavageRight_1 ~= 0 && tempMissionaryLeft_1 < tempSavageLeft_1) || (tempMissionaryRight_1 ~= 0 && tempMissionaryRight_1 < tempSavageRight_1)
    else
        %��������һ�������Ժ�Ľ�������Ұ�����һ��2��Ұ��
        node = [tempMissionaryLeft_1,tempSavageLeft_1,1,row];
        getWay(node,totalNode,Missionary,Savage)
    end
end
%һ��Ұ��
if tempBoatLeft == 1 %������
    tempMissionaryLeft_1 = tempMissionaryLeft;
    tempMissionaryRight_1 = tempMissionaryRight;
    tempSavageRight_1 = tempSavageRight + 1;
    tempSavageLeft_1 = tempSavageLeft - 1;
    if tempSavageRight_1 > Savage || tempSavageLeft_1 < 0 || (tempSavageLeft_1 ~= 0 && tempMissionaryRight_1 < tempSavageRight_1)  || tempMissionaryLeft_1 < tempSavageLeft_1
    else
        %��������һ�������Ժ�Ľ�������Ұ�����1��Ұ��
        node = [tempMissionaryLeft_1,tempSavageLeft_1,0,row];
        getWay(node,totalNode,Missionary,Savage)
    end 
end
if tempBoatLeft == 0 %�����Ұ�
    tempMissionaryLeft_1 = tempMissionaryLeft;
    tempSavageRight_1 = tempSavageRight - 1;
    tempSavageLeft_1 = tempSavageLeft + 1;        
    tempMissionaryRight_1 = tempMissionaryRight;
    if tempSavageLeft_1 > Savage || tempSavageLeft_1 < 0 || (tempMissionaryLeft_1 ~= 0 && tempMissionaryLeft_1 < tempSavageLeft_1) || (tempMissionaryRight_1 ~= 0 && tempMissionaryRight_1 < tempSavageRight_1)
    else
        %��������һ�������Ժ�Ľ�������Ұ�����һ��1��Ұ��
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
    fprintf('��%d�Σ��󰶵��Ұ�������ʿ��ȥ%d�ˣ�Ұ�˹�ȥ%d��\n',...
                    i,abs(BoatNum(xx,1)),abs(BoatNum(xx,2))); 
    end
    if BoatNum(xx,3) == 1
    fprintf('��%d�Σ��Ұ����󰶣�����ʿ��ȥ%d�ˣ�Ұ�˹�ȥ%d��\n',...
                    i,abs(BoatNum(xx,1)),abs(BoatNum(xx,2))); 
    end
end
end