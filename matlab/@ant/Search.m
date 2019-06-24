%��������������
function C=Search(C)
  
    %=======================================================
    %ȫ�ֱ���
    global ALPHA; %��������
    global BETA; %��������
    global CITY_COUNT;  %��������
    global DAry; %������������
    global TAry; %�����������Ϣ��
    global CITYWAry; %�������������
    global VW; %�����������

    %========================================================
    %���¶���Ƕ���Ӻ���ʵ���������һ������·��
    
    %��ʼ��
    function f1=Init()
        
    	C.m_dbPathLength=0; %�����߹���·��������0
        C.m_nPathAry=C.m_nPathAry*0;  %��������ߵ�·��
        C.m_nAllowedCityAry=C.m_nAllowedCityAry+1; %��ȫ����������Ϊû��ȥ��              
        
        C.m_nPathAry(1)=1; %������1������Ҳ��������վ
        C.m_nCurCityNo=1; %��ʼ���ڵ�����������վ
        C.m_nMovedCityCount=1; %�Ѿ�ȥ������������Ϊ1
        C.m_nAllowedCityAry(1)=0; %��һ����������Ϊȥ����

        f1=0;    
    end

    %========================================================

    %����ѡ����һ������
    function f2=ChooseNextCity()
        nSelectedCity=-1; %����ѡ�������һ�����㣬��ʱ���ó�-1
        
        dbTotal=0; 

        %����������㱻ѡ�еĸ���ֵ
    	for i=1:CITY_COUNT
    		if (C.m_nAllowedCityAry(i) == 1) %����ûȥ��

                %������͵�ǰ��������Ϣ��
        		prob(i)=(TAry(C.m_nCurCityNo,i)^ALPHA)/(DAry(C.m_nCurCityNo,i)^BETA);
            	
                %�ۼ���Ϣ�أ��õ��ܺ�
                dbTotal=dbTotal+prob(i); 

            else
                
                %�������ȥ���ˣ����䱻ѡ�еĸ���ֵΪ0
        		prob(i)=0.0;
            end           
        end



        %��ʼ��������ѡ��
        dbTemp=0.0;
    	if (dbTotal > 0.0) %�ܵ���Ϣ��ֵ����0
            
        	dbTemp=rand*dbTotal; %ȡһ�������
            
            for i=1:CITY_COUNT
                
                if (C.m_nAllowedCityAry(i) == 1) %����ûȥ��	
                    
                    dbTemp=dbTemp-prob(i); %��������൱��ת������
                    
    				if (dbTemp < 0.0) %����ֹͣת�������������ţ�ֱ������ѭ��	
                        
        				nSelectedCity=i;
            			break;
                        
                    end
                    
                end
                
            end                
            
        end        
        
        
    	%�����������Ϣ�طǳ�С ( С����double�ܹ���ʾ����С�����ֻ�ҪС )    
        %��ô���ڸ�����������ԭ���������ĸ����ܺͿ���Ϊ0
    	%����־�������������û�����㱻ѡ�����
    	%��������������Ͱѵ�һ��ûȥ����������Ϊ���ؽ��
    	if (nSelectedCity == -1)
        	for i=1:CITY_COUNT
            	if (C.m_nAllowedCityAry(i) == 1) %����ûȥ��
                	nSelectedCity=i;
                    break;
                end            
            end            
        end                            
    
        %����
        f2=nSelectedCity;
        
    end
    
    %========================================================

    %������������ƶ�
    function f3=Move()
        
        nCityNo=ChooseNextCity(); %ѡ����һ������

        C.m_nMovedCityCount=C.m_nMovedCityCount+1; %�Ѿ�ȥ��������������1
    	C.m_nPathAry(C.m_nMovedCityCount)=nCityNo; %���������ߵ�·��
        C.m_nAllowedCityAry(nCityNo)=0;%������������ó��Ѿ�ȥ����
    	C.m_nCurCityNo=nCityNo; %�ı䵱ǰ��������Ϊѡ�������
    
        
        f3=0;
    end
    %========================================================
    
    %���������ߵ�·������
    function f4=CalPathLength()       

        n=0;
        m=0;
        dbW=0; %���浽��ĳ�������͵Ļ�����
        
    	C.m_dbPathLength=0.0; %�Ȱ�·��������0

        for i=2:CITY_COUNT
            m=C.m_nPathAry(i-1); %��һ������
            n=C.m_nPathAry(i); %��ǰ����

            if (dbW+CITYWAry(n)>VW) %���͵Ļ��ﳬ������
                C.m_dbPathLength=C.m_dbPathLength+DAry(m,1); %��������վ�ľ���
                C.m_dbPathLength=C.m_dbPathLength+DAry(1,n); %����������վ���³���
                dbW=CITYWAry(n);  %������������ڸ������������          
            else %û�г�������
                C.m_dbPathLength=C.m_dbPathLength+DAry(m,n); %����һ�����㵽������ľ���
                dbW=dbW+CITYWAry(n); %������������ϸ������������                
            end                
        end

        C.m_dbPathLength=C.m_dbPathLength+DAry(n,1); %���ϴ�������㷵������վ�ľ���      
    
        f4=0;
    end


    
    %========================================================
    %���Ͻ�������
    
    Init();
    
	%�������ȥ������������С�������������ͼ����ƶ�
    while (C.m_nMovedCityCount < CITY_COUNT)
        Move();
    end


	%�������������߹���·������
	CalPathLength();    
    
    %========================================================
    %��������
    
end
