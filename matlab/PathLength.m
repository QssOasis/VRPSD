function f=PathLength(Path)
    
    %ȫ�ֱ���
    global DAry; %������������
    global CITYWAry; %�����ʽ�������
    global VW; %��������ʽ��
    
    %=====================================================
    n=0;
    m=0;
    dbW=0; %���浽��ĳ�������͵Ļ�����        
    Len=0; %�Ȱ�·��������0        
    COUNT=length(Path);%���鳤��
    
    for i=2:COUNT
        m=Path(i-1); %��һ������
        n=Path(i); %��ǰ����

        if (dbW+CITYWAry(n)>VW) %���͵��ʽ𳬹�����
            Len=Len+DAry(m,1); %��������վ�ľ���
            Len=Len+DAry(1,n); %����������վ���³���
            dbW=CITYWAry(n);  %������ʽ���ڸó��е�������          
        else %û�г�������
            Len=Len+DAry(m,n); %����һ�����㵽������ľ���
            dbW=dbW+CITYWAry(n); %������������ϸ������������                
        end                
    end

    Len=Len+DAry(n,1); %���ϴ�������㷵������վ�ľ���      

    f=Len;
    
end
