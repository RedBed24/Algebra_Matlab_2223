for i = 1 : size(arboles, 2)
	arbol = arboles{i};
	figure('Name', "Research group " + i)
	p = plot(arbol);
	p.LineWidth = 2 * arbol.Edges.Weight / max(arbol.Edges.Weight) + 1;
	p.NodeColor = [arbol.Nodes.isprincipal, zeros(size(arbol.Nodes.isprincipal)), ~arbol.Nodes.isprincipal];
	p.NodeLabel = arbol.Nodes.full_name;
	% para que el nodo con mas participacion (principal) sea el raiz (este
	% arriba) hacemos que la altura del nodo sea la participacion.
	% Usamos una escala lograritmica para que el raiz no este muy alto
	p.YData = log(arbol.Nodes.participacion);
end