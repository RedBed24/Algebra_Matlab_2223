load('Data/cellGrupos.mat', 'cellGrupos')

for i = 1 : size(cellGrupos, 2)
    figure('Name', "Research group " + i)
    p = plot(cellGrupos{i});
    % Anchura proporcional al peso, / 10 porque son muy grandes
    p.LineWidth = cellGrupos{i}.Edges.Weight / 10;
end
