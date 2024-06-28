arboles = cell(size(grafos));

% para cada grafo
for i = 1 : size(grafos, 2)
	grupo = grafos{i};

	grupo.Nodes.participacion = zeros(size(grupo.Nodes.Name));

	% para cada nodo del grafo
	for j = 1 : height(grupo.Nodes)
		nodo = grupo.Nodes(j, :);
		% su participacion es la suma de los pesos de las aristas incidentes al nodo
		grupo.Nodes.participacion(j) = sum(grupo.Edges.Weight(grupo.outedges(nodo.Name)));
	end

	% el principal es aquel que tenga la misma participacion igual al maximo del grupo
	grupo.Nodes.isprincipal = grupo.Nodes.participacion == max(grupo.Nodes.participacion);

	% cambiamos los pesos
	grupo.Edges.Weight = - grupo.Edges.Weight;
		% calculamos el arbol a partir del nodo principal
		arbol = grupo.minspantree('Root', find(grupo.Nodes.isprincipal));
	grupo.Edges.Weight = - grupo.Edges.Weight;
	arbol.Edges.Weight = - arbol.Edges.Weight;

	arboles{i} = arbol;

	figure('Name', "Research group " + i)
	p = plot(arbol);
	p.LineWidth = 2 * arbol.Edges.Weight / max(arbol.Edges.Weight) + 1;
	% [R, G, B] R = 1 para el principal, 0 para el resto. G = 0. B al
	% contrario que R
	p.NodeColor = [arbol.Nodes.isprincipal, zeros(size(arbol.Nodes.isprincipal)), ~arbol.Nodes.isprincipal];
end

save('Arboles.mat', 'arboles')