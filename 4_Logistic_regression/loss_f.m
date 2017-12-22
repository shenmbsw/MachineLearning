function [ Loss ] = loss_f( x,y,w, lambda)

    m = size(w,2);
    [dim,n] = size(x);
    e = sum(exp(w.'*x),1);
    Loss = sum(log(e));
    for k = 1:size(w,2)
        spx = x(:,y==k);
        sx = sum(spx,2);
        Loss = Loss - sum(w.' * sx);
    end
    
% % % % another way to calculate NLL % % % %
%     w_yi = zeros(dim,n);
%     for i = 1:n
%         w_yi(:,i) = w(y(i));
%     end   
%     
%     Loss = sum(log(e) - sum(w_yi.*x,1) );
% % % % % % % % % % % % % % % % % % % % % %
   
    Loss = Loss + lambda * 0.5 * sum(sum(w.^2));
end
