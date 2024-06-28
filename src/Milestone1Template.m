% Incremental practice for Algebra & Discrete Mathematics
% 2022-23
% 
% Name of the student: 
% Milestone 1
% Briefly describe the steps taken to address this milestone:
% 


clear all
clc;


%% Variable definition
data_dir = 'data/'; % Relative path to the data


%% Load graph data

opts = detectImportOptions(strcat(data_dir,'1_authors.csv'));
opts = setvartype(opts, {'ID_author','AU_ID_scopus','full_name','affiliation'}, {'int32','int64','string','string'});
autores = readtable(strcat(data_dir,'1_authors.csv'), opts);

opts = detectImportOptions(strcat(data_dir,'3_collaborations.csv'));
opts = setvartype(opts, {'ID_author_1','ID_author_2','scopus_id_collaborations'}, {'int32','int32','string'});
colaboraciones = readtable(strcat(data_dir,'3_collaborations.csv'), opts);

%% Preparacion calculo pesos

indicesPublicaciones = zeros(size(colaboraciones, 1), 1);

subLista = split(colaboraciones.scopus_id_collaborations(1), ',')';
indicesPublicaciones(1) = size(subLista, 2);
listaPublicaciones = subLista;

for i = 2 : size(colaboraciones, 1)
    subLista = split(colaboraciones.scopus_id_collaborations(i), ',')';
    indicesPublicaciones(i) = size(subLista, 2) + indicesPublicaciones(i - 1);
    listaPublicaciones = [listaPublicaciones, subLista];
end

%% Calculo pesos

pesos = zeros(size(colaboraciones, 1), 1);

publicaciones = unique(listaPublicaciones);
for i = 1 : size(publicaciones, 2)
    indicesPublicacion = find(strcmp(publicaciones(i), listaPublicaciones));

    for j = 1 : size(indicesPublicacion, 2)
        indice = find(indicesPublicaciones >= indicesPublicacion(j));
        pesos(indice(1)) = pesos(indice(1)) + 1 / size(indicesPublicacion, 2);
    end
end

%% Construct the graph

% Cambio ID a Nombre e int a string
autores = renamevars(autores, 'ID_author', 'Name');
autores.Name = string(autores.Name);

grafo = graph(colaboraciones.ID_author_1, colaboraciones.ID_author_2, pesos, autores);

%% Ver grafo

title('Collaboration graph')
plot(grafo, 'Layout', 'force')
