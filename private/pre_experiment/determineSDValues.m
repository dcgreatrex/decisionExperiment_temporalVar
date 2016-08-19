function determineSDValues()

% sdArray = []
% for (i = 1:50000)
%     IOIarray = testCompute(2, 7, 0.250);
%     sdArray(i) = std(IOIarray);
% end
% figure
% plot(sdArray)
% hist(sdArray)
% m = mean(sdArray)
% low_lb = m - (std(sdArray)*2.5)
% low_hb = m - (std(sdArray)*1)
% high_lb = m + (std(sdArray)*1)
% high_hb = m + (std(sdArray)*2.5)
% print('Mean = ', m)
% print('Low_lb =', low_lb)
% print('Low_hb =', low_hb)
% print('High_lb =', low_lb)
% print('High_hb =', low_hb)


% 3 IOIs - 4 targets
% m = 0.0787
% low_lb = 0.0164
% low_hb = 0.0538
% high_lb = 0.1037
% high_hb = 0.1411

% 4 IOIs - 5 targets
% m = 0.0756;
% low_lb = 0.0295;
% low_hb = 0.0572;
% high_lb = 0.0941;
% high_hb = 0.1218;

% 5 IOIs - 6 targets
% m = 0.0744
% low_lb = 0.0359
% low_hb = 0.0590
% high_lb = 0.0898
% high_hb = 0.1130

% 6 IOIs - 7 targets
% m = 0.0737
% low_lb = 0.0398
% low_hb = 0.0601
% high_lb = 0.0872
% high_hb = 0.1075

% 7 IOIs - 8 targets
% m = 0.0731
% low_lb = 0.0428
% low_hb = 0.0610
% high_lb = 0.0852
% high_hb = 0.1033

% 8 IOIs - 9 targets
% m = 0.0727;
% low_lb = 0.0450;
% low_hb = 0.0616;
% high_lb = 0.0838;
% high_hb = 0.1004;

l_lb = [0.0164,0.0295,0.0359,0.0398,0.0428,0.0450];
l_hb = [0.0538,0.0572,0.0590,0.0601,0.0610,0.0616];
h_lb = [0.1037,0.0941,0.0898,0.0872,0.0852,0.0838];
h_hb = [0.1411,0.1218,0.1130,0.1075,0.1033,0.1004];


value = [];
for(j = 1:1000)
	while true
	    IOIarray = testCompute(2, 9, 0.250);
	    sd = std(IOIarray);
	    if (sd > 0.0349 && sd < 0.0588)
	        disp(sd);
	        value(j) = sd;
	        disp(IOIarray);
	    	break
	    else
	    	continue
	    end
	end
end
hist(value)

value = [];
for(j = 1:1000)
	while true
	    IOIarray = testCompute(2, 9, 0.250);
	    sd = std(IOIarray);
	    if (sd > 0.0906 && sd < 0.1145)
	        disp(sd);
	        value(j) = sd;
	        disp(IOIarray);
	    	break
	    else
	    	continue
	    end
	end
end
hist(value)