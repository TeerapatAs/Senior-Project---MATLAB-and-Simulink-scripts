%p0 = [1.77e-3;0.14;11.40;72.60] %PID
p0 = [1.84;13.1]*10^-3;
% eps 1 is for stability. 0->stable. 1->unstable.
% eps 2 is for w
% eps 3 is for pg

option(1) = 2;
options(14) = 1000;

%phi = Algorithm1_TChuman_turbine(p0);

%Phase 1
epsilon1 = [-1e-6];
plb = [ 0; 0];
pub = [  20;  20;];
alpha = abciss_of_stability(p0);

if alpha >= -10e-6 %if not stable
    options(1) = 0;
    options(14) = 1000;
    [p0,alpha,v] = mbp1('abciss_of_stability',p0,epsilon1,options,plb,pub);
end
disp('p0 = ')
disp(p0);


% Don't forget to check M,D in algorithm.
% Phase 2
epsilon = [-1e-6;107e-3; 1.667e-3];
options(1) = 1;
options(14) = 1000;
[p,phi,v] = mbp1('Algorithm1_TChuman_turbine', p0, epsilon, options, plb, pub)

%varNames = ["p1","p2","p3","p4","w_maj","pg_maj"];
%fprintf('%12s %12s %12s %12s %12s %12s',varNames)
%fprintf('\n %12.8d %12.8f %12.8f %12.8f %12.8f %12.8f',p(1),p(2),p(3),p(4),phi(2),phi(3))

varNames = ["p1","p2","w_maj","pg_maj"];
fprintf('%12s %12s %12s %12s',varNames)
fprintf('\n %12.8d %12.8f %12.8f %12.8f',p(1),p(2),phi(2),phi(3)*1000)
%%
%{
fig = get_param('Model_Tchuman_linearmodel_verPDF','Handle')
saveas(fig,'MySimulinkDiagram2.jpg');
%}