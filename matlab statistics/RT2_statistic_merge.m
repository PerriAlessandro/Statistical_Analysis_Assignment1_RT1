clc
clear

%% Import data from text file
%% Set up the Import Options 
opts = delimitedTextImportOptions("NumVariables", 3);

% Specify range and delimiter
opts.DataLines = [1, Inf];
opts.Delimiter = " ";

% Specify column names and types
opts.VariableNames = ["VarName1", "VarName2", "VarName3"];
opts.VariableTypes = ["double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts.ConsecutiveDelimitersRule = "join";
opts.LeadingDelimitersRule = "ignore";

opts2 = delimitedTextImportOptions("NumVariables", 1);

% Specify range and delimiter
opts2.DataLines = [1, Inf];
opts2.Delimiter = ",";

% Specify column names and types
opts2.VariableNames = "VarName1";
opts2.VariableTypes = "double";

% Specify file level properties
opts2.ExtraColumnsRule = "ignore";
opts2.EmptyLineRule = "read";

%% Import the data

% DISTANCES: 1°,2° and 3° column should contain respectively the (closest) left, frontal 
% and lateral distance of the golden tokens at each time frame 
n_script=2; %number of scripts
n_occ=5; %number of occurrences
n_orient=3; %i.e. left, frontal and right
distances=cell(2,n_occ);

distances_11 = table2array(readtable("C:\Users\Huawei\Desktop\statistic_RT2\data\distances11.txt", opts));
distances_12 = table2array(readtable("C:\Users\Huawei\Desktop\statistic_RT2\data\distances12.txt", opts));
distances_13 = table2array(readtable("C:\Users\Huawei\Desktop\statistic_RT2\data\distances13.txt", opts));
distances_14 = table2array(readtable("C:\Users\Huawei\Desktop\statistic_RT2\data\distances14.txt", opts));
distances_15 = table2array(readtable("C:\Users\Huawei\Desktop\statistic_RT2\data\distances15.txt", opts));


distances_21 = table2array(readtable("C:\Users\Huawei\Desktop\statistic_RT2\data\distances21.txt", opts));
distances_22 = table2array(readtable("C:\Users\Huawei\Desktop\statistic_RT2\data\distances22.txt", opts));
distances_23 = table2array(readtable("C:\Users\Huawei\Desktop\statistic_RT2\data\distances23.txt", opts));
distances_24 = table2array(readtable("C:\Users\Huawei\Desktop\statistic_RT2\data\distances24.txt", opts));
distances_25 = table2array(readtable("C:\Users\Huawei\Desktop\statistic_RT2\data\distances25.txt", opts));

distances_11(distances_11(:,:)==100)=NaN;
distances_12(distances_12(:,:)==100)=NaN;
distances_13(distances_13(:,:)==100)=NaN;
distances_14(distances_14(:,:)==100)=NaN;
distances_15(distances_15(:,:)==100)=NaN;

distances_21(distances_21(:,:)==100)=NaN;
distances_22(distances_22(:,:)==100)=NaN;
distances_23(distances_23(:,:)==100)=NaN;
distances_24(distances_24(:,:)==100)=NaN;
distances_25(distances_25(:,:)==100)=NaN;

%copy all data in cell array
distances{1,1}=distances_11;
distances{1,2}=distances_12;
distances{1,3}=distances_13;
distances{1,4}=distances_14;
distances{1,5}=distances_15;


distances{2,1}=distances_21;
distances{2,2}=distances_22;
distances{2,3}=distances_23;
distances{2,4}=distances_24;
distances{2,5}=distances_25;

%columns: left and right distances, rows: all values piled from all
%occurrences
distances_violin_1= [cat(1,distances{1,1}(:,1),distances{1,2}(:,1),distances{1,3}(:,1),distances{1,4}(:,1),distances{1,5}(:,1)) ...
    cat(1,distances{1,1}(:,3),distances{1,2}(:,3),distances{1,3}(:,3),distances{1,4}(:,1),distances{1,5}(:,3))];

distances_violin_2= [cat(1,distances{2,1}(:,1),distances{2,2}(:,1),distances{2,3}(:,1),distances{2,4}(:,1),distances{2,5}(:,1)) ...
    cat(1,distances{2,1}(:,3),distances{2,2}(:,3),distances{2,3}(:,3),distances{2,4}(:,1),distances{2,5}(:,3))];


th_dist=0.8; %distance threshold
left_dist_lower=zeros(n_script,n_occ);
right_dist_lower=zeros(n_script,n_occ);
for i=1:n_script
    for j=1:n_occ
       left_dist_lower(i,j)=numel(distances{i,j}(distances{i,j}(:,1)<th_dist))/numel(distances{i,j}(:,1)); 
       right_dist_lower(i,j)=numel(distances{i,j}(distances{i,j}(:,3)<th_dist))/numel(distances{i,j}(:,3)); 
    end
end





%TIME PERFORMANCE: each row contains the time interval (in [s]) between two
%collected tokens, an estimate of the time of a whole lap is obtained by 
%knowing the number of tokens in the circuit (which is the first element of the array)
time_raw=cell(n_script,n_occ);
time=cell(n_script,n_occ);

time_11 = table2array(readtable("C:\Users\Huawei\Desktop\statistic_RT2\data\lapTime11.txt", opts2));
time_12 = table2array(readtable("C:\Users\Huawei\Desktop\statistic_RT2\data\lapTime12.txt", opts2));
time_13 = table2array(readtable("C:\Users\Huawei\Desktop\statistic_RT2\data\lapTime13.txt", opts2));
time_14 = table2array(readtable("C:\Users\Huawei\Desktop\statistic_RT2\data\lapTime14.txt", opts2));
time_15 = table2array(readtable("C:\Users\Huawei\Desktop\statistic_RT2\data\lapTime15.txt", opts2));

time_21 = table2array(readtable("C:\Users\Huawei\Desktop\statistic_RT2\data\lapTime21.txt", opts2));
time_22 = table2array(readtable("C:\Users\Huawei\Desktop\statistic_RT2\data\lapTime22.txt", opts2));
time_23 = table2array(readtable("C:\Users\Huawei\Desktop\statistic_RT2\data\lapTime23.txt", opts2));
time_24 = table2array(readtable("C:\Users\Huawei\Desktop\statistic_RT2\data\lapTime24.txt", opts2));
time_25 = table2array(readtable("C:\Users\Huawei\Desktop\statistic_RT2\data\lapTime25.txt", opts2));


n_laps=5 %number of recorded laps 
n_tokens=time_11(1); %retrieve the number of tokens for the whole experiment



%Me
time_raw{1,1}=time_11(3:end);
time_raw{1,2}=time_12(3:end);
time_raw{1,3}=time_13(3:end);
time_raw{1,4}=time_14(3:end);
time_raw{1,5}=time_15(3:end);

%Prof
time_raw{2,1}=time_21(3:end);
time_raw{2,2}=time_22(3:end);
time_raw{2,3}=time_23(3:end);
time_raw{2,4}=time_24(3:end);
time_raw{2,5}=time_25(3:end);

%Reshape of the arrays containing the timestamp at each token grabbed into
%multiple rows, so that each one represent an entire lap
for i=1:n_script
    for j=1:n_occ 
        time{i,j}=reshape(time_raw{i,j}(1:(floor(numel(time_raw{i,j})/n_tokens)*n_tokens)), n_tokens, []).';
    end
end


%Clear temporary variables
clear opts opts2 
clear distances_11 distances_12 distances_13 distances_14 distances_15 distances_22 distances_21 distances_23 distances_24 distances_25
clear time_11 time_21 time_22 time_23 time_24 time_25 time_12 time_13 time_14 time_15 time_21 time_22 time_23 time_24 time_25 

%% DISPERSION INDEXES
%Mean
mean_dist = cellfun(@(x) mean(x,'omitnan'),distances,'UniformOutput',false);
%% impilare ogni lap di tutte le occorrenze
time_lap = cellfun(@(x) sum(x,2),time,'UniformOutput',false);
mean_time_lap = cellfun(@(x) mean(x),time_lap,'UniformOutput',false); %mean for each occurrence
mean_time_total =mean(cell2mat(mean_time_lap),2); %average time of an entire lap 
%Standard Deviation
std_dist = cellfun(@(x) std(x,'omitnan'),distances,'UniformOutput',false);
std_time = cellfun(@(x) std(x),time_lap,'UniformOutput',false);
std_time_total =std(cell2mat(mean_time_lap),0,2);
%%Mean of the mean
sub_mean_tot1=zeros(n_occ,n_orient);
sub_mean_tot2=zeros(n_occ,n_orient);
sub_std_tot1=zeros(n_occ,n_orient);
sub_std_tot2=zeros(n_occ,n_orient);
for i=1:n_occ
    for j= 1:n_orient
    sub_mean_tot1(i,j)=mean_dist{1,i}(j);
    sub_mean_tot2(i,j)=mean_dist{2,i}(j);
    sub_std_tot1(i,j)=std_dist{1,i}(j);
    sub_std_tot2(i,j)=std_dist{2,i}(j);
    end
end

mean_dist_tot=zeros(n_script,n_orient);
mean_dist_tot(1,:)=mean(sub_mean_tot1,1);
mean_dist_tot(2,:)=mean(sub_mean_tot2,1);

std_dist_tot=zeros(n_script,n_orient);
std_dist_tot(1,:)=mean(sub_std_tot1,1);
std_dist_tot(2,:)=mean(sub_std_tot2,1);



%% PLOTS

%% Distances
%1
plot_mean_dist_1=[mean_dist_tot(1,1) mean_dist_tot(1,2) mean_dist_tot(1,3)];
plot_mean_dist_2=[mean_dist_tot(2,1) mean_dist_tot(2,2) mean_dist_tot(2,3)];
plot_mean_dist=[plot_mean_dist_1;plot_mean_dist_2];

plot_std_dist_1=[std_dist_tot(1,1) std_dist_tot(1,2) std_dist_tot(1,3)];
plot_std_dist_2=[std_dist_tot(2,1) std_dist_tot(2,2) std_dist_tot(2,3)];
plot_std_dist=[plot_std_dist_1;plot_std_dist_2];


segments={'Left (-100,-80)°','Frontal (-30,+30)°','Right (+80,+100)°'};
segments1={'Left (-100,-80)°','Right (+80,+100)°'};
segments2={'First Script','Second Script'};
x=categorical(segments2);
x=reordercats(x,segments2);

figure('Name','Average golden token distance for each orientation');
dist_bar=barwitherr(plot_std_dist',[1 2 3],plot_mean_dist','LineWidth',1.5,'BarWidth',1);
grid on;
title('Barplot of average golden token distance for each orientation','Figure 3a');
xlabel('Orientation');
ylabel('Average distance from golden tokens [m]');
legend('Script 1','Script 2','Standard Deviations','Location','northwest');
set(gca,'XTickLabel',segments);
set(dist_bar(2),'FaceColor',[0.8 0 0]);
saveas(gcf,"img\distances_1.png");

%2
% filling up the smaller array with nan values
n=max(size(distances_violin_1),size(distances_violin_2));
distances_violin_1(end+1:n(1),:)=nan;
clear n

figure('Name','Distance from walls on left portion of the robot view');
violin([distances_violin_1(:,1) distances_violin_2(:,1)],'xlabel',segments2,'facecolor', [0.2 0.7 1]);
grid on;
title('Distance from walls on left portion of the robot view','Figure 4a');
xlabel('Script');
ylabel('Distance from walls[m] [Left:(-100,-80)°]');
saveas(gcf,"img\distances_2.png");


figure('Name','Distance from walls on right portion of the robot view');
violin([distances_violin_1(:,2) distances_violin_2(:,2)],'xlabel',segments2,'facecolor', [0.2 0.7 1]);
grid on;
title('Distance from walls on right portion of the robot view','Figure 4b');
xlabel('Script');
ylabel('Distance from walls[m] [Right:(+80,+100)°]');
saveas(gcf,"img\distances_3.png");


%3
plot_mean_dist_lower=[mean(left_dist_lower,2), mean(right_dist_lower,2)];
plot_std_dist_lower=[std(left_dist_lower,0,2), std(right_dist_lower,0,2)];

figure('Name','Percentage of time in which the robot is close to a wall');
dist_lower_bar=barwitherr((100*plot_std_dist_lower)',[1 2],(100*plot_mean_dist_lower)','LineWidth',1.5,'BarWidth',1);
grid on;
title('Percentage of time in which the robot is close to a wall (<0.8 [m]) ','Figure 6a');
xlabel('Orientation');
ylabel('Time percentage over the entire simulation [%]');
legend('Script 1','Script 2','Standard Deviations','Location','northwest');
set(gca,'XTickLabel',segments1);
set(dist_lower_bar(2),'FaceColor',[0.8 0 0]);
saveas(gcf,"img\distances_4.png");



%Time

figure('Name','Barplot of Average Lap Time ');
hold on
bar(x,mean_time_total.');
errorbar(mean_time_total.',std_time_total.');
grid on;
title('Average time to complete the circuit','Figure 7a');
xlabel('Script');
ylabel('Time [s]');
legend('Scripts','Standard Deviation','Location','northwest');
set(gca,'XTickLabel',segments2);
saveas(gcf,"img\time_1.png");




%clear sub_mean_tot1 sub_mean_tot2 sub_std_tot1 sub_std_tot2
clear segments segments1 segments2 th_samples_dist dist_bar i j x 



%% TWO-SAMPLE T-TEST

% [h_ldlow,p_ldlow,ci_ldlow,stats_ldlow] = ttest2(left_dist_lower(1,:),left_dist_lower(2,:));
% [h_rdlow,p_rdlow,ci_rdlow,stats_rdlow] = ttest2(right_dist_lower(1,:),right_dist_lower(2,:));

%first check normality using Shapiro-Wilk Test
[h_ld_n1,p_ld_n1,stats_ld_n1]=swtest(sub_mean_tot1(:,1));
[h_rd_n1,p_rd_n1,stats_rd_n1]=swtest(sub_mean_tot1(:,3));
[h_ld_n2,p_ld_n2,stats_ld_n2]=swtest(sub_mean_tot2(:,1));
[h_rd_n2,p_rd_n2,stats_rd_n2]=swtest(sub_mean_tot2(:,3));
[h_t_n1,p_t_n1,stats_t_n1]=swtest(cell2mat(mean_time_lap(1,:)));
[h_t_n2,p_t_n2,stats_t_n2]=swtest(cell2mat(mean_time_lap(2,:)));

[h_ld,p_ld,ci_ld,stats_ld]=ttest2(sub_mean_tot1(:,1),sub_mean_tot2(:,1),'Tail','right');
[h_rd,p_rd,ci_rd,stats_rd]=ttest2(sub_mean_tot1(:,3),sub_mean_tot2(:,3),'Tail','right');


[h_t,p_t,ci_t,stats_t]=ttest2(cell2mat(mean_time_lap(1,:)),cell2mat(mean_time_lap(2,:)),'Tail','left');
