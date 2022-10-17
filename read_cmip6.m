% read .dat and write in txt
clc;clear;close all
scenario = {'ssp126','ssp245','ssp370','ssp585'};
in_dir   = './CMIP6/';
out_dir  = './CMIP6-txt/';
for i=1:4
    files    = dir([in_dir 'global_tas_mon_mod_' scenario{i} '*.dat']);
    for j=1:size(files,1)
        filename = [files(j).folder,'\',files(j).name];

        % first check where the record strats:
        line_num = check_line_num(filename);

        % then read
        fid = fopen(filename,'r');
        data = textscan(fid,'%f%f%f%f%f%f%f%f%f%f%f%f%f', 'HeaderLines', line_num-1);
        data = cell2mat(data);
        fclose(fid);
       
        out_name = [files(j).name(1:33),'.txt'];
        dlmwrite([out_dir '/' out_name],data,'precision',15,'delimiter','\t');
    end
end

function line_num = check_line_num(filename)
    fid = fopen(filename,'r');
    tag=0;
    line_num = 1;
    while tag==0
       line = fgetl(fid);
       if line(1)=='#'
           tag=0;
           line_num = line_num + 1;
       else
            tag=1;
       end
    end
    fclose(fid);
end