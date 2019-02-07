eating = readtable('~/Desktop/Studies/2-1/DataMining/Assignment1/eating.csv');
non_eating = readtable('~/Desktop/Studies/2-1/DataMining/Assignment1/non_eating.csv');
e_action_num = eating(height(eating), 19).action;
ne_action_num = non_eating(height(non_eating), 19).action;

% eating
e_ent_table = zeros(e_action_num,18);
e_avg_table = zeros(e_action_num,18);
e_std_table = zeros(e_action_num,18);
e_min_table = zeros(e_action_num,18);
e_rms_table = zeros(e_action_num,18);
for i=1:e_action_num
    single_action = eating(eating(:,19).action == i, 1:18);
    for k=1:18
        x = table2array(single_action(:, k)).';
        e_fft = abs(fft(x));
        e_ent = e_fft.*conj(e_fft)/height(single_action);
        e_ent = e_ent.';
        e_ent = e_ent / sum(e_ent + 1e-12);
        log_ent = log2(e_ent + 1e-12);
        e_ent_table(i, k) = -sum(e_ent.*log_ent)/log2(length(e_ent));
        
        e_avg_table(i, k) = mean(x);        
        e_std_table(i, k) = std(x); 
        e_min_table(i, k) = min(x);
        e_rms_table(i, k) = rms(x); 
    end
end

%non eating
ne_ent_table = zeros(ne_action_num,18);
ne_avg_table = zeros(ne_action_num,18);
ne_std_table = zeros(ne_action_num,18);
ne_min_table = zeros(ne_action_num,18);
ne_rms_table = zeros(ne_action_num,18);
for j=1:ne_action_num
    n_single_action = non_eating(non_eating(:,19).action == j, 1:18);
    for l=1:18
        y = table2array(n_single_action(:, l)).';
        ne_fft = abs(fft(y));
        ne_ent = ne_fft.*conj(ne_fft)/height(n_single_action);
        ne_ent = ne_ent.';
        ne_ent = ne_ent / sum(ne_ent + 1e-12);
        log_nent = log2(ne_ent + 1e-12);
        ne_ent_table(j, l) = -sum(ne_ent.*log_nent)/log2(length(ne_ent));
        
        ne_avg_table(j, l) = mean(y);        
        ne_std_table(j, l) = std(y); 
        ne_min_table(j, l) = min(y);
        ne_rms_table(j, l) = rms(y); 
    end
end

prop = ["OX", "OY", "OZ", "OW", "AX", "AY", "AZ", "GX", "GY", "GZ", "E1", "E2", "E2", "E3", "E4", "E5", "E6", "E7", "E8"];
for i=1:18
    plot(e_avg_table(:, i), 'bo', 'DisplayName','eating');
    hold on;
    plot(ne_avg_table(:, i), 'ro', 'DisplayName','non-eating');
    legend;
    title(char('Mean ' + prop(i)));
    hold off;
    saveas(gcf,char("~/Desktop/Studies/2-1/DataMining/Assignment1/Graphs/Mean/Mean_" + prop(i) + ".png"));
end

for i=1:18
    plot(e_ent_table(:, i), 'bo', 'DisplayName','eating');
    hold on;
    plot(ne_ent_table(:, i), 'ro', 'DisplayName','non-eating');
    legend;
    title(char('Entropy ' + prop(i)));
    hold off;
    saveas(gcf,char("~/Desktop/Studies/2-1/DataMining/Assignment1/Graphs/Entropy/Entropy_" + prop(i) + ".png"));
end

for i=1:18
    plot(e_min_table(:, i), 'bo', 'DisplayName','eating');
    hold on;
    plot(ne_min_table(:, i), 'ro', 'DisplayName','non-eating');
    legend;
    title(char('Minimum Plot ' + prop(i)));
    hold off;
    saveas(gcf,char("~/Desktop/Studies/2-1/DataMining/Assignment1/Graphs/Min/Min_" + prop(i) + ".png"));
end

for i=1:18
    plot(e_std_table(:, i), 'bo', 'DisplayName','eating');
    hold on;
    plot(ne_std_table(:, i), 'ro', 'DisplayName','non-eating');
    legend;
    title(char('Standard Deviation ' + prop(i)));
    hold off;
    saveas(gcf,char("~/Desktop/Studies/2-1/DataMining/Assignment1/Graphs/StdDev/StdDev_" + prop(i) + ".png"));
end

for i=1:18
    plot(e_rms_table(:, i), 'bo', 'DisplayName','eating');
    hold on;
    plot(ne_rms_table(:, i), 'ro', 'DisplayName','non-eating');
    legend;
    title(char('RMS ' + prop(i)));
    hold off;
    saveas(gcf,char("~/Desktop/Studies/2-1/DataMining/Assignment1/Graphs/RMS/RMS_" + prop(i) + ".png"));
end

%feature selection
efeature_table = zeros(e_action_num,9);
nefeature_table = zeros(ne_action_num,9);

%GX
efeature_table(:,1) = e_min_table(:,8);
nefeature_table(:,1) = ne_min_table(:,8);
efeature_table(:,2) = e_rms_table(:,8);
nefeature_table(:,2) = ne_rms_table(:,8);
efeature_table(:,3) = e_std_table(:,8);
nefeature_table(:,3) = ne_std_table(:,8);

%GY
efeature_table(:,4) = e_avg_table(:,9);
nefeature_table(:,4) = ne_avg_table(:,9);
efeature_table(:,5) = e_rms_table(:,9);
nefeature_table(:,5) = ne_rms_table(:,9);
efeature_table(:,6) = e_std_table(:,9);
nefeature_table(:,6) = ne_std_table(:,9);

%GZ
efeature_table(:,7) = e_min_table(:,10);
nefeature_table(:,7) = ne_min_table(:,10);

%E3
efeature_table(:,8) = e_min_table(:,13);
nefeature_table(:,8) = ne_min_table(:,13);

%E7
efeature_table(:,9) = e_min_table(:,17);
nefeature_table(:,9) = ne_min_table(:,17);


efeature_table = array2table(efeature_table);
nefeature_table = array2table(nefeature_table);
efeature_table.Properties.VariableNames = {'GX_min' 'GX_rms' 'GX_std' 'GY_avg' 'GY_rms' 'GY_std' 'GZ_min' 'E3_min' 'E7_min'};
nefeature_table.Properties.VariableNames = {'GX_min' 'GX_rms' 'GX_std' 'GY_avg' 'GY_rms' 'GY_std' 'GZ_min' 'E3_min' 'E7_min'};
writetable(efeature_table, '~/Desktop/Studies/2-1/DataMining/Assignment1/efeature_before_pca.csv');
writetable(nefeature_table, '~/Desktop/Studies/2-1/DataMining/Assignment1/nefeature_before_pca.csv');
