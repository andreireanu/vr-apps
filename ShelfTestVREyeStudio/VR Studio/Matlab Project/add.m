function [ hmAdd ] = add( M, sizeX, sizeY )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

 
hm = zeros(sizeX,sizeY);
hmAdd = zeros(sizeX,sizeY); 
 

for i = 1:length(M(3,:))
     a = floor(M(2,i) * sizeY) + 1;
     b = floor(M(3,i) * sizeX) + 1;
     if ( a ~= 1 && b ~= 1 ) 
     hm(sizeX + 1 - b,a) = hm(sizeX + 1 - b,a) + 1;
     end
end
 
maxim = max(hm(:));
hm = hm / maxim;


ksize = 51; % marime nucleu gaussian
 
for i = 1:sizeX
    for j = 1:sizeY
        if ( hm(i,j) ~= 0  )
            add = gaussian_filter(ksize,1); 
              for x = 1:ksize
                  for y = 1:ksize
                      if ( i+x-(ksize-1)/2 > 0  && j+y-(ksize-1)/2 > 0 && i+x-(ksize-1)/2 < sizeX+1 && j+y-(ksize-1)/2 < sizeY+1 )
                          hmAdd(i+x-(ksize-1)/2,j+y-(ksize-1)/2) =  hmAdd(i+x-(ksize-1)/2,j+y-(ksize-1)/2) + add(x,y) ;
                      end
                  end   
              end       
        end
    end
end

end

