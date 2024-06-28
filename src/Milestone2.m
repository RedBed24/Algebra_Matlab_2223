% Inicializar
less_con = g;
n = 0;
prev_n = -1;

step = 0.3;
alpha = 0;

%% Busca el umbral
while n ~= prev_n
	alpha = alpha + step;
	% guardamos el valor anterior
	prev_n = n;

	% calculamos el valor nuevo
	% quitamos las aristas que tienen menor peso que el umbral
	less_con = less_con.rmedge(find(less_con.Edges.Weight < alpha));
	% calculamos las componentes conexas
	[bins, sizes] = conncomp(less_con);
	% obtenemos el numero de nodos en la componente mas grande
	n = max(sizes);
end

%% Obtener cada grafo por separado

% de todas las componentes, nos quedamos con aquellas con 5 nodos o mas
componentes_distintas = find(sizes >= 5);
grafos = cell(size(componentes_distintas));

% para cada componente
for i = 1 : size(componentes_distintas, 2)
	% buscamos los nodos a eliminar (aquellos que no sean de esta componente)
	nodes_idx = find(bins ~= componentes_distintas(i));
	grafos{i} = less_con.rmnode(nodes_idx);
	% mostramos el numero de nodos de esta componente (que es igual que sizes)
	disp("Numero de nodos de grupo " + i + ": " + grafos{i}.numnodes)
end

%% exportar datos
save('Grafos.mat', 'grafos')