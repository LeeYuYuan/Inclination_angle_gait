function [hip_center, L_hip_center, R_hip_center] = hip_markers(LASI, LPSI, RASI, RPSI)
L_hip_front = LASI;
L_hip_back = LPSI;
R_hip_front = RASI;
R_hip_back = RPSI;

y_front = L_hip_front - R_hip_front;
Pelvis_width = sqrt(sum(y_front.^2));
pelvis_width = nanmean(Pelvis_width);
y_H = y_front./Pelvis_width; %normalisation

M_back = 0.5*(R_hip_back + L_hip_back);
M_front = 0.5*(R_hip_front + L_hip_front);
x_depth = M_front - M_back;
z_H = cross(x_depth, y_H, 1);
z_H = z_H./sqrt(sum(z_H.*z_H));
x_H = cross(y_H, z_H,1);

hip_center   = M_back + (0.7054.*x_H - 0.3661.*z_H).*pelvis_width;	
L_hip_center = hip_center + 0.3616.*y_H.*pelvis_width;
R_hip_center = hip_center - 0.3616.*y_H.*pelvis_width;
end

    



