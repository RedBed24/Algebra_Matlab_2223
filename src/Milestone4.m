cellArboles = cell(size(cellGrupos));

for i = 1 : size(cellGrupos, 2)
    participacion = zeros(size(cellGrupos{i}.Nodes.Name));
    for j = 1 : size(cellGrupos{i}.Nodes, 1)
        participacion(j) = sum(cellGrupos{i}.Edges.Weight(outedges(cellGrupos{i}, cellGrupos{i}.Nodes.Name(j))));
    end

    cellGrupos{i}.Edges.Weight = -cellGrupos{i}.Edges.Weight;
    arbol = minspantree(cellGrupos{i}, 'Root', find(participacion == max(participacion)));
    arbol.Edges.Weight = -arbol.Edges.Weight;

    arbol.Nodes.participacion = participacion;

    figure('Name', "Research group " + i)
    p = plot(arbol);
    p.LineWidth = arbol.Edges.Weight / 10;
    highlight(p, find(find(participacion == max(participacion))), 'NodeColor', 'red')
    
    cellArboles{i} = arbol;
end

save('Data/cellArboles.mat', 'cellArboles')
