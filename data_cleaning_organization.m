users_myo = dir('~/Desktop/Studies/2-1/DataMining/Assignment1/Data_Mining/MyoData/u*');
users_gt = circshift(dir('~/Desktop/Studies/2-1/DataMining/Assignment1/Data_Mining/groundTruth/u*'), 1);
eating = [];
non_eating = [];
e_action_num = 1;
ne_action_num = 1;
for i = 1:30
    path_myo = strcat('~/Desktop/Studies/2-1/DataMining/Assignment1/Data_Mining/MyoData/',users_myo(i).name,'/spoon/');
    path_gt = strcat('~/Desktop/Studies/2-1/DataMining/Assignment1/Data_Mining/groundTruth/',users_gt(i).name,'/spoon/');
    user_imu = dir(strcat(path_myo, '*_IMU.txt'));
    user_emg = dir(strcat(path_myo, '*_EMG.txt'));
    user_gt = dir(strcat(path_gt, '*.txt'));
    user_spoon_emg = readtable(strcat(path_myo, user_emg(1).name));
    user_spoon_imu = readtable(strcat(path_myo, user_imu(1).name));
    user_spoon_gt = readtable(strcat(path_gt, user_gt(1).name));
    user_spoon_emg_alt = user_spoon_emg(1:2:end,:);    
    user_spoon_imu.Properties.VariableNames = {'ts' 'OX' 'OY' 'OZ' 'OW' 'AX' 'AY' 'AZ' 'GX' 'GY' 'GZ'};
    user_spoon_emg_alt.Properties.VariableNames = {'ts' 'E1' 'E2' 'E3' 'E4' 'E5' 'E6' 'E7' 'E8'};
    height_imu = height(user_spoon_imu);
    height_emg = height(user_spoon_emg_alt);
    class = zeros(height(user_spoon_emg_alt),1);
    user_spoon_emg_class = table(class);
    class = zeros(height(user_spoon_imu),1);
    user_spoon_imu_class = table(class);
    action = zeros(height(user_spoon_emg_alt),1);
    user_spoon_emg_action = table(action);
    action = zeros(height(user_spoon_imu),1);
    user_spoon_imu_action = table(action);
    user_spoon_emg_alt = [user_spoon_emg_alt user_spoon_emg_action user_spoon_emg_class];
    user_spoon_imu = [user_spoon_imu user_spoon_imu_action user_spoon_imu_class];
    length_gt = height(user_spoon_gt);
    ne_sample_start = 1;
    for k = 1:length_gt
        gt_sample_time = user_spoon_gt{k,1}/30;
        gt_sample_start = round(gt_sample_time * 50);
        gt_frame_end = user_spoon_gt{k,2};
        gt_sample_end = round((gt_frame_end / 30) * 50);
        if gt_sample_end < height_emg && gt_sample_start < gt_sample_end
            if ne_sample_start < gt_sample_start
                user_spoon_emg_alt.action(ne_sample_start:gt_sample_start - 1) = ne_action_num;
                user_spoon_imu.action(ne_sample_start:gt_sample_start - 1) = ne_action_num;
                ne_sample_start = gt_sample_end + 1;
                ne_action_num = ne_action_num + 1;
            end
            user_spoon_emg_alt.class(gt_sample_start:gt_sample_end) = 1;
            user_spoon_imu.class(gt_sample_start:gt_sample_end) = 1;
            user_spoon_emg_alt.action(gt_sample_start:gt_sample_end) = e_action_num;
            user_spoon_imu.action(gt_sample_start:gt_sample_end) = e_action_num;
            e_action_num = e_action_num + 1;
        end
    end
    
    if gt_sample_end + 1 < height_emg
        user_spoon_emg_alt.action(gt_sample_end + 1:height_emg) = ne_action_num;
        ne_action_num = ne_action_num + 1;
    end
    pad_imu = array2table(zeros((height_emg-height_imu), 13));
    pad_imu.Properties.VariableNames = {'ts' 'OX' 'OY' 'OZ' 'OW' 'AX' 'AY' 'AZ' 'GX' 'GY' 'GZ' 'class' 'action'};
    user_spoon_imu = [user_spoon_imu; pad_imu];
    user_spoon_combined = [user_spoon_imu(1:height_emg,2:end-2) user_spoon_emg_alt(1:height_emg,2:end)];
   
    eating = [eating; user_spoon_combined(user_spoon_combined(:,20).class == 1,1:19)];
    non_eating = [non_eating; user_spoon_combined(user_spoon_combined(:,20).class == 0,1:19)];
    
    clear user_spoon_imu;
    clear user_spoon_imu_class;
    clear user_spoon_emg_alt;
    clear user_spoon_emg;
    clear user_spoon_emg_class;
    clear user_spoon_gt;
    clear pad_imu;
    clear pad_emg;
    clear user_spoon_combined;
end

writetable(eating, '~/Desktop/Studies/2-1/DataMining/Assignment1/eating.csv');
writetable(non_eating, '~/Desktop/Studies/2-1/DataMining/Assignment1/non_eating.csv');

