folder_path='C:/Users/USER/SummerInternship/';
list={'train_1_aux','test_1_aux','val_1_aux'};
for i=1:length(list)
   path= strcat(folder_path , list(i),'/');
   d = dir(path{1,1}) ;
   f={d.name};
   
   for j=3:length(f)
       path1=char(strcat(path,f(j),'/'));
       d1=dir([path1 '*.png']);
       f1={d1.name};
       totalfile=length(f1);
       path_out= char(strcat(folder_path ,'out_',list(i),'/'));
       mkdir(path_out,char(f(j)));  
       mkdir(path_out,char(f(j)),'_edge'); 
       
       for k = 1:totalfile                   
           fullname = char(strcat(path1 ,char(f1{k})));
           image = imread(fullname);
           [x1,y1] = size(image);
           image1=zeros(x1,y1);
           for h=1:x1
               for l=1:y1
                   if image(h,l)==1
                       image1(h,l)=255;
                   end
               end
           end 
           fullname = fullfile(path_out,char(f(j)),char(f1{k}));
           imwrite(image1,fullname);
           radius=2;
           tolerence=0.3;
           [I_post_proc] = morphological(image1,radius);
           [x,y] = seedpoint(image1);
           [image2,a1] = segCroissRegion(tolerance,I_post_proc,x,y); 
           fullname1 = fullfile(path_out1,char(f(j)),char(f1{k}));
           imwrite(image2,fullname1);
       end
   end     
end

