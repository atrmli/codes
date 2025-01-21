function func_plot_fig1(ncl_cols,t01,t02,t03_al,t03_05,t03_10,t03_15,fs,fw,FN,blw)
gcacolor  = 'w';
gcacolorstr = 'white';
Mingcolor = ncl_cols('goldenrod');%my_pantone_col('3551C');
Hancolor  = ncl_cols('seagreen');%[201 82 42]./255;%
Zhoucolor = ncl_cols('indianred3');
lcol      = [201 201 201]./255;
lcol2     = [.4 .4 .4];
a_pos     = [.1 .55 .48 .48*0.68];
cd_width  = 0.3;
c_pos     = [a_pos(1)+a_pos(3)+.02 .55 cd_width a_pos(4)];
d_pos     = [a_pos(1)+a_pos(3)-cd_width .17 cd_width cd_width*0.85];

fig1 = figure(1);
set(fig1,'position',[822 223 834 641]);
axes('position',a_pos);
hold on;box on;set(gca,'xgrid','off','GridLinestyle',':');
set(gca,'ycolor','k','layer','top');
% for i=1:size(t01,1)
%     plot([t01(i,1) t01(i,1)],[1 t01(i,2)],'color',lcol,'LineStyle','-','linewidth',2,'marker','.');
% end
patch([t01(:,1)' fliplr(t01(:,1)')],...
    [t01(:,2)' zeros(1,size(t01,1))],...
    lcol,'edgecolor','none','facealpha',.8);
% plot(t01(:,1),t01(:,2),'color',lcol,'LineStyle','-','linewidth',1.3,'marker','none');
t01_smooth=smooth(t01(:,2),20);
plot(t01(1:end-1,1),t01_smooth(1:end-1),'color',[.2 .2 .2],'LineStyle','-','linewidth',1.5,'marker','none');
% plot([1368 1368],ylim,'color',Mingcolor,'LineStyle','--','linewidth',1.3)
scatter(1368,0,'^','markeredgecolor','none','markerfacecolor',Mingcolor);

scatter(1138,44,'^','markeredgecolor','none','markerfacecolor',Mingcolor);
text(1150,44.5,'Ming dynasty','color',Mingcolor,'FontSize',fs-1,'FontWeight',fw,'FontName',FN)

scatter(1138,50,'^','markeredgecolor','none','markerfacecolor',Hancolor);
text(1150,50.5,'Han dynasty','color',Hancolor,'FontSize',fs-1,'FontWeight',fw,'FontName',FN)

scatter(1138,56,'^','markeredgecolor','none','markerfacecolor',Zhoucolor);
text(1150,56.5,'886BC','color',Zhoucolor,'FontSize',fs-1,'FontWeight',fw,'FontName',FN)
% set(gca,'yscale','log');
set(gca,'XMinorTick','on');
set(gca,'xlim',[1100,1955])
set(gca,'xtick',[1100:200:1900]);
%     'xticklabel',{'1450','1550','1950','1750','1850','1949'});
set(gca,'ytick',0:20:80);
xh=xlabel('Year');
yh=ylabel('Hailstorm days (#)');
text(1120,75,'(b)','FontSize',fs,'FontWeight',fw,'FontName',FN); 
set(gca,'linewidth',blw,'FontSize',fs,'FontName',FN); 
set(0, 'DefaultAxesFontName', FN);
pos=get(gca,'position');
% lgd = legend({'yearbook'});legend('boxoff');
% set(lgd,'position',[pos(1)+0.07 pos(2)+0.22 .08 .06],'FontSize',fs-1,'FontName',FN); 

ax3 = axes('position',[pos(1)+0.17 pos(2)+0.15 0.22 0.22*0.618]);%-----------------------------
hold on;box on;set(gca,'xgrid','off','GridLinestyle',':');
% set(gca,'color',gcacolor);set(gcf,'color','w');
set(gca,'YLim',[0 24],'ycolor','k','layer','top');
set(gca,'ycolor','k'); 
for i=1:size(t01,1)
    plot([t01(i,1) t01(i,1)],[0 t01(i,2)],'color',lcol,'LineStyle','-','linewidth',1.3);
end
% patch([t01(:,1)' fliplr(t01(:,1)')],...
%     [t01(:,2)' zeros(1,size(t01,1))],...
%     lcol,'edgecolor','none','facealpha',.8);
ylim=get(gca,'ylim');
% plot([-202 -202],ylim,'color',Hancolor,'LineStyle','--','linewidth',1.3)
scatter(-202,0,'^','markeredgecolor','none','markerfacecolor',Hancolor);
scatter(-886,0,'^','markeredgecolor','none','markerfacecolor',Zhoucolor);
set(gca,'XMinorTick','off');
set(gca,'xlim',[-1000,1100])
text(-886,21,'(a)','FontSize',fs-1,'FontWeight',fw,'FontName',FN);
set(gca,'xtick',[-500:500:1000],'FontSize',fs-2,'FontName',FN);
set(gca,'linewidth',blw,'FontSize',fs-2,'FontName',FN); 
set(0, 'DefaultAxesFontName', FN);

ax1=axes('position',c_pos);
hold on;box on;grid off;set(gca,'GridLinestyle',':','layer','top');
set(gca,'YLim',[0 1400],'YAxisLocation','Right');
% for i=1:size(t02,1)
%     hp(1)=plot([t02(i,1) t02(i,1)],[0 t02(i,2)],'color',lcol2,...
%         'LineStyle','-','linewidth',1.5,'marker','none');
% end
hp(1)=patch([t02(:,1)' fliplr(t02(:,1)')],...
    [t02(:,2)' zeros(1,size(t02,1))],...
    lcol,'edgecolor','none','facealpha',.8);
hp(6) = plot(t02(:,1),smooth(t02(:,2)),'color',lcol2,'LineStyle','-','linewidth',1.5,'marker','none');
c_data={t03_al,t03_05,t03_10,t03_15};
for i=2:5
    hp(i)=plot(c_data{i-1}(:,1),c_data{i-1}(:,2),'-','color',cols(i,:),'marker','none','markersize',ms,...
        'markeredgecolor','none','markerfacecolor',cols(i,:),'linewidth',1.5);
end
pos=get(gca,'position');
lgd = legend([hp(1) hp(6) hp(2) hp(3) hp(4) hp(5)],...
    {'Damage record','20-yr smooth','CMA>=2mm','CMA>=5mm','CMA>=7mm','CMA>=10mm'});
legend('boxoff');
% legend('Orientation','horizontal');
% lgd.NumColumns = 2;
lgd.ItemTokenSize = [20,10];
set(lgd,'position',[c_pos(1)+.11 c_pos(2)+.16 .04 .03],'FontSize',fs-4,'FontName',FN);  
set(gca,'xlim',[1948,2001])
set(gca,'xtick',1950:10:2000);
set(gca,'XMinorTick','on');
xh=xlabel('Year');
% set(xh,'Units','Normalized','Position', [0.5, -0.09, 0]);
xtickangle(ax1,0)
text(1950,1300,'(c)','FontSize',fs,'FontWeight',fw,'FontName',FN); 
set(gca,'ytick',0:400:1200,'xtick',1950:10:2000);
yh=ylabel('Hailstorm days (#)');
% set(gca,'TickDir','out');
% set(gca,'ticklength',[0.024 0.012]);
set(gca,'linewidth',blw,'FontSize',fs,'FontName',FN); 
set(0, 'DefaultAxesFontName', FN);