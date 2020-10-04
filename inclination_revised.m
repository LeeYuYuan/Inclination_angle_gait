%% load the data

subject = ('Gait_0001_2');
subjfile = [(subject),'.mat'];
load(subjfile);

R_data = load(subject);
name = Gait_0001_2;

%% analyze anterior-posterior inclination angle: coordination = 1
%  analyze medial-lateral incliantion angle: coordination = 2
coordination = 2 ;% 1: anterior-posterior, 2: medial-lateral, 3: up and down

%% store COP datat
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


%% Calculate the COM
%%%find the marker
path = name.Trajectories.Labeled.Labels;

LPSI_position = find(strcmp( path, 'LPSI'));
RPSI_position = find(strcmp( path, 'RPSI'));
LASI_position = find(strcmp( path, 'LASI'));
RASI_position = find(strcmp( path, 'RASI'));
LSHO_position = find(strcmp( path, 'LSHO'));
RSHO_position = find(strcmp( path, 'RSHO'));
LELL_position = find(strcmp( path, 'LELL'));
RELL_position = find(strcmp( path, 'RELL'));
LWRR_position = find(strcmp( path, 'LWRR'));
RWRR_position = find(strcmp( path, 'RWRR'));
LFLE_position = find(strcmp( path, 'LFLE'));
RFLE_position = find(strcmp( path, 'RFLE'));
LLMAL_position = find(strcmp( path, 'LLMAL'));
RLMAL_position = find(strcmp( path, 'RLMAL'));


%%
% 1: anterior-posterior, 2: medial-lateral, 3: up and down
LPSI_data = name.Trajectories.Labeled.Data(LPSI_position,1:3,:);
RPSI_data = name.Trajectories.Labeled.Data(RPSI_position,1:3,:);
LASI_data = name.Trajectories.Labeled.Data(LASI_position,1:3,:);
RASI_data = name.Trajectories.Labeled.Data(RASI_position,1:3,:);
LSHO_data = name.Trajectories.Labeled.Data(LSHO_position,1:3,:);
RSHO_data = name.Trajectories.Labeled.Data(RSHO_position,1:3,:);
LELL_data = name.Trajectories.Labeled.Data(LELL_position,1:3,:);
RELL_data = name.Trajectories.Labeled.Data(RELL_position,1:3,:);
%LWRR_data = name.Trajectories.Labeled.Data(LWRR_position,1:3,:);
%RWRR_data = name.Trajectories.Labeled.Data(RWRR_position,1:3,:);
LFLE_data = name.Trajectories.Labeled.Data(LFLE_position,1:3,:);
RFLE_data = name.Trajectories.Labeled.Data(RFLE_position,1:3,:);
LLMAL_data = name.Trajectories.Labeled.Data(LLMAL_position,1:3,:);
RLMAL_data = name.Trajectories.Labeled.Data(RLMAL_position,1:3,:);

%%
LPSI_data = reshape(LPSI_data, [3, time]);
RPSI_data = reshape(RPSI_data, [3,time]);
LASI_data = reshape(LASI_data, [3,time]);
RASI_data = reshape(RASI_data, [3,time]);
LSHO_data = reshape(LSHO_data, [3,time]);
RSHO_data = reshape(RSHO_data, [3,time]);
LELL_data = reshape(LELL_data, [3,time]);
RELL_data = reshape(RELL_data, [3,time]);
%LWRR_data = reshape(LWRR_data, [3,time]);
%RWRR_data = reshape(RWRR_data, [3,time]);
LFLE_data = reshape(LFLE_data, [3,time]);
RFLE_data = reshape(RFLE_data, [3,time]);
LLMAL_data = reshape(LLMAL_data, [3,time]);
RLMAL_data = reshape(RLMAL_data, [3,time]);


%%
LASI = LASI_data;
LPSI = LPSI_data;
RASI = RASI_data;
RPSI = RPSI_data;

% calculate the hip marker position
[hip_center, L_hip_center, R_hip_center] = hip_markers(LASI, LPSI, RASI, RPSI);

% store the position data from each marker
L_shoulder  = LSHO_data;
R_shoulder  = RSHO_data;
L_elbow     = LELL_data;
R_elbow     = RELL_data;
L_hand      = "missing_marker";
R_hand	    = "missing_marker";
L_knee	    = LFLE_data;
R_knee      = RFLE_data;
L_ankle	    = LLMAL_data;
R_ankle     = RLMAL_data;
hip_center = hip_center;
L_hip_center = L_hip_center;
R_hip_center = R_hip_center;


New_COM = COM_function(time, L_shoulder, R_shoulder, L_elbow, R_elbow, L_hand, R_hand, L_knee, R_knee, L_ankle, R_ankle,hip_center, L_hip_center, R_hip_center, 1);



%% calculate the angle between the vector (COP*CPM) and the projecting product on sagittal plane (1, 0, 1)

% before this step, please decide the step of the gait
% create the vector of COP * COM
COM =  New_COM;
[ICr1, TOr1, ICr2 , TOr2, ICr3, ICl1 , TOl1, ICl2, TOl2, FRONT, BACK] = Split_gait(name, frq);

if BACK 
    COP_first_step = FP6_xyz; 
    COP_second_step = FP3_xyz;
    COP_third_step = FP5_xyz; 
    COP_forth_step = FP2_xyz;
end

if FRONT 
    COP_first_step = FP1_xyz; 
    COP_second_step = FP4_xyz;
    COP_third_step = FP2_xyz; 
    COP_forth_step = FP6_xyz;
end

COP_1 = COP_first_step;
COP_2 = COP_second_step;
COP_3 = COP_third_step;
COP_4 = COP_forth_step;


values_1 = zeros(1,time);
for i = 1:time
    values_1(1,i) = (COP_1(coordination,i)-COM(coordination,i))/(-(COM(3,i)));
end
angle_1 = atand(values_1);

values_2 = zeros(1,time);
for i = 1:time
    values_2(1,i) = (COP_2(coordination,i)-COM(coordination,i))/(-(COM(3,i)));
end
angle_2 = atand(values_2);

values_3 = zeros(1,time);
for i = 1:time
    values_3(1,i) = (COP_3(coordination,i)-COM(coordination,i))/(-(COM(3,i)));
end
angle_3 = atand(values_3);

values_4 = zeros(1,time);
for i = 1:time
    values_4(1,i) = (COP_4(coordination,i)-COM(coordination,i))/(-(COM(3,i)));
end
angle_4 = atand(values_4);

%figure

%plot(angle_1)
%hold on
%plot(angle_2)
%hold on
%plot(angle_3)
%hold on
%plot(angle_4)
%hold on


%% calculation of the COP during double stance phase: P1 * ( F1 / (F1 + F2) ) + P2 * ( F2 / (F1 + F2) )

values_Fdouble = zeros(1,time);
if BACK
    for i = ICl1:TOr1
        values_Fdouble(1,i) = (((COP_1(coordination,i)).*(FP6_xyz_Force(3,i))./(FP6_xyz_Force(3,i) + FP3_xyz_Force(3,i))) +  ((COP_2(coordination,i)).*(FP3_xyz_Force(3,i))./(FP6_xyz_Force(3,i) + FP3_xyz_Force(3,i)))-COM(coordination,i))/(-(COM(3,i)));
    end
    angle_first_double = atand(values_Fdouble);

    values_Sdouble = zeros(1,time);

    for i = ICr2:TOl1
        values_Sdouble(1,i) = (((COP_2(coordination,i)).*(FP3_xyz_Force(3,i))./(FP3_xyz_Force(3,i) + FP5_xyz_Force(3,i))) +  ((COP_3(coordination,i)).*(FP5_xyz_Force(3,i))./(FP3_xyz_Force(3,i) + FP5_xyz_Force(3,i)))-COM(coordination,i))/(-(COM(3,i)));
    end
    angle_second_double = atand(values_Sdouble);
end

if FRONT
    for i = ICl1:TOr1
        values_Fdouble(1,i) = (((COP_1(coordination,i)).*(FP1_xyz_Force(3,i))./(FP1_xyz_Force(3,i) + FP4_xyz_Force(3,i))) +  ((COP_2(coordination,i)).*(FP4_xyz_Force(3,i))./(FP1_xyz_Force(3,i) + FP4_xyz_Force(3,i)))-COM(coordination,i))/(-(COM(3,i)));
    end
    angle_first_double = atand(values_Fdouble);

    values_Sdouble = zeros(1,time);

    for i = ICr2:TOl1
        values_Sdouble(1,i) = (((COP_2(coordination,i)).*(FP4_xyz_Force(3,i))./(FP4_xyz_Force(3,i) + FP2_xyz_Force(3,i))) +  ((COP_3(coordination,i)).*(FP2_xyz_Force(3,i))./(FP4_xyz_Force(3,i) + FP2_xyz_Force(3,i)))-COM(coordination,i))/(-(COM(3,i)));
    end
    angle_second_double = atand(values_Sdouble);
end



%% plot inclination angle
total_step = zeros(1,time);

%first step
for i = ICr1+2:(ICl1-1)
    total_step(1,i) = angle_1(1,i);
end

%first double stance
for i = ICl1:TOr1
    
    total_step(1,i) = angle_first_double(1,i);
end

%second step
for i = (TOr1+1):(ICr2-1)
    total_step(1,i) = angle_2(1,i);
end

%second double stance
for i = ICr2:TOl1
    total_step(1,i) = angle_second_double(1,i);
end

%third step
for i = (TOl1+1):(ICl2-21)
    total_step(1,i) = angle_3(1,i);
end

figure

plot(total_step)

figure 

plot(angle_1)
hold on
plot(angle_2)
hold on
plot(angle_3)
hold on
plot(angle_4)
hold on
plot(total_step)

%% find the maximum inclination angle for anterior, posterior and medial direction
if BACK
    if coordination == 1
        stotal_step = normalize(total_step);
        [Maxima,MaxIdx] = findpeaks(total_step(180:end),'MinPeakProminence',2.5);
        mean_ante_inclina = mean(Maxima);

        stotal_step = normalize(total_step);
        [Maxima,MaxIdx] = findpeaks(-total_step(180:end),'MinPeakHeight', 0, 'MinPeakProminence',1.1);
        mean_poste_inclina = mean(Maxima);
    end
        
    if coordination == 2
        stotal_step = normalize(total_step);
        [Maxima,MaxIdx] = findpeaks(total_step(180:end),'MinPeakProminence',2.5);
        mean_Ml_inclina = mean(Maxima);

        stotal_step = normalize(total_step);
        [Maxima,MaxIdx] = findpeaks(-total_step(180:end),'MinPeakHeight', 0, 'MinPeakProminence',1.1);
        mean_mL_inclina = mean(Maxima);
        mean_ML_inclination = (mean_Ml_inclina + mean_mL_inclina) /2 ;
    end
end

if FRONT
    if coordination == 1
        stotal_step = normalize(total_step);
        [Maxima,MaxIdx] = findpeaks(total_step(180:end),'MinPeakProminence',2.5);
        mean_poste_inclina = mean(Maxima);

        stotal_step = normalize(total_step);
        [Maxima,MaxIdx] = findpeaks(-total_step(180:end),'MinPeakHeight', 0, 'MinPeakProminence',1.1);
        mean_ante_inclina = mean(Maxima);
    end
    
    if coordination ==2
        stotal_step = normalize(total_step);
        [Maxima,MaxIdx] = findpeaks(total_step(180:end),'MinPeakProminence',2.5);
        mean_Ml_inclina = mean(Maxima);

        stotal_step = normalize(total_step);
        [Maxima,MaxIdx] = findpeaks(-total_step(180:end),'MinPeakHeight', 0, 'MinPeakProminence',1.1);
        mean_mL_inclina = mean(Maxima);
        mean_ML_inclination = (mean_Ml_inclina + mean_mL_inclina) /2 ;
    end
        
end

if coordination == 1
    string = ['anterior inclinationa angle is ', num2str(mean_ante_inclina), ', posterior inclination angle is ', num2str(mean_poste_inclina) ];
    disp(string)
end

if coordination == 2
    string = ['medial inclination angle is ', num2str(mean_ML_inclination) ];
    disp(string)
end


