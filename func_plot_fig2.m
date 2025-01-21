function func_plot_fig2(issave,y01,x02,residu,popu,popu_tmp,IMF_hail,CON_hail,IMF_temp,...
    cols,popu_col,lw,fs,FN,blw,plot_yrbegin,plot_yrend)

fig_trend=figure('Name','trend2');
width=700;
ypos=-0.2;
set(fig_trend,'position',[270.33 132.33 width width*0.618]);
%-----------------------------------------hail-----------------------------
ax1=axes('position',[.15 .57+ypos .7 .7*0.618]);
yyaxis left
hold on;box on;grid off;set(gca,'GridLinestyle',':');
set(gca,'ylim',[-20,80]);
set(gca,'ytick',-20:20:80)
set(gca,'ycolor','k')
plt3=plot(y01(:,1),y01(:,2),'color',[187 186 186]./255,'LineStyle','-','linewidth',lw,'marker','none','displayname','Hailstorm days');
plt1=plot(y01(:,1),residu,'color',[.4 .4 .4],...
    'LineStyle','-','linewidth',lw,'marker','none','displayname','Detrended hailstorm days');
plt2=plot(y01(:,1),IMF_hail(end,:),'color',popu_col,...
    'LineStyle','-','linewidth',lw+0.2,'marker','none','displayname',['Trend(' num2str(sum(CON_hail(end)),'%.2f') '%)']);
plt4=plot(y01(:,1),sum(IMF_hail(end-2:end,:),1),'color',[241,108,35]./255,...
    'LineStyle','-','linewidth',lw+0.2,'marker','none','displayname',['Trend+QCV+MDV(' num2str(sum(CON_hail(end-2:end)),'%.2f') '%)']);
pos=get(gca,'position');
lgd1 = legend();
legend('boxoff');
set(lgd1,'position',[pos(1)+0.15 pos(2)+0.3 .1 .04],'FontSize',fs-1,'FontName',FN);
yl=ylabel('(#)','FontSize',fs,'FontName',FN);
set(yl,'Units','normalized');
set(yl,'position',get(yl,'position') + [0 +0.15 0]);
set(gca,'xlim',[plot_yrbegin,plot_yrend])
set(gca,'xtick',[1500:100:1900 1948])
set(gca,'XMinorTick','on');
% set(gca,'TickDir','out');
set(gca,'ticklength',[0.012 0.006]);
set(gca,'linewidth',blw,'FontSize',fs,'FontName',FN);
yyaxis right
hold on;box on;grid off;set(gca,'GridLinestyle',':');
ax1.XAxis.Visible='off';
set(gca,'ytick',[],'ycolor','k','xticklabel',[])
set(gca,'xtick',[])
%-----------------------------------------temperature----------------------
ax2=axes('position',[.15 .57-.2+ypos .7 .2]);
yyaxis left
hold on;box on;grid off;set(gca,'GridLinestyle',':');
set(gca,'ycolor',cols(6,:))
set(gca,'ylim',[-0.72,0.1]);
h1=plot(x02(:,1),x02(:,2),'color',[91 176 155 100]./255,...
    'LineStyle','-','linewidth',lw,'marker','none','displayname','Temperature anomaly');
h2=plot(y01(:,1),IMF_temp(end,:),'color',cols(6,:),...
    'LineStyle','-','linewidth',lw,'marker','none','displayname','Temperature trend');
yl=ylabel('(^{o}C)','FontSize',fs,'FontName',FN);
% set(yl,'Units','normalized');
% set(yl,'position',get(yl,'position') - [0 +0.25 0]);
xlabel('Year','FontSize',fs,'FontName',FN);
set(gca,'ytick',-0.8:0.2:0.)
set(gca,'xlim',[plot_yrbegin,plot_yrend])
set(gca,'xtick',[1500:100:1900 1948])
set(gca,'XMinorTick','on');
set(gca,'ticklength',[0.012 0.006]);
set(gca,'linewidth',blw,'FontSize',fs,'FontName',FN);
%---------------------------------population-------------------------------
yyaxis right
hold on;box on;grid off;set(gca,'GridLinestyle',':');
set(gca,'ycolor',[43,106,153]./255);
ylim([0 6])
ylims = get(gca,'ylim');
% h3=plot(popu(:,1),popu(:,2)/10^8,'color',[43,106,153]./255,'LineStyle','-','linewidth',lw);
h4=plot(popu_tmp(:,1),popu_tmp(:,2)/10^8,'color',[43,106,153]./255,'LineStyle',...
    '-','linewidth',lw,'marker','o','markersize',2,...
    'markerfacecolor',[43,106,153]./255,'displayname','Population censuses');
pos=get(gca,'position');
lgd1 = legend([h1,h2,h4]);
legend('boxoff');
set(lgd1,'position',[pos(1)+0.123 pos(2)+0.16 .1 .04],'FontSize',fs-1,'FontName',FN);
yl=ylabel('(10^8#)');
set(gca,'xlim',[plot_yrbegin,plot_yrend])
set(gca,'xtick',[],'ytick',0:2:6)
set(gca,'XMinorTick','on');
% set(gca,'TickDir','out');
set(gca,'ticklength',[0.012 0.006]);
set(gca,'linewidth',blw,'FontSize',fs,'FontName',FN);
ax2.XAxis.Visible='off';

pos1=get(ax1,'position');
pos2=get(ax2,'position');

ax3=axes('position',[pos1(1) pos2(2) pos2(3) pos1(4)+pos2(4) ]);
hold on;box on;grid off;set(gca,'GridLinestyle',':');
ax3.YAxis.Visible='off';
set(gca,'color','none');
xlabel('Year','FontSize',fs,'FontName',FN);
set(gca,'xlim',[plot_yrbegin,plot_yrend])
set(gca,'xtick',[1500:100:1900 1948])
set(gca,'XMinorTick','on');
% set(gca,'TickDir','out');
set(gca,'ticklength',[0.012 0.006]);
set(gca,'linewidth',blw,'FontSize',fs,'FontName',FN);