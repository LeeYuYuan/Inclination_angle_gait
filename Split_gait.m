function [ICr1, TOr1, ICr2 , TOr2, ICr3, ICl1 , TOl1, ICl2, TOl2, FRONT, BACK, COP_first_step, COP_second_step, COP_third_step, COP_forth_step, F1, F2, F3] = Split_gait (name, frq)
  
FP1_data = name.Force(1).COP;
FP2_data = name.Force(2).COP;
FP3_data = name.Force(3).COP;
FP4_data = name.Force(4).COP;
FP5_data = name.Force(5).COP;
FP6_data = name.Force(6).COP;
FP7_data = name.Force(7).COP;


% store force data
FP1_data_Force = name.Force(1).Force;
FP2_data_Force = name.Force(2).Force;
FP3_data_Force = name.Force(3).Force;
FP4_data_Force = name.Force(4).Force;
FP5_data_Force = name.Force(5).Force;
FP6_data_Force = name.Force(6).Force;
FP7_data_Force = name.Force(7).Force;

data_len = length(FP1_data);
FP = zeros(6, data_len);

% corresponding time
frq = length(FP1_data) / length(name.Trajectories.Labeled.Data(26,1,:));
time = data_len / frq;

% form the COP matrix for 6 force plate

FP1_xyz = FP1_data(:,(1:frq:length(FP1_data)));
FP2_xyz = FP2_data(:,(1:frq:length(FP2_data)));
FP3_xyz = FP3_data(:,(1:frq:length(FP3_data)));
FP4_xyz = FP4_data(:,(1:frq:length(FP4_data)));
FP5_xyz = FP5_data(:,(1:frq:length(FP5_data)));
FP6_xyz = FP6_data(:,(1:frq:length(FP6_data)));
FP7_xyz = FP7_data(:,(1:frq:length(FP7_data)));



% form the force matrix for 6 force plate
FP1_xyz_Force = FP1_data_Force(:,(1:frq:length(FP1_data)));
FP2_xyz_Force = FP2_data_Force(:,(1:frq:length(FP2_data)));
FP3_xyz_Force = FP3_data_Force(:,(1:frq:length(FP3_data)));
FP4_xyz_Force = FP4_data_Force(:,(1:frq:length(FP4_data)));
FP5_xyz_Force = FP5_data_Force(:,(1:frq:length(FP5_data)));
FP6_xyz_Force = FP6_data_Force(:,(1:frq:length(FP6_data)));
FP7_xyz_Force = FP7_data_Force(:,(1:frq:length(FP7_data)));


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
FP1load=find(name.Force(1).Force(3,:)< -20);
FP2load=find(name.Force(2).Force(3,:)< -20);
FP3load=find(name.Force(3).Force(3,:)< -20);
FP4load=find(name.Force(4).Force(3,:)< -20);
FP5load=find(name.Force(5).Force(3,:)< -20);
FP6load=find(name.Force(6).Force(3,:)< -20);
FP7load=find(name.Force(7).Force(3,:)< -20);

       %
       FRONT = 0;
       BACK  = 1;
        if ~isempty(FP1load) && FP1load(1) < 1000 || ~isempty(FP2load) && FP2load(1) < 1000
           BACK  = 0;
           FRONT = 1;
        end
        if ~isempty(FP1load) && FP1load(1) < 200
           BACK  = 0;
           FRONT = 1;
        end
        if  ~isempty(FP2load) && FP2load(1) < 200
           BACK  = 0;
           FRONT = 1;
        end
        if ~isempty(FP5load) && FP5load(1) < 200
           BACK  = 1;
           FRONT = 0;
        end
        if ~isempty(FP6load) && FP6load(1) < 200
           BACK  = 1;
           FRONT = 0;
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
             COP_first_step = FP1_xyz; 
             F1 = FP1_xyz_Force;
         else
             ICr1 = FP2load(1);
             TOr1 = FP2load(end);
             %OptICr1b= ICr1;
             %OptTOr1b= TOr1;
             COP_first_step = FP2_xyz; 
             F1 = FP2_xyz_Force;
         end
         %
         if ~isempty(FP1load) && isempty(FP3load) && ~isempty(FP2load)
              ICr2 = FP2load(1);
              %OptICr2a=ICr2
              TOr2 = FP2load(end);
              COP_third_step = FP2_xyz; 
              F3 = FP2_xyz_Force;
         end 
         if ~isempty(FP1load) && ~isempty(FP2load) && ~isempty(FP3load) && FP2load(1) < FP3load(1)
             ICr2 = FP2load(1);
             %OptICr2b=ICr2
             TOr2 = FP3load(end);
             COP_third_step = FP2_xyz; 
             F3 = FP2_xyz_Force;
         end
          if ~isempty(FP1load) && ~isempty(FP2load) && ~isempty(FP3load) && FP2load(end) < FP3load(1)
             ICr2 = FP3load(1);
             %OptICr2b=ICr2
             TOr2 = FP3load(end);
             COP_third_step = FP3_xyz; 
             F3 = FP3_xyz_Force;
         end
         if  isempty(FP1load)|| isempty(FP2load) && ~isempty(FP3load)
             ICr2 = FP3load(1); 
             %OptICr2c=ICr2
             TOr2 = FP3load(end);
             COP_third_step = FP3_xyz; 
             F3 = FP3_xyz_Force;
         end
         %
         ICr3 = length(name.Force(1).Force(3,:));
         %
         % left foot FRONT
        if ~isempty(FP4load) && FP4load(end) > 300
            ICl1 = FP4load(1);
            COP_second_step = FP4_xyz; 
            F2 = FP4_xyz_Force;
            %OptICl1a= ICl1
        end
        if ~isempty(FP4load) && FP4load(end) < 300 && ~isempty(FP5load) 
            ICl1 = FP5load(1);
            COP_second_step = FP5_xyz; 
            F2 = FP5_xyz_Force;
            %OptICl1b= ICl1
        end
         if ~isempty(FP4load) && FP4load(end) > 300 && isempty(FP5load)
             TOl1 = FP4load(end);
             COP_second_step = FP4_xyz; 
             F2 = FP4_xyz_Force;
             %OptTOl1a= TOl1
         end
         if ~isempty(FP5load) && FP5load(1) > FP4load(end) && FP4load(end) <1500 && length(FP4load) > 200
             TOl1 = FP4load(end);
             COP_second_step = FP4_xyz; 
             F2 = FP4_xyz_Force;
             %OptTOl1b= TOl1
         end
         if ~isempty(FP5load) && FP5load(1) < FP4load(end) && FP4load(end) < 1500
             TOl1 = FP5load(end);
             COP_second_step = FP5_xyz; 
             F2 = FP5_xyz_Force;
             %OptTOl1c= TOl1
         end
         if ~isempty(FP5load) && FP5load(1) > FP4load(end) && FP4load(end) <1500 && length(FP4load) < 200
             TOl1 = FP5load(end);
             COP_second_step = FP5_xyz; 
             F2 = FP5_xyz_Force;
             %OptTOl1b= TOl1
         end
         % 2nd step left
         if ~isempty(FP6load) 
             ICl2 = FP6load(1);
             COP_forth_step = FP6_xyz; 
             %OptICl2a=ICl2;
         end
         %
          if isempty(FP6load) && ~isempty(FP5load)
              ICl2 = FP5load(1);
              COP_forth_step = FP5_xyz; 
              %OptICl2b=ICl2;
              TOl2 = FP5load(end);
         end 
         if ~isempty(FP5load) && ~isempty(FP6load) && FP5load(end) > FP6load(1)
             ICl2 = FP5load(1);
             COP_forth_step = FP5_xyz; 
             %OptICl2c = ICl2;
             TOl2 = FP6load(end);
         end
         if isempty(FP5load) && ~isempty(FP6load) 
             ICl2 = FP6load(1);
             TOl2 = FP6load(end);
             COP_forth_step = FP6_xyz; 
         end
         if ~isempty(FP5load) && ~isempty(FP6load) &&  FP5load(end) < FP6load(end)
             ICl2 = FP6load(1);
             TOl2 = FP6load(end);
             COP_forth_step = FP6_xyz; 
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
                COP_first_step = FP7_xyz; 
                %COP_second_step = FP3_xyz;
                %COP_third_step = FP5_xyz; 
                %COP_forth_step = FP2_xyz;
                F1 = FP7_xyz_Force;
                %F2 = FP3_xyz_Force;
                %F3 = FP5_xyz_Force;

            end
            if ~isempty(FP6load) && isempty(FP7load)
                ICr1 = FP6load(1); 
                COP_first_step = FP6_xyz; 
                F1 = FP6_xyz_Force;

            end
            if ~isempty(FP7load)
                TOr1 = FP7load(end);
                COP_first_step = FP7_xyz; 
                F1 = FP7_xyz_Force;
            end
            if ~isempty(FP6load) && ~isempty(FP7load) && length(FP6load) > length(FP7load)
                 TOr1 = FP6load(end);
                 COP_first_step = FP6_xyz; 
                 F1 = FP6_xyz_Force;
            end
            if ~isempty(FP6load) && isempty(FP7load)
                 TOr1 = FP6load(end);
                 COP_first_step = FP6_xyz; 
                 F1 = FP6_xyz_Force;
            end
            if isempty(FP6load) && isempty(FP7load)
                ICr1 = FP5load(1);
                TOr1 = FP5load(end);
                COP_first_step = FP5_xyz; 
                F1 = FP5_xyz_Force;
            end
            if ~isempty(FP6load) && ~isempty(FP7load) && FP6load(1) > FP7load(end)
                 ICr2 = FP6load(1);
                 COP_third_step = FP6_xyz; 
                 F3 = FP6_xyz_Force;
            end
            if ~isempty(FP5load) && ~isempty(FP6load)
                  ICr2 = FP5load(1);
                  COP_third_step = FP5_xyz; 
                  F3 = FP5_xyz_Force;
            end
            if isempty(FP5load) && ~isempty(FP4load)
                  ICr2 = FP4load(1);
                  COP_third_step = FP4_xyz; 
                  F3 = FP4_xyz_Force;
            end
            if ~isempty(FP5load) && ~isempty(FP4load) && FP4load(1) > FP5load(1) && length(FP4load) >length(FP5load) 
                  ICr2 = FP4load(1);
                  TOr2 = FP4load(end);
                  COP_third_step = FP4_xyz; 
                  F3 = FP4_xyz_Force;
            end
            if  isempty(FP5load) && isempty(FP4load)
                  TOr2 = FP6load(end);
                  COP_third_step = FP6_xyz; 
                  F3 = FP6_xyz_Force;
            end
            if  ~isempty(FP5load)  && ~isempty(FP6load)
                 TOr2 = FP5load(end);
                 COP_third_step = FP5_xyz; 
                 F3 = FP5_xyz_Force;
            end
            if  isempty(FP5load) && ~isempty(FP4load)
                 TOr2 = FP4load(end);
                 COP_third_step = FP4_xyz; 
                 F3 = FP4_xyz_Force;
            end
            if ~isempty(FP4load) && ~isempty(FP5load) && FP4load(end) < 3300 && FP4load(end) > FP5load(end) && length(FP4load) >length(FP5load)
                 TOr2 = FP4load(end);
                 COP_third_step = FP4_xyz; 
                 F3 = FP4_xyz_Force;
            end
            %
            ICr3 = length(name.Force(1).Force(3,:));
         %
         % left foot BACK
            
            if ~isempty(FP2load) 
             ICl1 = FP2load(1);
             TOl1 = FP2load(end);
             COP_second_step = FP2_xyz; 
             F2 = FP2_xyz_Force;
            end
            
            if ~isempty(FP4load) && isempty(FP2load)
             ICl1 = FP4load(1);
             TOl1 = FP4load(end);
             COP_second_step = FP4_xyz; 
             F2 = FP4_xyz_Force;
            end
            
            if ~isempty(FP4load) && ~isempty(FP2load) && FP4load(1) < FP2load(1)
             ICl1 = FP4load(1);
             TOl1 = FP4load(end);
             COP_second_step = FP4_xyz; 
             F2 = FP4_xyz_Force;
            end
            
            if ~isempty(FP3load) && length(FP3load) > 200
             ICl1 = FP3load(1);
             TOl1 = FP3load(end);
             COP_second_step = FP3_xyz; 
             F2 = FP3_xyz_Force;
            end
            
            if ~isempty(FP2load) 
                ICl2 = FP2load(1);
                COP_forth_step = FP2_xyz; 
            end
            if ~isempty(FP1load) && isempty(FP2load)
                ICl2 = FP1load(1);
                COP_forth_step = FP1_xyz; 
            end
             if ~isempty(FP1load) && ~isempty(FP2load) && FP1load(end) > FP2load(end)
                 ICl2 = FP2load(1);
                 COP_forth_step = FP2_xyz; 
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
            % if isempty(TOl2,ICr3)
            %     TOl2 = NaN;
             %end
         %
     end % BACK  
     %
     % Recalculate events from Force Plate freq to Qualisys freq: FreqQ/FreqFP
     ICr1 = ceil(ICr1/ frq);
       if ICr1 < 1
          ICr1 =1;
       end
     TOr1 = ceil(TOr1 / frq);
     ICr2 = ceil(ICr2 / frq);
     TOr2 = ceil(TOr2 / frq);
     %ICr3 = round(ICr3 / frq);
     ICl1 = ceil(ICl1 / frq);
     TOl1 = ceil(TOl1 / frq);
     ICl2 = ceil(ICl2 / frq);
     TOl2 = ceil(TOl2 / frq);
%
% function
end