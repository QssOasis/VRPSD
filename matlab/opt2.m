%�Խ������2-OPT�Ż�
function f=opt2(Line)
  
    %���鳤��
    size=length(Line);
    
    NewLine=Line; % ���ؽ�������ó�ԭ��·��
    
    Flag=1;
    
    while (Flag == 1)
        Flag=0;
        
		for i=1:size-2
			a=Line(1,1:i); %·��ǰ��
			b=fliplr(Line(1,i+1:size)); %·����ε���        
			c=cat(2,a,b); %��·��       
	        
			%��·�����þ��滻
			if (PathLength(c)<PathLength(NewLine))
				NewLine=c;
				Flag=1;
				fprintf('\n======================= 2-OPT �Ż��ɹ�! ===');
            end
            
        end    
        
    end
           
        
    %���ؽ��
    f=NewLine;
    
end