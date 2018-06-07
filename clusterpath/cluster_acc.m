function acc = cluster_acc(y_true, y_pred)
res = bestMap(y_true, y_pred);
acc = sum(y_true == res)/length(y_true);
end

