%�����෵������ֵ����
function f=get(C,prop_name)

    switch prop_name
        
        case 'path' %�õ�����������·��
            f=C.m_nPathAry;
        
        case 'path_length' %�õ�����������·������
            f=C.m_dbPathLength;
        
        otherwise %�Ƿ����ԣ����ش���
            error([prop_name,'������Ŀ������ԣ�']);           
        
end  