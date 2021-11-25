function [] = editKv(motorfile,Reduction_Ratio)
% Modify motor parameters and write modified file under new name 'XXX_edit'
motorfile = ['.\runs\',motorfile];

Fileid = fopen(motorfile,'rt') ;
datastring = fread(Fileid,'*char') ;
fclose(Fileid) ;

%Rewrite Kv line, modified by Reduction_ratio
lineid  = strfind(datastring','! Kv');
endels   = strfind(datastring', sprintf('\n'));
startel = endels(find(endels<=lineid,1,'last'))+1;
endel   = endels(find(endels>=lineid,1,'first'))-1;
Kv_old  = sscanf(datastring(startel:endel)','%f');
Kv_new  = Kv_old/Reduction_Ratio;
Newline = [sprintf('\n'), sprintf('\n'), num2str(Kv_new),...
           '   ! Kv     (rpm/Volt)', sprintf('\n')];
datastring = strcat(datastring(1:startel-1)',...
             Newline)';

motorfile_edit = [motorfile,'_edit'];
Fileid2 = fopen(motorfile_edit,'wt') ;
fwrite(Fileid2,datastring) ;
fclose (Fileid2) ;