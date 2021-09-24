function [matrix]=Main2(Folder_path_seg,N,S_P)
%this function is the main function for the part of analysing the symmetry motion 
%of vocal folds using top and lowest method 
%the inputs are the folder (Folder_path_seg) conatains the segmented frames
%|N the number of lines you wante |S_P the sampling period of the video
%the ouput is a matrix conatins the movement of each two opposing points 
  drs=Folder_path_seg;                                             
  dr1=dir([drs '/*.png']);                                        
  f1={dr1.name};
  k=0;
  for c=1:length(f1)
      image = [drs '/' f1{c}] ;
      im = imread(image); 
      size(im);
      I = rgb2gray(im);
      s=sum(sum(I));
     
      if s~=0
          k = k+1 ; 
          [BW1]=seg1(image);
          [pc,ac]=ac_pc_top_lowest_method(BW1); 
          [x,y,v]=orthog_lines(pc,ac,N);
          [d]=opposing_edges_points(BW1,x,y,v,N);
          [sr,sl]=Area_indicator(BW1,pc,ac);
          S=[sr,sl];
          if (k==1)
             matrix=d;
             M_Area=S;
          else
             matrix=[matrix;d];
             M_Area=[M_Area;S];
          end
      end
  end
 if k == 0 
     matrix=[];
 end

  %def_lections(matrix,S_P);
  %area_def_lections(M_Area,S_P);
end