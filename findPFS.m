% Find the PFS from the dynamics of tumor cells.

function T0 = findPFS(X)
if (X(end,2) > X(1,2))
    j0 = max(find(X(:,2) <= X(1, 2))) + 1;
else
    j0 = length(X);
end
T0 = X(j0, 1);
end
