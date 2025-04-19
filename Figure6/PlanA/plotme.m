function plotme()
figure(1);
clf();
for i=1:6
    subplot(2,3,i);
    A=load(strcat('md',num2str(i),'.dat'));
    semilogy(A(:,1),A(:,7));
end