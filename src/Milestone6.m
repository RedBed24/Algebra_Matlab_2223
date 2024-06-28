nombres = strings(size(arboles));
% para buscar informacion sobre el nombre del grupo, busca los nombres de
% los investigadores. Todos parecen ser de la UCLM  
nombres(1) = "primer grupo";
nombres(2) = "segundo grupo";
nombres(3) = "tercer grupo";
nombres(4) = "primer grupo";
nombres(5) = "primer grupo";
nombres(6) = "primer grupo";
nombres(7) = "primer grupo";
nombres(8) = "primer grupo";
nombres(9) = "primer grupo";
nombres(10) = "primer grupo";
nombres(11) = "primer grupo";

for i = 1 : size(arboles, 2)
	arbol = arboles{i};
	figure('Name', "Research group " + nombres(i))
	p = plot(arbol);
	p.LineWidth = 2 * arbol.Edges.Weight / max(arbol.Edges.Weight) + 1;
	p.NodeColor = [arbol.Nodes.isprincipal, zeros(size(arbol.Nodes.isprincipal)), ~arbol.Nodes.isprincipal];
	p.NodeLabel = arbol.Nodes.full_name;
	% para que el nodo con mas participacion (principal) sea el raiz (este
	% arriba) hacemos que la altura del nodo sea la participacion.
	% Usamos una escala lograritmica para que el raiz no este muy alto
	p.YData = log(arbol.Nodes.participacion);
end
