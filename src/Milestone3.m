%% Cargar los grafos
load("Grafos.mat", "grafos")

%% Mostarlos y cambiar el tamaño de la linea
for i = 1 : size(grafos, 2)
	figure('Name', "Research group " + i)
	p = plot(grafos{i});
	% hacemos que sean proporcionales respecto a la mas pesada y para que
	% tengan un minimo le sumamos una constante
	p.LineWidth = 2 * grafos{i}.Edges.Weight / max(grafos{i}.Edges.Weight) + 1;
end