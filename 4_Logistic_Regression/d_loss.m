function [ dloss ] = d_loss( x,y,w, lambda )
    m = size(w,2);
    n = size(x,2);   
    p = softmax(w.'*x) - ind2vec(y);
    dloss = x*p.';
    dloss = dloss + lambda * w;    
end

