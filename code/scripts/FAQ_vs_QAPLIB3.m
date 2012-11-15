clear

dataDir = '../../data/graphm/09.20.2012/';
figDir = '../../figs/';
fileName = 'allPathCompare';
load([dataDir, 'A.mat'])
savestuff=1;



%%

names=fieldnames(A(1));
algNames{1}=names{4};
algNames{2}=names{6};
algNames{3}=names{7};
algNames{4}=names{9};
algNames{5}=names{10};

numProbs=length(A);
numAlgs=length(algNames);
for i=1:numProbs
    
    for j=1:numAlgs
        times.(algNames{j})(i)=A(i).(algNames{j}).t;
        
        obj.(algNames{j})(i)=A(i).(algNames{j}).obj;
        laps.(algNames{j})(i)=A(i).(algNames{j}).laps;
    end
    
    obj_p(i)=A(i).obj_p;
    Nvertices(i)=length(A(i).FAQ.p);
end

allTimes=[];
allObjs=[];
allRelTimes=[];
allRelObjs=[];
for j=1:numAlgs
    rel.times.(algNames{j})=times.FAQ./times.(algNames{j});
    rel.obj.(algNames{j})=obj.FAQ./obj.(algNames{j});
    
    allTimes=[allTimes; times.(algNames{j})];
    allObjs=[allObjs; obj.(algNames{j})];
    
    allRelTimes=[allRelTimes; rel.times.(algNames{j})];
    allRelObjs=[allRelObjs; rel.obj.(algNames{j})];
    
end




%% plot PATH vs each comparisons


clc

ncols=5;
nrows=1;

YTickObj=[-1:.2:0.2];
XTick=log10([10 50 200]);
YTickTime=[1e-3 1e-1 10 600];
gray=0.75*[1 1 1];
ms=12;
log10N=log10(Nvertices);
figure(1), clf
afs=12;
fs=14;
tfs=16;
xText=log10(12);
for i=2:numAlgs
    
    y=log10(rel.obj.(algNames{i}));
    subplot(nrows,ncols,i-1), hold on
    plot(log10N,y,'k.','markersize',ms)
    plot([min(log10N) max(log10N)],[0 0],'color',gray)
    plot(mean(log10N),nanmean(y),'.','color',gray','markersize',2*ms)
    if i==2
        ylabel('log relative objective value','fontsize',fs)
        xlabel('# of vertices','fontsize',fs)
    end
    set(gca,'Xscale','log')
    set(gca,'YTick',YTickObj,'YTickLabel',YTickObj,'fontsize',afs)
    set(gca,'XTick',XTick,'XTickLabel',10.^XTick,'fontsize',afs)
    axis([min(log10N) max(log10N) log10(min(allRelObjs(:))) log10(max(allRelObjs(:)))])
    fracBetter=1-sum(y>0)/length(y);
    title(algNames{i},'fontsize',tfs)
    text(xText,0.2,sprintf('%% better = %0.2f', fracBetter),'fontsize',afs)
    
end

subplot(nrows,ncols,i), hold on
y=log10(max(allRelObjs(2:end,:)));
plot(log10N,y,'k.','markersize',ms)
plot([min(log10N) max(log10N)],[0 0],'color',gray)
plot(mean(log10N),nanmean(y),'.','color',gray','markersize',2*ms)
set(gca,'Xscale','log')
set(gca,'YTick',YTickObj,'YTickLabel',YTickObj)
set(gca,'XTick',XTick,'XTickLabel',10.^XTick)
axis([min(log10N) max(log10N) log10(min(allRelObjs(:))) log10(max(allRelObjs(:)))])
fracBetter=1-sum(y>0)/length(y);
title('all','fontsize',tfs)
text(xText,0.2,sprintf('%% better = %0.2f', fracBetter),'fontsize',afs)
%     title(sprintf('%% better = %0.2f', fracBetter))



% savestuff

figName=[figDir, 'allRelAccuracy'];
if savestuff
    wh=[6 2]*1.75;   %width and height
    set(gcf,'PaperSize',wh,'PaperPosition',[0 0 wh],'Color','w');
    print('-dpdf',figName)
    print('-dpng',figName)
    saveas(gcf,figName)
end


%% make table of object function values

obj_p(obj_p<0)=NaN;
clc

[foo bar]=min(allObjs);
for i=1:numProbs
    
    switch bar(i)
        case 1
            fprintf('%1.0f & %s & %1.3g & \\textbf{%1.3g} & %1.3g & %1.3g & %1.3g & %1.3g \\\\ \n', ...
                i, A(i).name, obj_p(i), ...
                A(i).FAQ.obj, A(i).PATH.obj, A(i).QCV.obj, A(i).RANK.obj, A(i).U.obj)
        case 2
            fprintf('%1.0f & %s & %1.3g & %1.3g & \\textbf{%1.3g} & %1.3g & %1.3g & %1.3g \\\\ \n', ...
                i, A(i).name, obj_p(i), ...
                A(i).FAQ.obj, A(i).PATH.obj, A(i).QCV.obj, A(i).RANK.obj, A(i).U.obj)
        case 3
            fprintf('%1.0f & %s & %1.3g & %1.3g & %1.3g & \\textbf{%1.3g} & %1.3g & %1.3g \\\\ \n', ...
                i, A(i).name, obj_p(i), ...
                A(i).FAQ.obj, A(i).PATH.obj, A(i).QCV.obj, A(i).RANK.obj, A(i).U.obj)
        case 4
            fprintf('%1.0f & %s & %1.3g & %1.3g & %1.3g & %1.3g & \\textbf{%1.3g} & %1.3g \\\\ \n', ...
                i, A(i).name, obj_p(i), ...
                A(i).FAQ.obj, A(i).PATH.obj, A(i).QCV.obj, A(i).RANK.obj, A(i).U.obj)
        case 5
            fprintf('%1.0f & %s & %1.3g & %1.3g & %1.3g & %1.3g & %1.3g & \\textbf{%1.3g} \\\\ \n', ...
                i, A(i).name, obj_p(i), ...
                A(i).FAQ.obj, A(i).PATH.obj, A(i).QCV.obj, A(i).RANK.obj, A(i).U.obj)
    end
end

length(find(bar==1))/length(y)

%% plot times
clc
figure(4), clf, hold all
colors{1}='k'; markers{1}='.';
colors{2}='r'; markers{2}='x';
colors{3}='b'; markers{3}='*';
colors{4}='g'; markers{4}='o';
colors{5}='m'; markers{5}='+';
markersizes=[12 8 8 8 8 8 8];
b=zeros(2,numAlgs);
for i=1:numAlgs
    Y=log10(times.(algNames{i}));
    h(i)=plot(log10N,Y,'.','color',colors{i},'marker',markers{i},'markersize',markersizes(i));
    b(:,i)=robustfit(log10N,Y);
    plot(log10N,b(1,i)+b(2,i)*log10N,'-','color',colors{i},'linewidth',2)
    if i~=7
        text(max(log10N)+.05,b(1,i)+b(2,i)*max(log10N),num2str(round(b(2,i)*10)/10))
    end
end
xlabel('log10(N)')
ylabel('log10(seconds)')
legend(h, algNames{1}, algNames{2},  algNames{3},  algNames{4},  algNames{5},'Location','NorthWest')
axis([min(log10N), max(log10N)+0.1, -2.5, 3])
figName=[figDir, 'allEfficiency'];

if savestuff
    wh=[3 2]*1.75;   %width and height
    set(gcf,'PaperSize',wh,'PaperPosition',[0 0 wh],'Color','w');
    print('-dpdf',figName)
    print('-dpng',figName)
    saveas(gcf,figName)
end

%% plot accuracy vs efficiency

clc
figure(5), clf, hold all
markersizes=[20 7 7 7 7];
for i=1:numAlgs
    acc=(obj.(algNames{i}));
    %     eff=log10(times.(algNames{i}));
    h(i)=plot(median(acc),b(2,i),'.','color',colors{i},'marker',markers{i},'markersize',markersizes(i),'linewidth',2);
    %     b(:,i)=robustfit(X,Y);
    %     plot(X,b(1,i)+b(2,i)*X,'-','color',colors{i},'linewidth',2)
    
end
xlabel('objective value')
ylabel('slope')
legend(h, algNames{1}, algNames{2},  algNames{3},  algNames{4},  algNames{5},'Location','Best')
% axis([min(X), max(X)+0.1, -2.5, 3])
axis('tight')
figName=[figDir, 'accuracy_v_efficiency'];

if savestuff
    wh=[3 2]*1.75;   %width and height
    set(gcf,'PaperSize',wh,'PaperPosition',[0 0 wh],'Color','w');
    print('-dpdf',figName)
    print('-dpng',figName)
    saveas(gcf,figName)
end


%%

[sortObjVal sortObjAlg]=sort(allObjs);
[sortTimVal sortTimAlg]=sort(allTimes);



%% plot PATH vs FAQ comparisons


clc

ncols=3;
nrows=2;

YTickObj=[-1:.2:0.2];
XTick=log10([10 50 200]);
YTickTime=[1e-3 1e-1 10 600];
gray=0.75*[1 1 1];
ms=12;
log10N=log10(Nvertices);

for i=2 %2:numAlgs

    figure(i), clf

    y=log10(rel.obj.(algNames{i}));
    subplot(nrows,ncols,1), hold on
    plot(log10N,y,'k.','markersize',ms)
    plot([min(log10N) max(log10N)],[0 0],'color',gray)
    plot(mean(log10N),nanmean(y),'.','color',gray','markersize',2*ms)
    ylabel('log relative objective value')
    % ylabel('log(f_F/f_P)')
    xlabel('# of vertices')
    set(gca,'Xscale','log')
    set(gca,'YTick',YTickObj,'YTickLabel',YTickObj)
    set(gca,'XTick',XTick,'XTickLabel',10.^XTick)
    axis([min(log10N) max(log10N) min(y) max(y)])
    fracBetter=1-sum(y>0)/length(y);
    title(sprintf('%% better = %0.2f', fracBetter))


    subplot(nrows,ncols,2), hold on
    yTime=log10(rel.times.(algNames{i}));
    plot(log10N,yTime,'k.','markersize',ms)
    plot([min(log10N) max(log10N)],[0 0],'color',gray)
    b=robustfit(log10N,yTime);
    plot(log10N,b(1)+b(2)*log10N,'-','color',gray,'linewidth',2)
    ylabel('log relative time')
    xlabel('# of vertices')
    set(gca,'XTick',XTick,'XTickLabel',10.^XTick)
    axis([min(log10N) max(log10N) min(yTime) max(yTime)])
    fracBetter=1-sum(yTime>0)/length(y);
    title(sprintf('%% better = %0.2f', fracBetter))

    subplot(nrows,ncols,3), hold on
    plot(y,yTime,'k.','markersize',ms)
    plot([0 0],[-4 3],'color',gray)
    plot([-2 2],[0 0],'color',gray)
    plot(nanmean(y),nanmean(yTime),'.','color',gray','markersize',2*ms)
    ylabel('log relative time')
    xlabel('log relative objective function')
    axis([min(y) max(y) min(yTime) max(yTime)])
    fracBetter=1-(sum(yTime>0)+sum(y>0))/length(y);
    title(sprintf('%% better = %0.2f', fracBetter))


end

% savestuff

figName=[figDir, 'allPathCompare'];
if savestuff
    wh=[4 2]*1.75;   %width and height
    set(gcf,'PaperSize',wh,'PaperPosition',[0 0 wh],'Color','w');
    print('-dpdf',figName)
    print('-dpng',figName)
    saveas(gcf,figName)
end
