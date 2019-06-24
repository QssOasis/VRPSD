%{

[����˵��]
��Ⱥ�㷨���VRP����

[�㷨˵��]
����ʵ��һ��ant�����࣬�ô�������ʵ��������
�㷨����tsp����ȥ�����������������·����ʱ��������

������10����������,����1���������ģ����������ĵõ���·����1,3,5,9,4,10,2,6,8,7��

����·����ʱ����������η���������·��,
ÿ����һ������ǰ���������������Ƿ�ᳬ���˳����������
���û�г����ͷ���
��������������¿�ʼһ������·��
����
ֱ�����һ������������
�ͻ�õ���������·��


%}

%������б�������Ķ���
clear;
clear classes;

%��Ⱥ�㷨����(ȫ�ֱ���)
global ALPHA; %��������
global BETA; %��������
global ANT_COUNT;  %��������
global CITY_COUNT;  %��������
global RHO; %��Ϣ�ز���ϵ��!!!
global IT_COUNT; %��������
global DAry; %������������
global TAry; %�����������Ϣ��
global CITYWAry; %�������������
global VW; %�˳����������

%===================================================================

%���ò�������ֵ
ALPHA=1.0;
BETA=2.0;
RHO=0.95;

IT_COUNT=1000;

VW=100;

%===================================================================
%��ȡ���ݲ����ݶ�ȡ������������������
load data.txt; %���ı��ļ���������
city_xy_ary=data(:,2:3); %�õ��������������
CITYWAry=data(:,4); %�õ�ÿ��������ʽ�������
x_label=data(:,2); %�ڶ���Ϊ������
y_label=data(:,3); %������Ϊ������
C=[x_label y_label];      %�������

CITY_COUNT=length(CITYWAry); %�õ���������(����������������)
ANT_COUNT=round(CITY_COUNT*2/3)+1; %������������������������,һ������Ϊ����������2/3

%MMAS��Ϣ�ز���
%���������Ϣ�غ���С��Ϣ��֮��ı�ֵ
PBest=0.05; %����һ�������ҵ����Ž�ĸ���
temp=PBest^(1/CITY_COUNT);
TRate=(1-temp)/((CITY_COUNT/2-1)*temp); %�����Ϣ�غ���С��Ϣ��֮��ı�ֵ

%��Ϣ�ص������Сֵ��ʼ��ʱ�����óɶ������ν
%��һ��������ɻ�����һ�����Ž�,Ȼ�������������²��������Сֵ
Tmax=1; %��Ϣ�����ֵ
Tmin=Tmax*TRate; %��Ϣ����Сֵ


% ���������������� 
DAry=zeros(CITY_COUNT);
for i=1:CITY_COUNT
    for j=1:CITY_COUNT       
       DAry(i,j)=sqrt((city_xy_ary(i,1)-city_xy_ary(j,1))^2+(city_xy_ary(i,2)-city_xy_ary(j,2))^2);
    end
end


% ��ʼ���������Ϣ��
TAry=zeros(CITY_COUNT);
TAry=TAry+Tmax;

%===================================================================

%��ʼ���������
rand('state', sum(100*clock));

%��һ�ַ���
%rand('twister',sum(100*clock))

%��������
mayi=ant(); 

Best_Path_Length=10e9; %���·�����ȣ������ó�һ���ܴ��ֵ


tm1=datenum(clock); %��¼�㷨��ʼִ��ʱ��ʱ��

FoundBetter=0; %һ�������Ƿ��и��Ž����


L_best=zeros(IT_COUNT,1);
%��ʼ����
for i=1:IT_COUNT    
        
    fprintf('��ʼ��%d������ , ʣ��%d��',i,IT_COUNT-i);
    
    FoundBetter=0; %����ǰ����Ϊû�и��Ž����
    
    for j=1:ANT_COUNT
        
        %��������һ��
        mayi=Search(mayi); 
        
        %�õ���������·������
        Length_Ary(j)=get(mayi,'path_length');
        
        %�õ�����������·��
        Path_Ary{j}=get(mayi,'path');
        
        
        %�������Ž�
        if (Length_Ary(j) < Best_Path_Length);
            Best_Path_Length=Length_Ary(j);            
            Best_Path=Path_Ary{j};
            
            %�и��Ž����,���ñ�־
            FoundBetter=1; 
        end        
      %L_best(i)=max(Length_Ary); 
    end
     L_best(i)=Best_Path_Length; 
    %�и��ý����,����2-OPT�Ż�
    if (FoundBetter == 1)
        fprintf(' , ���������ҵ����ý�!');
        Best_Path=opt2(Best_Path);
        Best_Path_Length=PathLength(Best_Path);
    end    
        
    %-------------------------------------------------------------
    %ȫ������������һ�Σ����»�����Ϣ��
    
    TAry=TAry*RHO;     
    
    %ֻ��ȫ�����������ͷ���Ϣ��
    dbQ=1/Best_Path_Length;                
    for k=2:CITY_COUNT            
        
        m=Best_Path(k-1); %��һ��������
        n=Best_Path(k); %��һ��������
        
        %����·���ϵ���Ϣ��
        TAry(m,n)=TAry(m,n)+dbQ; 
        TAry(n,m)=TAry(m,n);
    end
        
    %����������㷵�س�������·���ϵ���Ϣ��
    TAry(n,1)=TAry(n,1)+dbQ; 
    TAry(1,n)=TAry(n,1);
        
    
    %-------------------------------------------------------------
    %��������Ϣ��,���б߽���    
    Tmax=1/((1-RHO)*Best_Path_Length); %��Ϣ�����ֵ
    Tmin=Tmax*TRate; %��Ϣ����Сֵ
    
    for m=1:CITY_COUNT
        for n=1:CITY_COUNT
            if (TAry(m,n)>Tmax) 
                TAry(m,n)=Tmax;
            end
            if (TAry(m,n)<Tmin)
                TAry(m,n)=Tmin;                
            end
        end
    end
    
    %-------------------------------------------------------------
    %����
    fprintf('\n');
       
end

tm2=datenum(clock); %��¼�㷨����ִ��ʱ��ʱ��

fprintf('\n������� , ��ʱ%.3f�� , ���·����Ϊ%.3f , ���ͷ������� :��\n\n[1]',(tm2-tm1)*86400,Best_Path_Length);


%===================================================================
%������
dbW=0;
for i=2:CITY_COUNT
    m=Best_Path(i-1); %��һ������
    n=Best_Path(i); %��ǰ����

    if (dbW+CITYWAry(n)>VW) %���͵��ʽ𳬹�����
        fprintf('          (������ : %.1f%%)\n[1]-%d',dbW*100/VW,n);
        dbW=CITYWAry(n);  %������ʽ���ڸó��е�������
    else %û�г�������
        fprintf('-%d',n);
        dbW=dbW+CITYWAry(n); %������ʽ���ϸó��е�������                
    end                
end
fprintf('          (������ : %.1f%%)',dbW*100/VW);

fprintf('\n\n');

%====== [�������]=====================================================


figure(1)   %��������������ͼ
x=linspace(0,IT_COUNT,IT_COUNT);
y=L_best(:,1);
plot(x,y);
xlabel('��������'); ylabel('���·������');










