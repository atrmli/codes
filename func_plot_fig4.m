function func_plot_fig4(inputs)
load(inputs);
fig4=figure(4);set(fig4,'position',[596 216 863 483]);
set(gcf,'color','w');
xpos=-0.1;
%%
bot=.2;
phgt=0.6;
pwidth=0.4;
p0=.33;
% for temperature
temp_range = [-1 6];
temp_tick = (-2:2:8);
% for pdo
pdo_range = [-1.2 1.8];
% for hailday
hist_hail_range = [0 300];
hist_hail_tick = [0:100:300];
hail_range = [0 730];
hail_tick = [0:200:800];
hail_cols= [199 199 199]./255;
hail_cols2 = [.5 .5 .5];
ytx1=280;%285;%
ytx2=ytx1;%560;%
xtx0=1887;
xtx1=1966;
xtx2=2042;
temp_ls = '-';
%% ----------------PDO
pdo_smooth_yr=10;
ax2=axes('position',[p0+xpos bot pwidth+100*pwidth/140 phgt]);
hold on;box off;grid off;set(gca,'GridLinestyle',':');
set(gca,'color','none');
set(gca,'ycolor',[191 193 225]/255);
xlim([plot_yrbegin,plot_yrend2]);
% 10yr smooth
pdo1(:,2)=smooth(pdo1(:,2),pdo_smooth_yr);
set(gca,'ylim',pdo_range);
y_up = pdo1(pdo1(:,1)<=plot_yrend,2); y_up(y_up<0)=0;
y_dn = pdo1(pdo1(:,1)<=plot_yrend,2); y_dn(y_dn>0)=0;
patch([pdo1(pdo1(:,1)<=plot_yrend,1)' fliplr(pdo1(pdo1(:,1)<=plot_yrend,1)')],[y_up' zeros(1,size(pdo1(pdo1(:,1)<=plot_yrend),1))],[249 203 175]/255,'edgecolor','none','facealpha',.6);
patch([pdo1(pdo1(:,1)<=plot_yrend,1)' fliplr(pdo1(pdo1(:,1)<=plot_yrend,1)')],[y_dn' zeros(1,size(pdo1(pdo1(:,1)<=plot_yrend),1))],[191 193 225]/255,'edgecolor','none','facealpha',.6);
% plot([plot_yrbegin,plot_yrend],[0 0],'color',[.3 .3 .3],'LineStyle','--','linewidth',lw-0.6);

% 10yr smooth
pdo_long=[pdo3(:,2);pdo_fut(10:end,2)];
pdo_long=smooth(pdo_long,pdo_smooth_yr);
set(gca,'ylim',pdo_range);
y_up = pdo_long; y_up(y_up<0)=0;
y_dn = pdo_long; y_dn(y_dn>0)=0;
patch([(2001:1:2100) fliplr((2001:1:2100))],[y_up' zeros(1,length((2001:1:2100)'))],[249 203 175]/255,'edgecolor','none','facealpha',.6);
patch([(2001:1:2100) fliplr((2001:1:2100))],[y_dn' zeros(1,length((2001:1:2100)'))],[191 193 225]/255,'edgecolor','none','facealpha',.6);
% plot([2001,2100],[0 0],'color',[.3 .3 .3],'LineStyle','--','linewidth',lw-0.6);

ylabel('PDO index');
xlabel('Year');
set(gca,'xtick',[1860 1900 1948 1950 1975 2000 2013 2050 2100]);
set(gca,'TickDir','in','ticklength',[0.02 0.01]);
set(gca,'linewidth',lw-0.6,'FontSize',fs,'FontName',FN); 

%% temperature
% temp_rcp_col = [175, 176, 150;
%                 140, 155, 121;
%                 116, 129, 96;
%                 51, 72, 70]./255;
temp_rcp_col = [163, 186, 144;
                125, 166, 100;
                105, 148, 95;
                68, 118, 91]./255;
temp_rcp_col(:,4)=0.7;
ax3=axes('position',[p0+xpos bot pwidth+100*pwidth/140 phgt]);
hold on;box off;grid off;set(gca,'GridLinestyle',':');
set(gca,'ycolor',temp_rcp_col(1,:));set(gca,'color','none');
xlim([plot_yrbegin,plot_yrend2]);
set(gca,'ylim',temp_range);set(gca,'yaxislocation','right');
set(gca,'ytick',temp_tick);
plot(temp1(1:121,1),smooth(temp1(1:121,2),10),...
    'color',temp_rcp_col(1,:),'LineStyle',temp_ls,'linewidth',lw,'marker','none')

scenario = {'ssp126','ssp245','ssp370','ssp585'};
for i=1:4
    load(['./mat/global_tas_mon_mod_' scenario{i} '.mat']);
    avg_tmp = mean(tas(:,2:end),2, 'omitnan');
    avg_tmp(tas(:,1)<2001)=[];
    avg_tmp = avg_tmp -273-14;
    avg_tmp(end) - avg_tmp(1)
    fp(i)=plot(2001:1:2100,avg_tmp,'color',temp_rcp_col(i,:),...
                          'LineStyle',temp_ls,'linewidth',lw,'marker','none');
end
lgd = legend(fp,{'','','',''});
legend('boxoff');
set(lgd,'position',[.735 .28 .03 .03],'FontSize',fs-4,'FontName',FN); 
lgd.ItemTokenSize = [20,10];
set(gca,'ylim',temp_range);
axis off

ax33 = axes('position',[.15+xpos bot pwidth phgt],'color','none','ycolor',temp_rcp_col(1,:),'yaxislocation','left');
xlim([plot_yrbegin,plot_yrend]);
set(gca,'ylim',temp_range);
set(gca,'ytick',temp_tick);
ylabel('Temperature anomaly (^{o}C)');
set(gca,'TickDir','in','ticklength',[0.02 0.01]);
set(gca,'linewidth',lw-0.6,'FontSize',fs,'FontName',FN); 
ax33.XAxis.Visible='off';

%%  hailday historical
ax1=axes('position',[p0+xpos bot pwidth+100*pwidth/140 phgt]);
hold on;box off;grid off;set(gca,'GridLinestyle',':');
set(gca,'color','none');
xlim([plot_yrbegin,plot_yrend2]);
set(gca,'ylim',hist_hail_range);set(gca,'ytick',hist_hail_tick);
plot(y01(y01(:,1)<=1948,1),y01(y01(:,1)<=1948,2),...
    'color',hail_cols,'LineStyle','-','linewidth',lw);
h2=plot(y01(y01(:,1)<=1948,1),smooth(y01(y01(:,1)<=1948,2),50),...
    'color',hail_cols2,'LineStyle','-','linewidth',lw);
ylim=get(gca,'ylim');
text(xtx0,ytx1,'Historical','FontSize',fs-1,'FontName',FN);
text(xtx1,ytx1,'Recent','FontSize',fs-1,'FontName',FN);
text(xtx2,ytx2,'Future','FontSize',fs-1,'FontName',FN);
set(gca,'ycolor',hail_cols2);
% yl=ylabel('Hailstorm days (#)');
% set(yl,'Units','normalized');
% set(yl,'position',get(yl,'position') - [0.02 +0.2 0]);
set(gca,'xtick',[1860 1900 1948 1950 1975 2000 2013 2050 2100]);
set(gca,'xaxislocation','top')
xlabel('Year');
ax1.YAxis.Visible='off';
set(gca,'TickDir','in','ticklength',[0.02 0.01]);
set(gca,'linewidth',lw-0.6,'FontSize',fs,'FontName',FN); 

ax22=axes('position',[.24+xpos bot pwidth phgt],'color','none','yaxislocation','left');
xlim([plot_yrbegin,plot_yrend2]);
set(gca,'ylim',hist_hail_range,'ytick',hist_hail_tick,'ycolor',hail_cols2);
ylabel('Hailstorm days (#)');
set(gca,'TickDir','in','ticklength',[0.02 0.01]);
set(gca,'linewidth',lw-0.6,'FontSize',fs,'FontName',FN); 
ax22.XAxis.Visible='off';
hidden off
%% hailday recent
ax11=axes('position',[p0+xpos bot pwidth+100*pwidth/140 phgt]);
hold on;box off;grid off;set(gca,'GridLinestyle',':');
set(gca,'color','none','YAxisLocation','right','ycolor',hail_cols2);
xlim([plot_yrbegin,plot_yrend2]);
set(gca,'ylim',hail_range);set(gca,'ytick',[20 100:200:700])
scenario = {'ssp126','ssp245','ssp370','ssp585'};

h3=plot(y02(y02(:,1)>1949,1),y02(y02(:,1)>1949,2),...
    'color',hail_cols,'LineStyle','-','linewidth',lw);
plot(y02(y02(:,1)>1949,1),smooth(y02(y02(:,1)>1949,2),50),...
    'color',hail_cols2,'LineStyle','-','linewidth',lw);
for i=1:4
    yprange=[lstm_ens(:,i+1)'+lstm_std(:,i+1)' fliplr(lstm_ens(:,i+1)'-lstm_std(:,i+1)')];
    patch([lstm_ens(:,1)' fliplr(lstm_ens(:,1)')],yprange,cols(i+1,1:3),'edgecolor','none','facealpha',.2);
    fp(i)=plot(lstm_ens(:,1),lstm_ens(:,i+1),'color',cols(i+1,:),...
                          'LineStyle','-','linewidth',lw,'marker','none');
end
% calculate rmse
yyyy1 = y02(y02(:,1)>=1960,2);
yyyy2 = smooth(y02(y02(:,1)>1949,2),50);
yyyy2 = yyyy2(11:end);
yyyy3 = lstm_ens(lstm_ens(:,1)<=2000,2);
sqrt(mean((yyyy2-yyyy3).^2))
mean(abs(yyyy2-yyyy3))
lgd = legend(fp,RCP_str);
legend('boxoff');
set(lgd,'position',[.795 .28 .03 .03],'FontSize',fs-4,'FontName',FN); 
lgd.ItemTokenSize = [20,10];
set(gca,'TickDir','in','ticklength',[0.02 0.01]);
set(gca,'linewidth',lw-0.6,'FontSize',fs,'FontName',FN); 

ylim=get(gca,'ylim');
set(gca,'xtick',[]);
ax11.XAxis.Visible='off';
yl=ylabel('Hailstorm days (#)');
set(yl,'Units','normalized');
% set(yl,'position',get(yl,'position') - [-0.02 -0.2 0]);
set(gca,'TickDir','in','ticklength',[0.02 0.01]);
set(gca,'linewidth',lw-0.6,'FontSize',fs,'FontName',FN); 