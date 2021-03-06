candidate_ARMA_models = [best_ARMA_mdl_Gauss_AICC, best_ARMA_mdl_Gauss_BIC, best_ARMA_mdl_t_AICC, best_ARMA_mdl_t_BIC];
candidate_GARCH_models = [best_GARCH_mdl_Gauss_AICC, best_GARCH_mdl_Gauss_BIC, best_GARCH_mdl_t_AICC, best_GARCH_mdl_t_BIC];
%% removing the identical models
identical_ARMA = [];
identical_GARCH = [];
for i = 1:4
    for j = 1:4
        if isequal(candidate_ARMA_models(i),candidate_ARMA_models(j)) && i~=j
            identical_ARMA = [identical_ARMA; i j];
        end
        if isequal(candidate_GARCH_models(i),candidate_GARCH_models(j)) && i~=j
            identical_GARCH = [identical_GARCH; i j];
        end
    end
end
to_keep_ARMA = [];
for k = 1:length(identical_ARMA)
    [i,j] = find(identical_ARMA(k,:) == flip(identical_ARMA,2));
    tmp = identical_ARMA(i,j);
    to_keep_ARMA = [to_keep_ARMA max(tmp(:))];
end
to_keep_ARMA = unique(to_keep_ARMA);
candidate_ARMA_models = candidate_ARMA_models(to_keep_ARMA);


to_keep_GARCH = [];
for k = 1:length(identical_GARCH)
    [i,j] = find(identical_GARCH(k,:) == flip(identical_GARCH,2));
    tmp = identical_GARCH(i,j);
    to_keep_GARCH = [to_keep_GARCH max(tmp(:))];
end
to_keep_GARCH = unique(to_keep_GARCH);
candidate_GARCH_models = candidate_GARCH_models(to_keep_GARCH);

disp('Candidate ARMA models:')
for i = 1:length(candidate_ARMA_models)
    disp(candidate_ARMA_models(i).Description);
end
disp(' ')
disp('Candidate GARCH models:')
for i = 1:length(candidate_GARCH_models)
    disp(candidate_GARCH_models(i).Description);
end
%%
gauss_dist_ARMA = makedist('normal','mu',candidate_ARMA_models(1).Constant,'sigma',sqrt(candidate_ARMA_models(1).Variance));
gauss_dist_GARCH = makedist('normal','mu',candidate_GARCH_models(1).Constant,'sigma',???);

t_dist_ARMA = makedist('tLocationScale','nu',candidate_ARMA_models(2).Distribution.DoF);
t_dist_GARCH = makedist('tLocationScale','nu',candidate_GARCH_models(2).Distribution.DoF);
    
for t = 1527:1751
    V_tmp = V(1:t-1);
    X_tmp = X(1:t-1);
    
    
    
