clc;
clear;
% The widths and lengths below are used to define 
the rectangular links of the 2 DOF robot
len1 = 0.75;%half width of link 1
wid1 = 0.05;%half thickness of link 1
len2 = 0.5;%half width of link 2
wid2 = 0.05;%half thickness of link 2
%origin of link 1 
x1 = 0;
y1 = 0;
%Obstacles are defined in the co-ordinate space as 
shown
shape1 = [1 1;2 1;2 2.5;1 2.5];
shape2 = [-1.5 -1;-1 -1.5;-1 -2; -1.5, -2.5];
shape3 = [1 -2; 1 -1;2 0; 2 -2];

%Change in theta at every step for theta 1 and 2 
respectively
t1 = 10;
t2 = 30;
link1_shape = [-len1, -wid1; len1, -wid1; len1, 
wid1; -len1, wid1];
link2_shape = [-len2, -wid2; len2, -wid2; len2, 
wid2; -len2, wid2];
axis([-5 5 -5 5]);
daspect([1 1 1]);
grid on;
hold on;
grid on;
fill(shape1(:,1), shape1(:,2), 'y');
fill(shape2(:,1), shape2(:,2), 'r');
fill(shape3(:,1), shape3(:,2), 'c');
l1handle = fill(link1_shape(:,1), link1_shape(:,2), 
'b');
l2handle = fill(link2_shape(:,1), link2_shape(:,2), 
'g');
o1 = polyshape(shape1(:,1),shape1(:,2));
o2 = polyshape(shape2(:,1),shape2(:,2));
o3 = polyshape(shape3(:,1),shape3(:,2));
hold off;
for theta1 = t1:5:360+t1
    for theta2 = t2:5:360+t2
 	%when links are rotated about origin
 	rotated_l1_shape = 
link1_shape*[cosd(theta1) sind(theta1);-
sind(theta1), cosd(theta1)];
 
 
 	rotated_l2_shape = 
link2_shape*[cosd(theta2+theta1) 
sind(theta2+theta1);-sind(theta2+theta1), 
cosd(theta2+theta1)];
 
 %origin for link 2
 
    X1=x1+len1*cosd(theta1);
 
    Y1=y1+len1*sind(theta1);
 
    set(l1handle, 'xdata', 
X1+rotated_l1_shape(:,1),'ydata', 
Y1+rotated_l1_shape(:,2));
    l1 = 
polyshape(X1+rotated_l1_shape(:,1),Y1+rotated_l1_sh
ape(:,2));
    x2 = x1+2*len1*cosd(theta1);
    y2 = y1+2*len1*sind(theta1);
    X2=x2+len2*cosd(theta1+theta2);
    Y2=y2+len2*sind(theta1+theta2);
    set(l2handle, 'xdata', 
X2+rotated_l2_shape(:,1),'ydata', 
Y2+rotated_l2_shape(:,2)); 
   l2 = polyshape(X2+rotated_l2_shape(:,1), 
Y2+rotated_l2_shape(:,2));
 %For checking intersection of links and 
obstacles
    check = 0;
    if overlaps(l1,o1) || overlaps(l2,o1)
    check = 1;
    elseif overlaps(l1,o2) || overlaps(l2,o2)
    check = 2;
    elseif overlaps(l1,o3) || overlaps(l2,o3)
    check = 3;
    end
    check;
    %C - Space 
    figure(2);
    title('Configurational Space')
    xlabel('theta1')
    ylabel('theta2')
    x = theta1+1-t1;
    y = theta2+1-t2;
    hold on
    if check == 1
    plot(x,y,'y.')
    elseif check == 2
    plot(x,y,'r.')
    elseif check == 3
    plot(x,y,'c.')
    else
    plot(x,y,'b.')
    end
    axis([0 360 0 360])
    drawnow limitrate
 end
end
