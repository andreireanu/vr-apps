function [ sec, secInt, countSecRec ]= calcSec( BW, M, sizeX, sizeY)
% sec = nr de sec petrecute pe AOI
% secInt = dupa cate secunde sta o secunda in zona de interes ( secunde
% intersectie)
% secRec = secunde consecutive petrecute intr-un AOI. Dupa iesirea din AOI
% secRec se reseteaza
% countSecRec = de cate ori a intrat in AOI si a stat minim o secunda
 
sec = 0;
secInt = 0;
secRec = 0;
countSecRec = 0;
for i = 1:length(M(3,:))-1
     a = floor(M(2,i) * sizeY) + 1;
     b = floor(M(3,i) * sizeX) + 1;
     aNext = floor(M(2,i+1) * sizeY) + 1;
     bNext = floor(M(3,i+1) * sizeX) + 1;
     
     if ( BW(sizeX + 1 - b,a) == 1) 
         sec = sec +1;
         secRec = secRec + 1;
         if ( sec == 90 )
             secInt = i;
         end
         if ( secRec >= 90 &&   BW(sizeX + 1 - bNext,aNext) == 0 )
             secRec = 0;
             countSecRec = countSecRec + 1;
         end 
     end
     
     if ( BW(sizeX + 1 - b,a) == 0)
         secRec = 0;
     end 
     
end
sec=sec/90;
secInt = secInt/90;

end

