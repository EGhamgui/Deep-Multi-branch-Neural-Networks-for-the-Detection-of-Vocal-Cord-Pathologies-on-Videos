folder_path= 'C:/Users/USER/Desktop/stage ing/Stage ing partie 5/data_image/';
foldet_path1='C:/Users/USER/Desktop/stage ing/Stage ing partie 5/pred_abd/';

d=dir([folder_path]);
totalfile=length(d);
f1={d.name};
tic
for i=3 : 23

    path1 = strcat(folder_path,char(f1(i)));
    path2= strcat(foldet_path1,char(f1(i)));
    mkdir(path2); 
    [S_P,frame_size]= Main(path1,path2,0.3,160,2);
end 
fprintf('Elapsed time = %.2f ms.\n', toc /20 );