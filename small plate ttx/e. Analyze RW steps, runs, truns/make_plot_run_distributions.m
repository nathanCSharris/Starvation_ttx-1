function [] = make_plot_run_distributions(ds)

[N1,centers1,N3,centers3] = bin_runs_up_down4(ds);

NN1 = 100*N1/sum(N1); % convert to percentage
indx1 = find(N1>0);
if ~isempty(indx1) 
    [A1, lambda1] = my_exp_fit4(centers1, N1);
    [NA1, Nlambda1] = my_exp_fit4(centers1, NN1);
else
    A1 = 0;
    lambda1 = 0; 
    NA1 = 0;
    Nlambda1 = 0; 
end;

%NN2 = 100*N2/sum(N2); % convert to percentage
%indx2 = find(NN2>0);
%if ~isempty(find(N2>0, 1)) 
%    [A2, lambda2] = my_exp_fit4(centers2, N2);
%    [NA2, Nlambda2] = my_exp_fit4(centers2, NN2);
%    res.tau_vr = lambda2; 
%    res.Ntau_vr = Nlambda2; 
%else
%    A2 = 0;
%    lambda2 = 0; 
%    NA2 = 0;
%    Nlambda2 = 0; 
%end;

NN3 = 100*N3/sum(N3); % convert to percentage
indx3 = find(N3>0);
if ~isempty(indx3) 
    [A3, lambda3] = my_exp_fit4(centers3, N3);
    [NA3, Nlambda3] = my_exp_fit4(centers3, NN3);
else
    A3 = 0;
    lambda3 = 0; 
    NA3 = 0;
    Nlambda3 = 0; 
end;

% Non-normalized runs UP/DOWN histogram
fh = figure;
clf;
set(fh,'position',[621   400   756   567]);
bar(centers1, N1, 0.90, 'c'); % down
hold on;
bar(centers3, N3, 0.78, 'r'); % up
plot(centers1(indx1), A1*exp(-1*centers1(indx1)/lambda1), '--','linewidth',2,'color',[0 0.4 1]);
plot(centers3(indx3), A3*exp(-1*centers3(indx3)/lambda3), '--','linewidth',2,'color',[1 0.4 0]);
hold off;
title(['Non-Normalized run durations (all plates), \tau_{dn} = ' num2str(lambda1) ' \tau_{up} = ' num2str(lambda3) ]);
ch = get(fh,'children');
set(ch,'yscale','log');
xlabel(['Mean duration of binned runs (sec)']);
ylabel(['Number of runs']);

%%% also calculate intersection point of two fits:
%tstar = (lambda1*lambda3)/(lambda1-lambda3) * log(A3/A1);
%ystar = A1*exp(-1*tstar/lambda1); 
%hold on;
%plot(tstar,ystar,'g*');
%hold off;
%text(tstar,ystar*3,['t^* = ' num2str(tstar)]);


% Normalized runs UP/DOWN histogram
fh = figure;
clf; 
set(fh,'position',[121   100   672   504]);
bar(centers1, NN1, 0.90, 'c');
hold on; 
bar(centers1, NN3,0.78,'r');
plot(centers1(indx1), NA1*exp(-1*centers1(indx1)/Nlambda1), '--','linewidth',2,'color',[0 0.4 1]);
plot(centers3(indx3), NA3*exp(-1*centers3(indx3)/Nlambda3), '--','linewidth',2,'color',[1 0.4 0]);
title(['Normalized run durations (all plates), \tau_{dn} = ' num2str(Nlambda1) ' \tau_{up} = ' num2str(Nlambda3)]);
hold off;
ch = get(fh,'children');
set(ch,'yscale','log');
xlabel(['Mean duration of binned runs (sec)']);
ylabel(['Percentage of runs (from total number of runs)']);

return;