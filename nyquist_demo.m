function [] = nyquist_demo(function_type, bandwidth)
    % function_type (string): the type of time-domain function for which the
    % Nyquist rate is demonstrated; can be 'sine' or 'sinc'

    % bandwidth (integer): the bandwidth of the time-domain function in kHz

    nyquist_rate = 2*bandwidth;
   
    if strcmp(function_type, 'sine')
        f_range = 5*bandwidth + 5;
        f = -1*f_range:0.001:f_range;
        
        square = ones(1, 1000*(nyquist_rate + 1));
        oversampled = [zeros(1, 1000), square, zeros(1, 1000), square,...
            zeros(1, 1000), ones(1, 1000*bandwidth), 1,...
            ones(1, 1000*bandwidth), zeros(1, 1000), square,...
            zeros(1, 1000), square, zeros(1, 1000)];
        critsampled = ones(1, length(f));
        
        undersampled = [ones(1, 1000*(2*bandwidth*(1 - 0.2))), 2*ones(1, 1000*0.2*bandwidth), ones(1, 1000*(2*bandwidth*(1 - 0.2))), 2*ones(1, 1000*0.2*bandwidth), ones(1, 1 + 1000*(2*bandwidth*(1 - 0.2))), 2*ones(1, 1000*0.2*bandwidth), ones(1, 1000*(2*bandwidth*(1 - 0.2))), 2*ones(1, 1000*0.2*bandwidth), ones(1, 1000*(2*bandwidth*(1 - 0.2)))];
        f_undersampled = -1000*bandwidth*(5 - 3*0.2) : 1000*bandwidth*(5 - 3*0.2);
        
        figure
        subplot(3, 1, 1)
        plot(f, oversampled)
        set(gca, 'YLim', [-1 3])
        subplot(3, 1, 2)
        plot(f, critsampled)
        set(gca, 'YLim', [-1 3])
        subplot(3, 1, 3)
        plot(f_undersampled, undersampled)
        set(gca, 'YLim', [-1 3])
        
    elseif strcmp(function_type, 'sinc')
        down_ramp = 1 : -1/1000 : 0;
        up_ramp = 0 : 1/1000 : 1;
        triangle = [up_ramp(1:1000), down_ramp(1:1000)];

        x_oversampled = -1*bandwidth*(5 + 3*0.2) : bandwidth/1000 : bandwidth*(5 + 3*0.2);
        x_critsampled = -1*bandwidth*(5) : bandwidth/1000 : bandwidth*(5);
        x_undersampled = -1*bandwidth*(5 - 5*0.2) : bandwidth/1000 : bandwidth*(5 - 5*0.2);
        
        oversampled = [zeros(1, 200), triangle, zeros(1, 200), triangle, zeros(1, 200), up_ramp(1:1000), 1, down_ramp(1:1000), zeros(1, 200), triangle, zeros(1, 200), triangle, zeros(1, 200)];
        critsampled = [triangle, triangle, up_ramp(1:1000), 1, down_ramp(1:1000), triangle, triangle];
        undersampled = [0.4*ones(1, 200), triangle(401:1600), 0.4*ones(1, 400), triangle(401:1600), 0.4*ones(1, 400), up_ramp(401:1000), 1, down_ramp(1:600), 0.4*ones(1, 400), triangle(401:1600), 0.4*ones(1, 400), triangle(401:1600), 0.4*ones(1, 200)];
        
        figure
        subplot(3, 1, 1);
        plot(x_oversampled, oversampled);
        set(gca, 'YLim', [-0.5 1.5])        
        subplot(3, 1, 2);
        plot(x_critsampled, critsampled);
        set(gca, 'YLim', [-0.5 1.5])
        subplot(3, 1, 3);
        plot(x_undersampled, undersampled);
        set(gca, 'YLim', [-0.5 1.5])
    end
end