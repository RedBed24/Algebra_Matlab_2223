%% Encontrar umbral

umbral = 0;
n_anterior = -1;

while 1
    recortado = rmedge(grafo, find(grafo.Edges.Weight < umbral));
    [bins, binsizes] = conncomp(recortado);
    n = max(binsizes);

    if n == n_anterior
        break
    end

    n_anterior = n;
    umbral = umbral + 0.3;
end

%% Separar grupos

gruposValidos = find(binsizes >= 5);
cellGrupos = cell(size(gruposValidos));

for i = 1 : size(cellGrupos, 2)
    grupo = rmnode(recortado, find(bins ~= gruposValidos(i)));
    disp('Grupo'), disp(i)
    disp('Personas'), disp(size(grupo.Nodes, 1))
    cellGrupos{i} = grupo;
end

save('Data/cellGrupos.mat', 'cellGrupos')
