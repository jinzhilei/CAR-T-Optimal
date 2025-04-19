% Find the PFS from the dynamics of tumor cells.

function T0 = findPFS(X)
j0 = max(find(X(:,2) <= X(1, 2))) + 1;
T0 = X(j0, 1);
end