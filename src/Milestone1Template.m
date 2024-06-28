% Incremental practice for Algebra & Discrete Mathematics
% 2022-23
% 
% Name of the student: 
% Milestone 1
% Briefly describe the steps taken to address this milestone:
% 
% Cambiar ejemplo por los datos que se esperan
% Añadir otra lectura para el otro fichero
% Cambiar el nombre para la tabla
% Calcular los pesos
% Crear el grafo, añadir los nodos y aristas
% mostrar el grafo

clear all
clc;


%% Variable definition
data_dir = 'data/'; % Relative path to the data


%% Load graph data

opts = detectImportOptions(strcat(data_dir,'1_authors.csv'));
opts = setvartype(opts, {'ID_author', 'AU_ID_scopus', 'full_name', 'affiliation'}, {'int32', 'int64', 'string','string'});
authors = readtable(strcat(data_dir,'1_authors.csv'), opts);

% renombrar las variables y pasar a string
authors = renamevars(authors, 'ID_author', 'Name');
authors.Name = string(authors.Name);

opts = detectImportOptions(strcat(data_dir,'3_collaborations.csv'));
opts = setvartype(opts,  {'ID_author_1', 'ID_author_2', 'scopus_id_collaborations'}, {'int32', 'int32', 'string'});
collaborations = readtable(strcat(data_dir,'3_collaborations.csv'), opts);

%% Obtener los pesos

collaborations.pesos = zeros(size(collaborations.ID_author_1));

% concatenacion de los id
publications = split(collaborations.scopus_id_collaborations(1), ",");
% suma acumulada de publicaciones / par
collaborations.scopus_id_cumsumsplits(1) = size(publications, 1);

% calcular para todas las colaboraciones
for i = 2 : height(collaborations)
	splits = split(collaborations.scopus_id_collaborations(i), ",");
	collaborations.scopus_id_cumsumsplits(i) = size(splits, 1) + collaborations.scopus_id_cumsumsplits(i - 1);
	publications = [publications; splits];
end

% obtener las publicaciones sin repeticiones
unic_public = unique(publications);

% para cada publicacion
for unic = unic_public'
	% pares que participan en una publicacion
	% indica las posiciones en la lista de todas las publicaciones
	instances = find(strcmp(unic, publications));
	peso = 1/size(instances, 1);

	% la primera colaboracion que cumple mayor que la primera instancia
	% es decir, la colaboracion correspondiente a la primera instancia
	% Esta instancia esta dentro de una sublista de una colaboracion, para
	% encontrar esta, buscamos la primera cuya suma de sublistas es mayor o
	% igual.
	% La sublista de una colaboracion esta delimitada por las posiciones de
	% fin de cada colaboracion, esta posicion es la suma acumulada
	for instance = instances'
		pos = find(collaborations.scopus_id_cumsumsplits >= instance, 1);
		collaborations.pesos(pos) = collaborations.pesos(pos) + peso;
	end
end

%% Construct the graph

g = graph(collaborations.ID_author_1, collaborations.ID_author_2, collaborations.pesos, authors);

%% Representa el grafo
title('Collaboration graph')
plot(g, 'Layout', 'force')
