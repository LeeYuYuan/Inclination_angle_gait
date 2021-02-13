clc
clear

% Before calculate the COM, please go to line 38-55 to check whether there are missing markers. 
%% load the data

subject = ('S11_Gait_0001_06');
subjfile = [(subject),'.mat'];
load(subjfile);

R_data = load(subject);
name = Gait_0001_06;

% store COP data
FP1_data = name.Force(1).COP;
FP2_data = name.Force(2).COP;
FP3_data = name.Force(3).COP;
FP4_data = name.Force(4).COP;
FP5_data = name.Force(5).COP;
FP6_data = name.Force(6).COP;

% store force data
FP1_data_Force = name.Force(1).Force;
FP2_data_Force = name.Force(2).Force;
FP3_data_Force = name.Force(3).Force;
FP4_data_Force = name.Force(4).Force;
FP5_data_Force = name.Force(5).Force;
FP6_data_Force = name.Force(6).Force;


data_len = length(FP1_data);
FP = zeros(6, data_len);

% corresponding time
frq = length(FP1_data) / length(name.Trajectories.Labeled.Data(26,1,:));
time = data_len / frq;

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
coordination = 2 ;% 1: anterior-posterior, 2: medial-lateral, 3: up and down
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

[hip_center, L_hip_center, R_hip_center] = hip_markers(LASI, LPSI, RASI, RPSI);

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

%x = com(1,:);
%y = com(1,:);
%plot3(New_COM(1,:), New_COM(2,:), New_COM(3,:))
%xlabel("FP")
%ylabel("ML")
%zlabel("UD")
%xlim([0 5])
%ylim([0 5])