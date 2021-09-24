folder_path='C:/Users/USER/Desktop/stage ing/Stage ing partie 5/pred_bagls/Pred/';
S_P= 1/4000 ;
d=dir([folder_path]);
f={d.name};
for j=3:730
    path1=char(strcat(folder_path,f(j),'/'));
    [matrix]=Main2(path1,1,S_P);
    s=size(matrix);
    if ((s(1) == 0)&(s(2)==0))
        val = zeros(1,15); 
    else 
        [Ratio_matrix,Ratio_matrix1,gaw]=ratios(matrix,S_P);
        val = cat(2,Ratio_matrix,Ratio_matrix1);
        val(isnan(val))=0;
        val(isinf(val))=0;
    end
    dlmwrite('C:/Users/USER/Desktop/stage ing/stage ing partie 5/ratios.csv',val,'-append');              
end
    
    
    
    
