function func_plot_fig3(issave,filters,filters2,pstr,lstr,ystr,...
    yrange,ytick,cols,ts,fs,plot_yrbegin,...
    plot_yrend,blw,FN,fw)

width=700;
cols(6,:)=[162 179 73]./255;
cols(7,:)=[246 166 67]./255;
[rp1,pp1]=mycorr(filters(:,2),filters(:,4));
[rp2,pp2]=mycorr(filters2(:,2),filters2(:,4));
[rn1,pn1]=mycorr(filters(:,2),filters(:,3));
[rn2,pn2]=mycorr(filters2(:,2),filters2(:,3));

pp1
pp2
if pp1<0.05
    rp1_str = [num2str(rp1,'%.2f') '^{*}'];
else
    rp1_str = [num2str(rp1,'%.2f')];
end
if pp2<0.05
    rp2_str = [num2str(rp2,'%.2f') '^{*}'];
else
    rp2_str = [num2str(rp2,'%.2f')];
end

if pn1<0.05
    rn1_str = [num2str(rn1,'%.2f') '^{*}'];
else
    rn1_str = [num2str(rn1,'%.2f')];
end
if pn2<0.05
    rn2_str = [num2str(rn2,'%.2f') '^{*}'];
else
    rn2_str = [num2str(rn2,'%.2f')];
end

cmap2=nclcmap('MPL_RdGy',10);
patch1_col = ncl_cols('lightgray');%cmap2(4,:);
patch2_col = ncl_cols('white');%cmap2(7,:);
alpha1=0.3;
alpha2=0.1;
fig_mdv=figure('name',['mdv_' pstr]);set(fig_mdv,'position',[654 72 562 600]);
place = my_tight_subplot(4,1,[.03 .01],[.08 .05],[.1 .08]);
place(1,4)=place(1,4)+0.06;
place(1,2)=place(1,2)-0.04;
place(2:4,2)=place(2:4,2)-0.07;
place
axes('position',place(2,:));
hold on; box on;
set(gca,'xcolor','none');
set(gca,'ylim',[-7 7],'ytick',-4:2:4,'ycolor',cols(1,:));
% find phase
yy = filters(:,2);
yy(yy>0)=1;
yy(yy<=0)=0;
yy1(1)=yy(1);
yy1(2:length(yy))=yy(1:end-1);
ytag=yy1'-yy;
ind0=find(ytag~=0);
ind(1)=1;
ind(2:length(ind0)+1)=ind0;
ind(end+1)=449;
ylim=get(gca,'ylim');
for i=1:length(ind0)+1
    patch_x = [ts(ind(i)) ts(ind(i)) ts(ind(i+1)) ts(ind(i+1))];
    patch_y = [ylim(1) ylim(2) ylim(2) ylim(1)];
    if mod(i,2)~=0
        patch(patch_x,patch_y,patch1_col,'edgecolor','none','facealpha',alpha1);
%         patch(patch_x,patch_y,cols(2,:),'edgecolor','none','facealpha',0.3);
    else
        patch(patch_x,patch_y,patch2_col,'edgecolor','none','facealpha',alpha2);
%         patch(patch_x,patch_y,cols(5,:),'edgecolor','none','facealpha',0.3);
    end
end
h1=plot(filters(:,1),filters(:,2),'color',cols(1,:),'LineStyle','-','linewidth',1.3);
h12=plot(filters2(:,1),filters2(:,2),'color',cols(1,:),'LineStyle','--','linewidth',1.3);
text(1605,-5.2,'QCV','FontWeight','normal','FontSize',fs);
text(1660,-5.2,'MDV','FontWeight','normal','FontSize',fs);
% lgd = legend([h1,h12],{'80-100yr filter','50-70yr filter'});
% legend('boxoff');
% set(lgd,'position',[.65 .44 .1 .05],'FontSize',fs,'FontName',FN); 
ylabel('Hailstorm day (#)');
% text(1505,5.5,'(b)','FontWeight',fw,'FontSize',fs+2);
set(gca,'xlim',[plot_yrbegin,plot_yrend])
set(gca,'xtick',[1500:100:1900 1948],'xticklabel',[])
set(gca,'XMinorTick','on');
% set(gca,'TickDir','out');
set(gca,'ticklength',[0.012 0.006]);
set(gca,'linewidth',blw,'FontSize',fs,'FontName',FN);

place(3,2)=place(3,2)+0.03;
axes('position',place(3,:));
hold on;box on;
set(gca,'xcolor','none');
set(gca,'ylim',[-0.5 0.5],'ytick',-0.3:0.3:0.3,'ycolor',cols(7,:));
ylim=get(gca,'ylim');
for i=1:length(ind0)+1
    patch_x = [ts(ind(i)) ts(ind(i)) ts(ind(i+1)) ts(ind(i+1))];
    patch_y = [ylim(1) ylim(2) ylim(2) ylim(1)];
    if mod(i,2)~=0
        patch(patch_x,patch_y,patch1_col,'edgecolor','none','facealpha',alpha1);
%         patch(patch_x,patch_y,cols(2,:),'edgecolor','none','facealpha',0.3);
    else
        patch(patch_x,patch_y,patch2_col,'edgecolor','none','facealpha',alpha2);
%         patch(patch_x,patch_y,cols(5,:),'edgecolor','none','facealpha',0.3);
    end
end
h3=plot(filters(:,1),filters(:,4),'color',cols(7,:),'LineStyle','-','linewidth',1.3);
h32=plot(filters2(:,1),filters2(:,4),'color',cols(7,:),'LineStyle','--','linewidth',1.3);
ytpos=-0.03;
text(1570-2,0.5+ytpos,'PDO','FontWeight',fw,'FontSize',fs,'color',cols(7,:));
text(1605,0.5+ytpos,rp1_str,'FontWeight',fw,'FontSize',fs,'color',cols(7,:));
text(1663,0.5+ytpos,rp2_str,'FontWeight',fw,'FontSize',fs,'color',cols(7,:));
text(1570-2,0.5-0.15+ytpos,lstr,'FontWeight',fw,'FontSize',fs,'color',cols(6,:));
text(1605,0.5-0.15+ytpos,rn1_str,'FontWeight',fw,'FontSize',fs,'color',cols(6,:));
text(1663,0.5-0.15+ytpos,rn2_str,'FontWeight',fw,'FontSize',fs,'color',cols(6,:));
% if pp1<0.05
%     lgd = legend([h3],['PDO index (' num2str(rp1,'%.2f') '^{*})']);
% else
%     lgd = legend([h3],['PDO index (' num2str(rp1,'%.2f') ')']);
% end
% legend('boxoff');
% set(lgd,'position',[.653 .42+0.02 .1 .04],'FontSize',fs,'FontName',FN); 
ylabel('PDO index');
xlabel('Year');
set(gca,'xlim',[plot_yrbegin,plot_yrend])
set(gca,'xtick',[1500:100:1900 1948])
set(gca,'XMinorTick','on');
% set(gca,'TickDir','out');
set(gca,'ticklength',[0.012 0.006]);
set(gca,'linewidth',blw,'FontSize',fs,'FontName',FN);

place(4,2)=place(4,2)+0.06;
axes('position',place(4,:));
hold on; box on;
set(gca,'xcolor','none','ycolor',cols(6,:));
set(gca,'ylim',yrange,'ytick',ytick);
ylim=get(gca,'ylim');
for i=1:length(ind0)+1
    patch_x = [ts(ind(i)) ts(ind(i)) ts(ind(i+1)) ts(ind(i+1))];
    patch_y = [ylim(1) ylim(2) ylim(2) ylim(1)];
    if mod(i,2)~=0
        patch(patch_x,patch_y,patch1_col,'edgecolor','none','facealpha',alpha1);
%         patch(patch_x,patch_y,cols(2,:),'edgecolor','none','facealpha',0.3);
    else
        patch(patch_x,patch_y,patch2_col,'edgecolor','none','facealpha',alpha2);
%         patch(patch_x,patch_y,cols(5,:),'edgecolor','none','facealpha',0.3);
    end
end
h2=plot(filters(:,1),filters(:,3),'color',cols(6,:),'LineStyle','-','linewidth',1.3);
h22=plot(filters2(:,1),filters2(:,3),'color',cols(6,:),'LineStyle','--','linewidth',1.3);
% if pn1<0.05
%     lgd = legend([h2],['NAO index (' num2str(rn1,'%.2f') '^{*})']);
% else
%     lgd = legend([h2],['NAO index (' num2str(rn1,'%.2f') ')']);
% end
% legend('boxoff');
% set(lgd,'position',[.65 .39+0.02 .1 .04],'FontSize',fs,'FontName',FN); 
ylabel(ystr);
set(gca,'xlim',[plot_yrbegin,plot_yrend])
set(gca,'xtick',[1500:100:1900 1948],'xticklabel',[])
set(gca,'XMinorTick','on');
% set(gca,'TickDir','out');
set(gca,'ticklength',[0.012 0.006]);
set(gca,'linewidth',blw,'FontSize',fs,'FontName',FN);

xx=axes('position',[place(4,1) place(4,2) place(4,3) place(2,2)+place(2,4)-place(4,2)]);
hold on;box on;
set(gca,'color','none','ytick',[],'yticklabel',[],'ycolor','none');
ax.YAxisVisible='off';
xlabel('Year');
set(gca,'xlim',[plot_yrbegin,plot_yrend])
set(gca,'xtick',[1500:100:1900 1948])
set(gca,'XMinorTick','on');
set(gca,'ticklength',[0.012 0.006]);
set(gca,'linewidth',blw,'FontSize',fs,'FontName',FN);