function [ICr1, TOr1, ICr2 , TOr2, ICr3, ICl1 , TOl1, ICl2, TOl2, FRONT, BACK] = Split_gait (name, frq)
  
FP1load=[];
FP2load=[];
FP3load=[];
FP4load=[];
FP5load=[];
FP6load=[];
FP7load=[];
FP8load=[];
      %
  % Determine walking direction Front or Back
  % If load plate 1 or 2 is hit first, the subject is walking towards FRONT
  % If load plate 7 or 8 is hit first, the subject is walking towards BACK
  %
  % FRONT starts with right step on FP1 & BACK starts with right step on FP7
FP1load=find(name.Force(1).Force(3,:)< -5);
FP2load=find(name.Force(2).Force(3,:)< -5);
FP3load=find(name.Force(3).Force(3,:)< -5);
FP4load=find(name.Force(4).Force(3,:)< -5);
FP5load=find(name.Force(5).Force(3,:)< -5);
FP6load=find(name.Force(6).Force(3,:)< -5);
FP7load=find(name.Force(7).Force(3,:)< -5);

       %
       FRONT = 0;
       BACK  = 1;
        if ~isempty(FP1load) && FP1load(1) < 1000 || ~isempty(FP2load) && FP2load(1) < 1000
           BACK  = 0;
           FRONT = 1;
        end
     %
     %
     % *************** WALKING DIRECTION FRONT ************************
     if FRONT 
         disp('front walk')
         % right foot
         if ~isempty(FP1load)
             ICr1 = FP1load(1);
             TOr1 = FP1load(end);
             %OptICr1a= ICr1
             %OptTOr1a= TOr1
         else
             ICr1 = FP2load(1);
             TOr1 = FP2load(end);
             OptICr1b= ICr1;
             OptTOr1b= TOr1;
         end
         %
         if ~isempty(FP1load) && isempty(FP3load) && ~isempty(FP2load)
              ICr2 = FP2load(1);
              %OptICr2a=ICr2
              TOr2 = FP2load(end);
         end 
         if ~isempty(FP1load) && ~isempty(FP2load) && ~isempty(FP3load) && FP2load(1) < FP3load(1)
             ICr2 = FP2load(1);
             %OptICr2b=ICr2
             TOr2 = FP3load(end);
         end
          if ~isempty(FP1load) && ~isempty(FP2load) && ~isempty(FP3load) && FP2load(end) < FP3load(1)
             ICr2 = FP3load(1);
             %OptICr2b=ICr2
             TOr2 = FP3load(end);
         end
         if  isempty(FP1load)|| isempty(FP2load) && ~isempty(FP3load)
             ICr2 = FP3load(1); 
             %OptICr2c=ICr2
             TOr2 = FP3load(end);
         end
         %
         ICr3 = length(name.Force(1).Force(3,:));
         %
         % left foot FRONT
        if ~isempty(FP4load) && FP4load(end) > 300
            ICl1 = FP4load(1);
            %OptICl1a= ICl1
        end
        if ~isempty(FP4load) && FP4load(end) < 300 && ~isempty(FP5load) 
            ICl1 = FP5load(1);
            %OptICl1b= ICl1
        end
         if ~isempty(FP4load) && FP4load(end) > 300 && isempty(FP5load)
             TOl1 = FP4load(end);
             %OptTOl1a= TOl1
         end
         if ~isempty(FP5load) && FP5load(1) > FP4load(end) && FP4load(end) >1500
             TOl1 = FP4load(end);
             %OptTOl1b= TOl1
         end
         %if ~isempty(FP5load) && FP5load(1) < FP4load(end) || FP4load(end) < 1500
          %   TOl1 = FP5load(end);
             %OptTOl1c= TOl1
         %end
         % 2nd step left
         if ~isempty(FP6load) 
             ICl2 = FP6load(1);
             %OptICl2a=ICl2;
         end
         %
          if isempty(FP6load) && ~isempty(FP5load)
              ICl2 = FP5load(1);
              %OptICl2b=ICl2;
              TOl2 = FP5load(end);
         end 
         if ~isempty(FP5load) && ~isempty(FP6load) && FP5load(end) > FP6load(1)
             ICl2 = FP5load(1);
             %OptICl2c = ICl2;
             TOl2 = FP6load(end);
         end
         if isempty(FP5load) && ~isempty(FP6load)
             ICl2 = FP6load(1);
             TOl2 = FP6load(end);
         end
%       
         if ~isempty(FP7load) &&  ~isempty(FP6load) && FP7load(end) > FP6load(end)
             TOl2 = FP7load(end);
%         else
%             TOl2 = FP7load(end);
         end
         %
         if ~isempty(FP7load) && isempty(FP6load)
             ICl2 = FP7load(1);
             TOl2 = FP7load(end);
         end
         %
         if isequal(TOl2,ICr3)
             TOl2 = NaN;
         end
         %
     end % FRONT
     %
     % *************** WALKING DIRECTION BACK ************************
        if BACK 
            disp('back walk')
         % right foot
            if ~isempty(FP7load)
                ICr1 = FP7load(1); 
            end
            if ~isempty(FP6load) && isempty(FP7load)
                ICr1 = FP6load(1);  
            end
            if ~isempty(FP7load)
                TOr1 = FP7load(end);
            end
            if ~isempty(FP6load) && ~isempty(FP7load) && FP6load(1) < FP7load(end)
                 TOr1 = FP6load(end);
            end
            if ~isempty(FP6load) && isempty(FP7load)
                 TOr1 = FP6load(end);  
            end
            if ~isempty(FP6load) && ~isempty(FP7load) && FP6load(1) > FP7load(end)
                 ICr2 = FP6load(1);
            end
            if ~isempty(FP5load)
                  ICr2 = FP5load(1);
            end
            if isempty(FP5load) && ~isempty(FP4load)
                  ICr2 = FP4load(1);
            end
            if  isempty(FP5load) && isempty(FP4load)
                  TOr2 = FP6load(end);
            end
            if  ~isempty(FP5load)
                 TOr2 = FP5load(end);
            end
            if  isempty(FP5load) && ~isempty(FP4load)
                 TOr2 = FP4load(end);
            end
            if ~isempty(FP4load) && ~isempty(FP5load) && FP4load(end) < 3300 && FP4load(end) > FP5load(end)
                 TOr2 = FP4load(end);
            end
            %
            ICr3 = length(name.Force(1).Force(3,:));
         %
         % left foot BACK
             ICl1 = FP3load(1);
             TOl1 = FP3load(end);
             %
            if ~isempty(FP2load) 
                ICl2 = FP2load(1);
            end
            if ~isempty(FP1load) && isempty(FP2load)
                ICl2 = FP1load(1);
            end
             if ~isempty(FP1load) && ~isempty(FP2load) && FP1load(end) > FP2load(end)
                 ICl2 = FP2load(1);
             end
             %
             if ~isempty(FP2load)
                TOl2 = FP2load(end);
             end
             if ~isempty(FP1load) && isempty(FP2load)
                TOl2 = FP1load(end);
            end
             if ~isempty(FP1load) && ~isempty(FP2load) && FP1load(end) > FP2load(end)
                 TOl2 = FP1load(end);
             end
             if isequal(TOl2,ICr3)
                 TOl2 = NaN;
             end
         %
        end % BACK  
     %
     % Recalculate events from Force Plate freq to Qualisys freq: FreqQ/FreqFP
     ICr1 = round(ICr1/ frq);
       if ICr1 < 1
          ICr1 =1;
       end
     TOr1 = round(TOr1 / frq);
     ICr2 = round(ICr2 / frq);
     TOr2 = round(TOr2 / frq);
     ICr3 = round(ICr3 / frq);
     ICl1 = round(ICl1 / frq);
     TOl1 = round(TOl1 / frq);
     ICl2 = round(ICl2 / frq);
     TOl2 = round(TOl2 / frq);
%
% function
end