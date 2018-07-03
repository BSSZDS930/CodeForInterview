function [] = wcy( Missionary,Savage,Boat)
%wcy
%params: Missionary������ʿ��Ŀ,Savage��Ұ����Ŀ,Boat��������Ŀ
%output:the result

%������ۺ���ֵ
f = 6.01;

%����Open��
global n open_node index;
open_node(1,:)=[Missionary,Savage,Boat,1,-1,0.01];%��ʼ�� ����ʼ�ڵ������չ�ڵ��Open�У�������f��S��= 0.01
%1�󰶴���ʿ�� 2��Ұ���� 3����1Ϊ�󰶣�0Ϊ�Ұ���
%4�Ƿ����չ(1Ϊ����չ) 5���ڵ�ţ�-1��ʾ�޸��ڵ㣬��Ϊ��ʼ�ڵ㣩
n = 1;
index = 1;

%����Close��
global close_n close_node close_index;
%ͬ�Ͻ���Ԥ����
close_index = 0;
close_n = 0;
close_node = [-1,-1,-1,-1,-1,-1];
%��ʼ����ѭ��
while (1)
    
    % �����open���еĽڵ���Ŀ
    [row,~]=size(open_node);
   
    % ����Ŀ���� 0 ��ʱ���˳�
    if row==0
        fprintf('all the nodes in open list have been expanded.');
        return
    end
    
    % ����f��S��������
    open_node = sortrows(open_node,-6);
    %����һ��Close��Ŀ
    close_index = close_index + 1;
    close_node(close_index,:) = open_node(1,:);
    
    %�׽ڵ�   ��չ�ڵ�һ��ֻ�У�
    %һ������ʿ����������ʿ��һ������ʿ+һ��Ұ�ˡ�һ��Ұ�ˡ�����Ұ�� �������
    %��ȫ�������ȥ֮�����ô�ֻ�����ã����ﵽĿ��ڵ�
    if (open_node(1,1) == 0 && open_node(1,2) == 0 && open_node(1,5) ~= 0)
        fprintf('����ʿҰ�˹�������������\n');
        findTheWay(close_node,open_node(1,:));
        
    end
    
    %������нڵ����չ�����ʱ��ע��Ұ���������ܶ��ڴ���ʿ������
    tempMissionaryLeft = open_node(1,1);
    tempSavageLeft = open_node(1,2);
    tempMissionaryRight = Missionary - tempMissionaryLeft;
    tempSavageRight = Savage - tempSavageLeft;
    tempBoatLeft = open_node(1,3);
      
     % ����һ���ڵ�
    open_node(1,:) = [];
    index = index - 1;
    
    
    %����Ϊ�������
    %һ������ʿ
    if tempBoatLeft == 1 %������
        tempMissionaryLeft_1 = tempMissionaryLeft - 1;
        tempMissionaryRight_1 = tempMissionaryRight + 1;
        if tempMissionaryLeft_1 < 0 || (tempMissionaryLeft_1 ~= 0 && tempMissionaryLeft_1 < tempSavageLeft) || (tempMissionaryRight_1 ~=0 && tempMissionaryRight_1 < tempSavageRight) || tempMissionaryRight > Missionary
        else
            %��������һ�������Ժ�Ľ�������Ұ�����һ��һ������ʿ
            node = [tempMissionaryLeft_1,tempSavageLeft,0,1,close_index,f-tempMissionaryLeft_1-tempSavageLeft];
            if whetherInClose(close_node,node) == -1 && whetherInOpen(open_node,node) == -1
                %��������ڣ���Open�м���
                index = index + 1;
                open_node(index,:) = node;
            end
        end 
    end
    if tempBoatLeft == 0 %�����Ұ�
        tempMissionaryRight_1 = tempMissionaryRight - 1;
        tempMissionaryLeft_1 = tempMissionaryLeft + 1;
        if tempMissionaryRight_1 < 0 || (tempMissionaryRight_1 ~= 0 && tempMissionaryRight_1 < tempSavageRight) || (tempMissionaryLeft_1 ~= 0 && tempMissionaryLeft_1 < tempSavageLeft) || tempMissionaryLeft_1 > Missionary
        else
            %��������һ�������Ժ�Ľ�������Ұ�����һ��һ������ʿ 
            node = [tempMissionaryLeft_1,tempSavageLeft,1,1,close_index,f-tempMissionaryLeft_1-tempSavageLeft];
            %�ж��Ƿ���Closed�У���������ǣ����ü���Open�У���Ϊf��S���ǲ���ģ� �ж��Ƿ���Open��
            if whetherInClose(close_node,node) == -1 && whetherInOpen(open_node,node) == -1
               %��������ڣ���Open�м���
                index = index + 1;
                open_node(index,:) = node;
            end
        end
    end
    
    %��������ʿ
    if tempBoatLeft == 1 %������
        tempMissionaryLeft_1 = tempMissionaryLeft - 2;
        tempMissionaryRight_1 = tempMissionaryRight + 2;
        if tempMissionaryLeft_1 < 0 || (tempMissionaryLeft_1 ~= 0 && tempMissionaryLeft_1 < tempSavageLeft) || (tempMissionaryRight_1 ~=0 && tempMissionaryRight_1 < tempSavageRight) || tempMissionaryRight_1 > Missionary
        else
            %��������һ�������Ժ�Ľ�������Ұ�����һ��2������ʿ
            node = [tempMissionaryLeft_1,tempSavageLeft,0,1,close_index,f-tempMissionaryLeft_1-tempSavageLeft];
            if whetherInClose(close_node,node) == -1 && whetherInOpen(open_node,node) == -1
                %��������ڣ���Open�м���
                index = index + 1;
                open_node(index,:) = node;
            end
        end 
    end
    
    if tempBoatLeft == 0 %�����Ұ�
        tempMissionaryRight_1 = tempMissionaryRight - 2;
        tempMissionaryLeft_1 = tempMissionaryLeft + 2;
        if tempMissionaryRight_1 < 0 || (tempMissionaryRight_1 ~= 0 && tempMissionaryRight_1 < tempSavageRight) || (tempMissionaryLeft_1 ~= 0 && tempMissionaryLeft_1 < tempSavageLeft) || tempMissionaryLeft_1 > Missionary
        else
            %��������һ�������Ժ�Ľ�������Ұ�����һ��2������ʿ 
            node = [tempMissionaryLeft_1,tempSavageLeft,1,1,close_index,f-tempMissionaryLeft_1-tempSavageLeft];
            %�ж��Ƿ���Closed�У���������ǣ����ü���Open�У���Ϊf��S���ǲ���ģ� �ж��Ƿ���Open��
            if whetherInClose(close_node,node) == -1 && whetherInOpen(open_node,node) == -1
                %��������ڣ���Open�м���
                index = index + 1;
                open_node(index,:) = node;
            end
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
            
            node = [tempMissionaryLeft_1,tempSavageLeft_1,0,1,close_index,f-tempMissionaryLeft_1-tempSavageLeft_1];
           
            if whetherInClose(close_node,node) == -1 && whetherInOpen(open_node,node) == -1
                %��������ڣ���Open�м���
                index = index + 1;
                open_node(index,:) = node;
            end
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
            node = [tempMissionaryLeft_1,tempSavageLeft_1,1,1,close_index,f-tempMissionaryLeft_1-tempSavageLeft_1];
            %�ж��Ƿ���Closed�У���������ǣ����ü���Open�У���Ϊf��S���ǲ���ģ� �ж��Ƿ���Open��
            if whetherInClose(close_node,node) == -1 && whetherInOpen(open_node,node) == -1
               %��������ڣ���Open�м���
                index = index + 1;
                open_node(index,:) = node;
            end
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
            node = [tempMissionaryLeft_1,tempSavageLeft_1,0,1,close_index,f-tempMissionaryLeft_1-tempSavageLeft_1];
            if whetherInClose(close_node,node) == -1 && whetherInOpen(open_node,node) == -1
                %��������ڣ���Open�м���
                index = index + 1;
                open_node(index,:) = node;
            end
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
            node = [tempMissionaryLeft_1,tempSavageLeft_1,1,1,close_index,f-tempMissionaryLeft_1-tempSavageLeft_1];
            %�ж��Ƿ���Closed�У���������ǣ����ü���Open�У���Ϊf��S���ǲ���ģ� �ж��Ƿ���Open��
            if whetherInClose(close_node,node) == -1 && whetherInOpen(open_node,node) == -1
                %��������ڣ���Open�м���
                index = index + 1;
                open_node(index,:) = node;
            end
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
            node = [tempMissionaryLeft_1,tempSavageLeft_1,0,1,close_index,f-tempMissionaryLeft_1-tempSavageLeft_1];
            if whetherInClose(close_node,node) == -1 && whetherInOpen(open_node,node) == -1
                %��������ڣ���Open�м���
                index = index + 1;
                open_node(index,:) = node;
            end
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
            node = [tempMissionaryLeft_1,tempSavageLeft_1,1,1,close_index,f-tempMissionaryLeft_1-tempSavageLeft_1];
            %�ж��Ƿ���Closed�У���������ǣ����ü���Open�У���Ϊf��S���ǲ���ģ� �ж��Ƿ���Open��
            if whetherInClose(close_node,node) == -1 && whetherInOpen(open_node,node) == -1
                %��������ڣ���Open�м���
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
    fprintf('��%d�Σ��󰶵��Ұ�������ʿ��ȥ%d�ˣ�Ұ�˹�ȥ%d��\n',...
                    i,abs(BoatNum(xx,1)),abs(BoatNum(xx,2))); 
    end
    if BoatNum(xx,3) == 1
    fprintf('��%d�Σ��Ұ����󰶣�����ʿ��ȥ%d�ˣ�Ұ�˹�ȥ%d��\n',...
                    i,abs(BoatNum(xx,1)),abs(BoatNum(xx,2))); 
    end
end
end
