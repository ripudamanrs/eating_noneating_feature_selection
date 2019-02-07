efeature = readtable('~/Desktop/Studies/2-1/DataMining/Assignment1/efeature_before_pca.csv');
nefeature = readtable('~/Desktop/Studies/2-1/DataMining/Assignment1/nefeature_before_pca.csv');
feature_matrix = [efeature; nefeature];
[coeff, score, latent, tsquared, explained, mu] = pca(table2array(feature_matrix),'Algorithm', 'eig');

% radarplot(abs(coeff(:,1:4).'), {'GX min', 'GX rms', 'GX std', 'GY avg', 'GY rms', 'GY std', 'GZ min', 'E3 min', 'E7 min'}, {'r', 'g', 'b', 'c'}, {'r', 'g', 'b', 'c'});
% legend('eigenvector 1', 'eigenvector 2', 'eigenvector 3', 'eigenvector 4');
% saveas(gcf,char("~/Desktop/Studies/2-1/DataMining/Assignment1/Graphs/eigenvectors.png"));

coeff_t = abs(coeff(:,1:4).');

pca_feature_matrix = table2array(feature_matrix) * coeff(:,1:4);

writetable(array2table(pca_feature_matrix(1:height(efeature), :)), '~/Desktop/Studies/2-1/DataMining/Assignment1/efeature_after_pca.csv');
writetable(array2table(pca_feature_matrix(height(efeature)+1:end, :)), '~/Desktop/Studies/2-1/DataMining/Assignment1/nefeature_after_pca.csv');