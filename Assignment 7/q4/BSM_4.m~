function [] = Lab7_Q4()
    clc;
    figure_i = 1;
    figure_name = 'Lab7_Q4-Figure';
    % Parameters for classical BSM.
    T = 1; K = 1; r = 0.05; sig = 0.6; t = 0; s = 0.5;

    % Sensitivity of Call Options.
    % Varying s.
    s_vec = 0.5:0.01:1.5;
    fig_name = ['Sensitivity of C with respect to S (S = ', num2str(s_vec(1)), ' to ', num2str(s_vec(length(s_vec))), ' with an increment of ', num2str(s_vec(2) - s_vec(1)), ')'];
    p = figure('Position', [0, 0, 640, 480], 'Name', fig_name);
    delta_call = BSCallDelta(T, K, r, sig, t, s_vec);
    plot(s_vec, delta_call, 'r');
    grid on
    xlabel('S');
    ylabel('\Delta');
    title(fig_name);
    saveas(p, [figure_name, num2str(figure_i)], 'png');
    figure_i = figure_i + 1;

    % Varying sigma.
    sig_vec = 0.3:0.01:0.9;
    fig_name = ['Sensitivity of C with respect to \sigma (\sigma = ', num2str(sig_vec(1)), ' to ', num2str(sig_vec(length(sig_vec))), ' with an increment of ', num2str(sig_vec(2) - sig_vec(1)), ')'];
    p = figure('Position', [0, 0, 640, 480], 'Name', fig_name);
    vega_call = BSVega(T, K, r, sig_vec, t, s);
    plot(sig_vec, vega_call, 'r');
    grid on
    xlabel('\sigma');
    ylabel('\nu');
    title(fig_name);
    saveas(p, [figure_name, num2str(figure_i)], 'png');
    figure_i = figure_i + 1;

    % Varying t.
    t_vec = 0:0.01:1;
    fig_name = ['Sensitivity of C with respect to t (t = ', num2str(t_vec(1)), ' to ', num2str(t_vec(length(t_vec))), ' with an increment of ', num2str(t_vec(2) - t_vec(1)), ')'];
    p = figure('Position', [0, 0, 640, 480], 'Name', fig_name);
    theta_call = BSCallTheta(T, K, r, sig, t_vec, s);
    plot(t_vec, theta_call, 'r');
    grid on
    xlabel('t');
    ylabel('\Theta');
    title(fig_name);
    saveas(p, [figure_name, num2str(figure_i)], 'png');
    figure_i = figure_i + 1;

    % Varying r.
    r_vec = 0:0.01:0.5;
    fig_name = ['Sensitivity of C with respect to r (r = ', num2str(r_vec(1)), ' to ', num2str(r_vec(length(r_vec))), ' with an increment of ', num2str(r_vec(2) - r_vec(1)), ')'];
    p = figure('Position', [0, 0, 640, 480], 'Name', fig_name);
    rho_call = BSCallRho(T, K, r_vec, sig, t, s);
    plot(r_vec, rho_call, 'r');
    grid on
    xlabel('r');
    ylabel('\rho');
    title(fig_name);
    saveas(p, [figure_name, num2str(figure_i)], 'png');
    figure_i = figure_i + 1;

    % Sensitivity of Put Options.
    % Varying s.
    s_vec = 0.5:0.01:1.5;
    fig_name = ['Sensitivity of P with respect to S (S = ', num2str(s_vec(1)), ' to ', num2str(s_vec(length(s_vec))), ' with an increment of ', num2str(s_vec(2) - s_vec(1)), ')'];
    p = figure('Position', [0, 0, 640, 480], 'Name', fig_name);
    delta_put = BSPutDelta(T, K, r, sig, t, s_vec);
    plot(s_vec, delta_put, 'b');
    grid on
    xlabel('S');
    ylabel('\Delta');
    title(fig_name);
    saveas(p, [figure_name, num2str(figure_i)], 'png');
    figure_i = figure_i + 1;

    % Varying sigma.
    sig_vec = 0.3:0.01:0.9;
    fig_name = ['Sensitivity of P with respect to \sigma (\sigma = ', num2str(sig_vec(1)), ' to ', num2str(sig_vec(length(sig_vec))), ' with an increment of ', num2str(sig_vec(2) - sig_vec(1)), ')'];
    p = figure('Position', [0, 0, 640, 480], 'Name', fig_name);
    vega_put = BSVega(T, K, r, sig_vec, t, s);
    plot(sig_vec, vega_put, 'b');
    grid on
    xlabel('\sigma');
    ylabel('\nu');
    title(fig_name);
    saveas(p, [figure_name, num2str(figure_i)], 'png');
    figure_i = figure_i + 1;

    % Varying t.
    t_vec = 0:0.01:1;
    fig_name = ['Sensitivity of P with respect to t (t = ', num2str(t_vec(1)), ' to ', num2str(t_vec(length(t_vec))), ' with an increment of ', num2str(t_vec(2) - t_vec(1)), ')'];
    p = figure('Position', [0, 0, 640, 480], 'Name', fig_name);
    theta_put = BSPutTheta(T, K, r, sig, t_vec, s);
    plot(t_vec, theta_put, 'b');
    grid on
    xlabel('t');
    ylabel('\Theta');
    title(fig_name);
    saveas(p, [figure_name, num2str(figure_i)], 'png');
    figure_i = figure_i + 1;

    % Varying r.
    r_vec = 0:0.01:0.5;
    fig_name = ['Sensitivity of P with respect to r (r = ', num2str(r_vec(1)), ' to ', num2str(r_vec(length(r_vec))), ' with an increment of ', num2str(r_vec(2) - r_vec(1)), ')'];
    p = figure('Position', [0, 0, 640, 480], 'Name', fig_name);
    rho_put = BSPutRho(T, K, r_vec, sig, t, s);
    plot(r_vec, rho_put, 'b');
    grid on
    xlabel('r');
    ylabel('\rho');
    title(fig_name);
    saveas(p, [figure_name, num2str(figure_i)], 'png');
end

function [delta_fn] = BSCallDelta(T, K, r, sig, t, s)
    d1 = log(s / K) + ((r + (sig * sig / 2)) * (T - t));
    d1 = d1 ./ (sig * sqrt(T - t));
    delta_fn = normcdf(d1);
end

function [delta_fn] = BSPutDelta(T, K, r, sig, t, s)
    delta_fn = BSCallDelta(T, K, r, sig, t, s) - 1;
end

function [vega_fn] = BSVega(T, K, r, sig, t, s)
    d1 = log(s / K) + ((r + (sig .* sig / 2)) * (T - t));
    d1 = d1 ./ (sig .* sqrt(T - t));
    vega_fn = normpdf(d1) .* s .* sqrt(T - t);
end

function [theta_fn] = BSCallTheta(T, K, r, sig, t, s)
    d1 = log(s / K) + ((r + (sig * sig / 2)) .* (T - t));
    d1 = d1 ./ (sig .* sqrt(T - t));
    d2 = d1 - (sig .* sqrt(T - t));
    theta_fn = (-s .* normpdf(d1) * sig) ./ (2 * sqrt(T - t));
    theta_fn = theta_fn - (r * K .* exp(-r .* (T - t)) .* normcdf(d2));
end

function [theta_fn] = BSPutTheta(T, K, r, sig, t, s)
    d1 = log(s / K) + ((r + (sig * sig / 2)) .* (T - t));
    d1 = d1 ./ (sig .* sqrt(T - t));
    d2 = d1 - (sig .* sqrt(T - t));
    theta_fn = (-s .* normpdf(d1) * sig) ./ (2 * sqrt(T - t));
    theta_fn = theta_fn + (r * K .* exp(-r .* (T - t)) .* normcdf(-d2));
end

function [rho_fn] = BSCallRho(T, K, r, sig, t, s)
    d1 = log(s / K) + ((r + (sig * sig / 2)) .* (T - t));
    d1 = d1 ./ (sig * sqrt(T - t));
    d2 = d1 - (sig * sqrt(T - t));
    rho_fn = (K .* (T - t) .* exp(-r .* (T - t))) .* normcdf(d2);
end

function [rho_fn] = BSPutRho(T, K, r, sig, t, s)
    d1 = log(s / K) + ((r + (sig * sig / 2)) .* (T - t));
    d1 = d1 ./ (sig * sqrt(T - t));
    d2 = d1 - (sig * sqrt(T - t));
    rho_fn = (-K .* (T - t) .* exp(-r .* (T - t))) .* normcdf(-d2);
end