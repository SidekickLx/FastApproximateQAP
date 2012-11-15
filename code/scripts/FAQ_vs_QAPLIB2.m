
load('../../data/graphm/09.20.2012/A.mat')
%%


for i=1:137
    FAQ.times(i)=A(i).FAQ.t;
    FAQ.obj(i)=A(i).FAQ.obj;
    
    PATH.times(i)=A(i).PATH.t;
    PATH.obj(i)=A(i).PATH.obj;

    U.times(i)=A(i).U.t;
    U.obj(i)=A(i).U.obj;

    QCV.times(i)=A(i).QCV.t;
    QCV.obj(i)=A(i).QCV.obj;
    
    RANK.times(i)=A(i).RANK.t;
    RANK.obj(i)=A(i).RANK.obj;

    I.times(i)=A(i).I.t;
    I.obj(i)=A(i).I.obj;

    Nvertices(i)=length(A(i).FAQ.p);
end
%%

ncols=5;
nrows=2;

figure(1), clf
subplot(nrows,ncols,1), hold on
plot(Nvertices,FAQ.obj./PATH.obj,'k.')
plot([min(Nvertices) max(Nvertices)],[1 1],'k')
set(gca,'Xscale','log','YScale','log')
axis('tight')
% xlabel('# of vertices')
ylabel('relative objective value')
title('PATH')

subplot(nrows,ncols,2), hold on
plot(Nvertices,FAQ.obj./U.obj,'k.')
plot([min(Nvertices) max(Nvertices)],[1 1],'k')
set(gca,'Xscale','log','YScale','log')
axis('tight')
title('U')

subplot(nrows,ncols,3), hold on
plot(Nvertices,FAQ.obj./QCV.obj,'k.')
plot([min(Nvertices) max(Nvertices)],[1 1],'k')
set(gca,'Xscale','log','YScale','log')
axis('tight')
title('QCV')


subplot(nrows,ncols,4), hold on
plot(Nvertices,FAQ.obj./RANK.obj,'k.')
plot([min(Nvertices) max(Nvertices)],[1 1],'k')
set(gca,'Xscale','log','YScale','log')
axis('tight')
title('RANK')

subplot(nrows,ncols,5), hold on
plot(Nvertices,FAQ.obj./I.obj,'k.')
plot([min(Nvertices) max(Nvertices)],[1 1],'k')
set(gca,'Xscale','log','YScale','log')
axis('tight')
title('I')

subplot(nrows,ncols,ncols+1), hold on
plot(Nvertices,FAQ.times./PATH.times,'k.')
plot([min(Nvertices) max(Nvertices)],[1 1],'k')
set(gca,'Xscale','log','YScale','log')
xlabel('# of vertices')
ylabel('relative time')

subplot(nrows,ncols,ncols+2), hold on
plot(Nvertices,FAQ.times./U.times,'k.')
plot([min(Nvertices) max(Nvertices)],[1 1],'k')
set(gca,'Xscale','log','YScale','log')


subplot(nrows,ncols,ncols+3), hold on
plot(Nvertices,FAQ.times./QCV.times,'k.')
plot([min(Nvertices) max(Nvertices)],[1 1],'k')
set(gca,'Xscale','log','YScale','log')

subplot(nrows,ncols,ncols+4), hold on
plot(Nvertices,FAQ.times./RANK.times,'k.')
plot([min(Nvertices) max(Nvertices)],[1 1],'k')
set(gca,'Xscale','log','YScale','log')

subplot(nrows,ncols,ncols+5), hold on
plot(Nvertices,FAQ.times./I.times,'k.')
plot([min(Nvertices) max(Nvertices)],[1 1],'k')
set(gca,'Xscale','log','YScale','log')

% legend('PATH','U','QCV','RANK')