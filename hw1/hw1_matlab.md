<!-- title: hw1 matlab -->
# P2.8

## part 1

```matlab
function [y,m] = dnsample(x,n,M)
    % downsample sequence x(n) by a factor M to obtain y(m)
    m = n(1:M:length(n));
    y = x(1:M:length(x));
end
```

## part 2

```matlab
n = -50:50;
x = sin(.125*pi*n);
[y,m] = dnsample(x,n,4);

subplot(2,1,1);
stem(n,x);
xlabel('n');
ylabel('x(n)');
title('x(n) vs n');

subplot(2,1,2);
stem(m,y);
xlabel('m');
ylabel('y(m)');
title('y(m) vs m');

saveas(gcf,'p282.png');
```

![p282](p282.png)

We can see from these plots that downsampling the signal `x(n)` by `4` gives us less information about the signal.  After downsamping `y(m)` now does not look like a sign wave, but it looks like a train of 2 impulses then the same 2 impulses but negative.  Both graphs have the same period but `y(m)` has a lower amplitude than `x(n)`

## part 3

```matlab
n = -50:50;
x = sin(.5*pi*n);
[y,m] = dnsample(x,n,4);

subplot(2,1,1);
stem(n,x,'red', 'filled');
xlabel('n');
ylabel('x(n)');
title('x(n) vs n');

subplot(2,1,2);
stem(m,y,'blue', 'filled');
xlabel('m');
ylabel('y(m)');
title('y(m) vs m');

saveas(gcf,'p283.png');
```

![](p283.png)

From these new plots we see that when we downsample the signal `x(n) = sin(.5*pi*n)` by `4` we lose most of the information expecially the amplitude.  Now the period is different and the signal does not even look periodic.  So downsampling signals can lose most of the information from the original signal which will make the downsampled signal look completely different from the original plot.

# P2.16

## part 1

$$x(n) = (0.8)^n u(n)$$

$$h(n) = (-0.9)^n u(n)$$

$$
\begin{aligned}
    y(n) =& h(n) * x(n) \\
    =& \sum_{k = - \infin}^{\infin} h(k) x(n-k) \\
    =& \sum_{k = - \infin}^{\infin} (-0.9)^k u(k) (0.8)^{n-k} u(n-k)\\
    &\text{because there is a } u(k) \text{ and } u(n-k) \\
    &\text{we can change the bounds on the sum and factor out a step function} \\
    =& u(n) \sum_{k = 0}^{n} (-0.9)^k (0.8)^{n-k}\\
    =& u(n) \sum_{k = 0}^{n} (-0.9)^k (0.8)^n (0.8)^{-k}\\
    =& u(n) (0.8)^n \sum_{k = 0}^{n} (-0.9)^k (0.8)^{-k}\\
    =& u(n) (0.8)^n \sum_{k = 0}^{n} \left(\tfrac{-9}{8}\right)^{k}\\
    &\text{this is a geometric series}\\
    =& u(n) (0.8)^n \frac{1-\tfrac{-9}{8}^{n+1}}{1-\tfrac{-9}{8}}\\
    =& \tfrac{8}{17} (0.8)^n (1-\tfrac{-9}{8}^{n+1}) u(n) \\
\end{aligned}
$$

```matlab
n = (0:50);
y1 = (8/17) .* (0.8).^n .* (1-(-9/8).^(n+1));
subplot(1,3,1);
stem(n,y1);
xlabel('n');
ylabel('y(n)');
title('Analytical: y(n) vs n');
```

The graph from this solution is exact.

## part 2

```matlab
x = 0.8.^n;
x = x(1:26);
h = (-0.9).^n;
h = h(1:26);
y2 = conv(x,h);
subplot(1,3,2);
stem(n,y2);
xlabel('n');
ylabel('y(n)');
title('Conv: y(n) vs n');
```

The convolution of $y(n) = h(n) * x(n)$ is also the exact solution.

## part 3

`conv(h,x)` is equal to `filter(h,1,x)`

The `1` means that the recursive coefficients of the filter are `1`.

```matlab
x = 0.8.^n;
h = (-0.9).^n;
y3 = filter(h,1,x);
subplot(1,3,3);
stem(n,y3);
xlabel('n');
ylabel('y(n)');
title('Filter: y(n) vs n');
saveas(gcf,'p216.png');
```

![](p216.png)

The `filter` method is an infinite sequence `x(n)` which is represented by coefficients of an equivalent filter.

This would mean that the `filter` method would be correct but it is only correct for the first samples where the last samples are not as correct.
