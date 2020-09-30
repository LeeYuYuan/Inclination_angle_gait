function New_COM = COM_function(time, L_shoulder, R_shoulder, L_elbow, R_elbow, L_hand, R_hand, L_knee, R_knee, L_ankle, R_ankle,hip_center, L_hip_center, R_hip_center, sex)

P = zeros(3, time);

if sex == 1 %male
    
   % Forearms
   %P = P + 2.3 * (L_elbow + 0.6364*(L_hand - L_elbow));
   %P = P + 2.3 * (R_elbow + 0.6364*(R_hand - R_elbow));

    %Upper arms
    P = P + 2.4 * (L_shoulder + 0.5437*(L_elbow - L_shoulder));
    P = P + 2.4 * (R_shoulder + 0.5437*(R_elbow - R_shoulder));

    %Torso
    shoulder_center = 0.5*(L_shoulder + R_shoulder);
    P = P + 54.3 * (shoulder_center + 0.3705*(hip_center - shoulder_center));

    %Upper legs
    P = P + 12.3 * (L_hip_center + 0.426*(L_knee - L_hip_center));
    P = P + 12.3 * (R_hip_center + 0.426*(R_knee - R_hip_center));

    %Lower legs 
    P = P + 6 * (L_knee + 0.5369*(L_ankle - L_knee));
    P = P + 6 * (R_knee + 0.5369*(R_ankle - R_knee));
    
    New_COM = P/100;

elseif sex == 2 %female		 
    %Forearms
    %P = P + 1.8 * (L_elbow + 0.6377*(L_hand - L_elbow));
    %P = P + 1.8 * (R_elbow + 0.6377*(R_hand - R_elbow));

    %Upper arms
    P = P + 2.2 * (L_shoulder + 0.5664*(L_elbow - L_shoulder));
    P = P + 2.2 * (R_shoulder + 0.5664*(R_elbow - R_shoulder));

    %Torso
    shoulder_center = 0.5*(L_shoulder + R_shoulder);
    P = P + 51.7 * (shoulder_center + 0.3806*(hip_center - shoulder_center));

    %Upper legs
    P = P + 14.6 * (L_hip_center + 0.3812*(L_knee - L_hip_center));
    P = P + 14.6 * (R_hip_center + 0.3812*(R_knee - R_hip_center));

    %Lower legs 
    P = P + 5.5 * (L_knee + 0.5224*(L_ankle - L_knee));
    P = P + 5.5 * (R_knee + 0.5224*(R_ankle - R_knee));

    New_COM = P/100;
end