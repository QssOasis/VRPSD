%�����๹�캯��

function C=ant()
   
    global CITY_COUNT;

	C.m_dbPathLength=0; %�����߹���·������
	C.m_nCurCityNo=0; %��ǰ����������
	C.m_nMovedCityCount=0; %�Ѿ�ȥ������������

    C.m_nPathAry=zeros(1,CITY_COUNT); %�����ߵ�·��
	C.m_nAllowedCityAry=zeros(1,CITY_COUNT); %ûȥ��������
    
    C=class(C,'ant'); 
    
end
  