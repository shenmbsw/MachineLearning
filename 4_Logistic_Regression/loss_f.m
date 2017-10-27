function [ Loss ] = loss_f( x,y,w, lambda)
    m = size(w,2);
    e = sum(exp(w.'*x),1);
    Loss = sum(log(e));
    for k = 1:size(w,2)
        spx = x(:,y==k);
        sx = sum(spx,2);
        Loss = Loss - sum(w.' * sx);
    end
   
    Loss = Loss + lambda * 0.5 * sum(sum(w.^2));
end