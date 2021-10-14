
%-----------------cold-----------------------------------------------------
% channel dimension -----------------------                               %
t_fin= 1;                                                                 %
w_chn = 1;                                                                % 
h_base = 1 ;                                                              %
h_base1 = h_base/2;                                                       %
h_chn = 1 ;                                                               %
                                                                          %
n = 58;    % number of channels                                           %
m = n+1 ;  % number of fins                                               %
                                                                          %
% manifold part---------------------                                      %
l_chn = 5;                                                                %
total_l= 10;                                                              %
inlet_chn =(total_l - l_chn) / 2 ;                                        %
outlet_chn =(total_l - l_chn) / 2 ;                                       %
%-----------------------------------                                      %
%mesh size--------------------------                                     %c
grid_h_chan = 5; %number of mesh in channel hight                        %o
grid_w_chan = 3;                                                         %l
grid_fin = 3 ;  %number of mesh in fin                                   %d
grid_base = 6 ;                                                           %
grid_man_fluid = 4 ;                                                      %
grid_man_solid = 5 ;                                                      %
                                                                          % 
%------------------hot-----------------------------------------------------
%--------------------------------------------------------------------------
% dimension_hot -----------------------
t_fin_hot = 2;
w_chn_hot  = 2;
h_base = 2 ;
h_base_hot  = h_base/2;
h_chn_hot  = 2 ;

n_hot = 55;    % number of channels
m_hot = n_hot +1 ;  % number of fin_hot s

% manifold part---------------------
l_chn_hot  = 3;
total_l_hot = 5;
inlet_chn_hot  =(total_l_hot  - l_chn_hot ) / 2 ;
outlet_chn_hot  =(total_l_hot  - l_chn_hot ) / 2 ;
%-----------------------------------
%mesh size--------------------------
grid_h_chan_hot = 5;
grid_w_chan_hot = 5;
grid_fin_hot  = 3 ;
grid_base_hot  = 6 ;
grid_man_fluid_hot  = 5 ;
grid_man_solid_hot = 5 ;


%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

%    last vertex from the cold side----------------------------------------
ve =38*n+21 ;
% lsat edge from the cold side--------
ed = 67*n+ 45 ;
%---last face from cold side-----------
 fa = 34*n +22 ;
 
 
 
 

 GambitFileName = 'G.txt'; 
    gid = fopen(GambitFileName, 'w');
    
    
    
   %%%%%%%%%%%%%%%%%%%%start of the cold side %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %-----------------------------------------------------------------------
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % vertex create----------------------------------------------
    fprintf(gid, 'vertex create coordinates 0 0 0 \n');
    fprintf(gid, 'vertex create coordinates 0 %9.9f 0 \n',h_base1);
    fprintf(gid, 'vertex create coordinates 0 %9.9f 0 \n',h_base1 + h_chn);
    fprintf(gid, 'vertex cmove "vertex.1" "vertex.2" "vertex.3" multiple 1 offset %9.9f 0 0 \n',t_fin);
    fprintf(gid, 'vertex cmove "vertex.1" "vertex.2" "vertex.3" "vertex.4" "vertex.5" "vertex.6" multiple 1 offset %9.9f 0 0 \n',t_fin+w_chn);
    
    fprintf(gid, 'edge create straight "vertex.10" "vertex.7" "vertex.4" "vertex.1" "vertex.2" "vertex.3" "vertex.6" "vertex.5" "vertex.8" "vertex.9" "vertex.12" "vertex.11" \n');
    fprintf(gid, 'edge cmove "edge.1" "edge.2" "edge.8" "edge.9" "edge.10" "edge.11" multiple %9.9f offset %9.9f 0 0 \n', n-1, t_fin+w_chn);
    fprintf(gid, 'edge cmove "edge.4" multiple 1 offset %9.9f 0 0 \n', n*w_chn+m*t_fin);
    
    % face create 1-----------
    fprintf(gid, 'face create wireframe "edge.1" ');
    l=6*m -1
    for j=2:1:l
        fprintf(gid, '"edge.%i" ',j);
    end
      fprintf(gid, '"edge.%i" \n', 6*m);
    % finish face 1------------
    
    
    fprintf(gid, 'edge create straight "vertex.6" "vertex.9"\n');
    fprintf(gid, 'edge cmove "edge.%i" multiple %i offset %9.9f 0 0 \n', 6*m+1, n-1,t_fin+w_chn);
    
    
    fprintf(gid, 'face create wireframe "edge.7" "edge.8" "edge.9" "edge.%i"\n',6*m+1);
    
    for i=1:1:n-1;
        
    fprintf(gid,'face create wireframe "edge.%i" "edge.%i" "edge.%i" "edge.%i"\n',11+6*(i-1),14+6*(i-1),15+6*(i-1), 6*m+1+i);
    end
    
    
  %meshing-------------
  
  %h_chan mesh--------
  fprintf(gid, 'edge mesh "edge.5" "edge.7" "edge.9" successive ratio1 1.1 ratio2 1.1 intervals %9.9f\n', grid_h_chan);
  for i=1:1:n-1
      fprintf(gid, 'edge mesh "edge.%i" "edge.%i" successive ratio1 1.1 ratio2 1.1 intervals %9.9f\n', 11+6*(i-1), 15+6*(i-1), grid_h_chan);
  end
  
  fprintf(gid, 'edge mesh "edge.%i" successive ratio1 1.1 ratio2 1.1 intervals %9.9f\n',15+6*(n-2)+2,grid_h_chan);  
    
  % w-chan mesh------------
  for i=1:1:n
      
       fprintf(gid, 'edge mesh "edge.%i" "edge.%i" successive ratio1 1.1 ratio2 1.1 intervals %9.9f\n',8+6*(i-1), 6*m+i, grid_w_chan);
       
  end
   fprintf(gid, 'edge mesh "edge.2" successive ratio1 1.1 ratio2 1.1 intervals %9.9f\n', grid_w_chan);
   
   for i=1:1:n-1
        fprintf(gid, 'edge mesh "edge.%i" successive ratio1 1.1 ratio2 1.1 intervals %9.9f\n', 13+6*(i-1),grid_w_chan);
   end
   
   % solid part mesh---------------------
   
    fprintf(gid, 'edge mesh "edge.6" successive ratio1 1 intervals %9.9f\n', grid_fin);
    
    for i=1:1:n
        
   
     fprintf(gid, 'edge mesh "edge.%i" successive ratio1 1 intervals %9.9f\n', 10+6*(i-1),grid_fin);
     
    end
    
    
   
     fprintf(gid, 'edge mesh "edge.1" "edge.3" successive ratio1 1 intervals %9.9f\n', grid_fin);
     
        
    for i=1:1:n-1
        
   
     fprintf(gid, 'edge mesh "edge.%i" successive ratio1 1 intervals %9.9f\n', 12+6*(i-1), grid_fin);
     
    end
     
     
      fprintf(gid, 'edge mesh "edge.4" "edge.%i" successive ratio1 1 intervals %9.9f\n',6*m, grid_base);
     
     
     for i=1:1:m
         fprintf(gid, 'face mesh "face.%i"\n',i);
     end
   
     
     %---line to extrude--------
      fprintf(gid, 'vertex create coordinates 0 0 %9.9f \n',inlet_chn);
     fprintf(gid, 'vertex create coordinates 0 0 %9.9f \n',inlet_chn + l_chn);
     fprintf(gid, 'vertex create coordinates 0 0 %9.9f \n',total_l);
     
      fprintf(gid, 'edge create straight "vertex.1" "vertex.%i" "vertex.%i" "vertex.%i"\n',12*n+1, 12*n+2, 12*n+3);
       fprintf(gid, 'edge mesh "edge.%i" "edge.%i" successive ratio1 1.1 ratio2 1.1 intervals %9.9f\n', n*7+7, n*7+9, grid_man_fluid)
     
        fprintf(gid, 'edge mesh "edge.%i" successive ratio1 1.1 ratio2 1.1 intervals %9.9f\n', n*7+8, grid_man_solid)
       
        
        % extrude onedge-----------------------------
        fprintf(gid, 'volume create translate')
        for i=1:1:m
       fprintf(gid, '"face.%i"', i);
        end
         fprintf(gid, 'onedge "edge.%i" withmesh\n', n*7+7);
         
         
         %   boundary condition----------------
         
         %------interface----------
         fprintf(gid, 'physics create "interface_cold" btype "INTERFACE" face')
         for i=m+1:1:3*m-1
             fprintf(gid,' "face.%i"', i);
         end
         fprintf(gid, '\n')
 
         %---------symmetry--------
          fprintf(gid, 'physics create "symmetry_cold_1" btype "SYMMETRY" face')
         for i=1:1:m
             fprintf(gid,' "face.%i"', i);
         end
          fprintf(gid,' "face.%i" "face.%i" "face.%i" "face.%i"', 3*m, 3*m+1, 6*m, 4*m+1);
         fprintf(gid, '\n')
       
         
         %
         %-----interior_1 boundary-----------------------
         fprintf(gid, 'physics create "interior_1" btype "INTERIOR" face')
         for i=1:1:m
             fprintf(gid,' "face.%i"', m*7+6+5*(i-1));
         end
          fprintf(gid,' "face.%i" ', m*7+1);
         fprintf(gid, '\n')
       
         
         
          %-----inlet cold----------------------
         fprintf(gid, 'physics create "inlet_cold" btype "MASS_FLOW_INLET" face')
         for i=1:1:n
             fprintf(gid,' "face.%i"', m*7+5*i);
         end
          
         fprintf(gid, '\n')
       
         
         
         
         % second extrusion---------------------------
         fprintf(gid, 'volume create translate')
           for i=1:1:n
             fprintf(gid,' "face.%i"', m*7+6+5*(i-1));
         end
          fprintf(gid,' "face.%i" ', m*7+1);
          
          fprintf(gid, 'onedge "edge.%i" withmesh\n', n*7+8);
          
          
          % boundary interface-----------
          
           fprintf(gid, 'physics create "interface_cold_2" btype "INTERFACE" face')
         for i=1:1:m+n
             fprintf(gid,' "face.%i"', 12*m+5*n-4+i);
         end
         fprintf(gid, '\n')
         
         
         
         %-boundary interior-------------
         
          fprintf(gid, 'physics create "interior_2" btype "INTERIOR" face')
         for i=1:1:n
             fprintf(gid,' "face.%i"', m*7+5*n+1+5*i);
         end
          fprintf(gid,' "face.%i" ', 13*m+10*n+2);
         fprintf(gid, '\n')
        
         
         %--extrusion 3-----------
         
         fprintf(gid, 'volume create translate')
          for i=1:1:n
             fprintf(gid,' "face.%i"', m*7+5*n+1+5*i);
         end
          fprintf(gid,' "face.%i" ', 13*m+10*n+2);
           fprintf(gid, 'onedge "edge.%i" withmesh\n', n*7+9);
           
           
           % ------cold outlet boundary---------------
           
           
         fprintf(gid, 'physics create "cold_outlet" btype "PRESSURE_OUTLET" face')
         
         for i=1:1:n
             fprintf(gid,'"face.%i"', 13*m+10*n+6+5*(i-1));
         end
         
          fprintf(gid, '\n')
       
         
         
         
         % symmetry----------------
         fprintf(gid, 'physics create "symmetry_cold_3" btype "SYMMETRY" face')
         
         for i=1:1:n
             fprintf(gid,'"face.%i"', 13*m+10*n+2+5*i);
         end
         fprintf(gid, '"face.%i"', 19*m+15*n+3)
          fprintf(gid, '\n')
         
         
         
         
         %-interface ----------------
         
          fprintf(gid, 'physics create "interface_cold_3" btype "INTERFACE" face')
         
         for i=1:1:m+n
             fprintf(gid,' "face.%i"', 13*m+15*n+2+i);
         end
         fprintf(gid, '\n') 
         
         
         
         
         % volume bc------
         
          fprintf(gid, 'physics create "cold_solid" ctype "SOLID" volume "volume.1" "volume.%i" "volume.%i"\n', 2*m,3*m);
         
         
         
         fprintf(gid, 'physics create "cold_fluid" ctype "FLUID" volume ')
       for i=2:1:2*m-1
           
         fprintf(gid, '"volume.%i"',i)
       end
         
         fprintf(gid,'\n');
         
         
       fprintf(gid, 'physics create "cold_fluid_2" ctype "FLUID" volume ')  
         for i=2*m+1:1:3*m-1
           
        fprintf(gid, '"volume.%i"',i)
       end
         
        fprintf(gid,'\n'); 
         
         
         
    %%%%%%%%%%%%%%%%%%%%start of the hot side %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %-----------------------------------------------------------------------
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
   
   
  % vertex create----------------------------------------------
    fprintf(gid, 'vertex create coordinates 0 0 0 \n');
    fprintf(gid, 'vertex create coordinates 0 %9.9f 0 \n',h_base_hot );
    fprintf(gid, 'vertex create coordinates 0 %9.9f 0 \n',h_base_hot  + h_chn_hot );
    fprintf(gid, 'vertex cmove "vertex.%i" "vertex.%i" "vertex.%i" multiple 1 offset %9.9f 0 0 \n',1+ve, 2+ve, 3+ve, t_fin_hot );
    fprintf(gid, 'vertex cmove "vertex.%i" "vertex.%i" "vertex.%i" "vertex.%i" "vertex.%i" "vertex.%i" multiple 1 offset %9.9f 0 0 \n',1+ve,2+ve, 3+ve, 4+ve, 5+ve, 6+ve,t_fin_hot +w_chn_hot );
    
    fprintf(gid, 'edge create straight "vertex.%i" "vertex.%i" "vertex.%i" "vertex.%i" "vertex.%i" "vertex.%i" "vertex.%i" "vertex.%i" "vertex.%i" "vertex.%i" "vertex.%i" "vertex.%i" \n',10+ve,7+ve, 4+ve,1+ve,2+ve,3+ve,6+ve,5+ve,8+ve,9+ve,12+ve,11+ve);
    fprintf(gid, 'edge cmove "edge.%i" "edge.%i" "edge.%i" "edge.%i" "edge.%i" "edge.%i" multiple %9.9f offset %9.9f 0 0 \n',1+ed,2+ed,8+ed,9+ed,10+ed, 11+ed, n_hot - 1, t_fin_hot +w_chn_hot );
    fprintf(gid, 'edge cmove "edge.%i" multiple 1 offset %9.9f 0 0 \n',4+ed, n_hot * w_chn_hot +m_hot * t_fin_hot );
    
    
    % face create 1+fa-----------
    fprintf(gid, 'face create wireframe "edge.%i" ', 1+ed);
    l_hot=6*m_hot -1
    for j=2:1:l_hot
        fprintf(gid, '"edge.%i" ',j+ed);
    end
      fprintf(gid, '"edge.%i" \n', 6*m_hot +ed);
      
       fprintf(gid, 'edge create straight "vertex.%i" "vertex.%i"\n',6+ve,9+ve);
    fprintf(gid, 'edge cmove "edge.%i" multiple %i offset %9.9f 0 0 \n', 6*m_hot +1 + ed, n_hot - 1,t_fin_hot +w_chn_hot );
    
    
     fprintf(gid, 'face create wireframe "edge.%i" "edge.%i" "edge.%i" "edge.%i"\n',7+ed,8+ed,9+ed, 6*m_hot +1+ed);
    
    for i=1:1:n_hot - 1;
        
    fprintf(gid,'face create wireframe "edge.%i" "edge.%i" "edge.%i" "edge.%i"\n',11+6*(i-1)+ed,14+6*(i-1)+ed,15+6*(i-1)+ed, 6*m_hot +1+i+ed);
    end
    
    
    %h_chan_hot mesh--------
  fprintf(gid, 'edge mesh "edge.%i" "edge.%i" "edge.%i" successive ratio1 1.1 ratio2 1.1 intervals %9.9f\n',5+ed,7+ed,9+ed, grid_h_chan_hot);
  for i=1:1:n_hot - 1
      fprintf(gid, 'edge mesh "edge.%i" "edge.%i" successive ratio1 1.1 ratio2 1.1 intervals %9.9f\n', 11+6*(i-1)+ed, 15+6*(i-1)+ed, grid_h_chan_hot);
  end
  
  fprintf(gid, 'edge mesh "edge.%i" successive ratio1 1.1 ratio2 1.1 intervals %9.9f\n',15+6*(n_hot - 2)+2+ed ,grid_h_chan_hot);  
    
  
  
   % w-chan_hot mesh------------
  for i=1:1:n_hot
      
       fprintf(gid, 'edge mesh "edge.%i" "edge.%i" successive ratio1 1.1 ratio2 1.1 intervals %9.9f\n',8+6*(i-1)+ed, 6*m_hot +i+ed, grid_w_chan_hot);
       
  end
   fprintf(gid, 'edge mesh "edge.%i" successive ratio1 1.1 ratio2 1.1 intervals %9.9f\n',2+ed, grid_w_chan_hot);
   
   for i=1:1:n_hot - 1
        fprintf(gid, 'edge mesh "edge.%i" successive ratio1 1.1 ratio2 1.1 intervals %9.9f\n', 13+6*(i-1)+ed,grid_w_chan_hot);
   end
   
   % solid part mesh---------------------
   
    fprintf(gid, 'edge mesh "edge.%i" successive ratio1 1 intervals %9.9f\n', 6+ed, grid_fin_hot );
    
    for i=1:1:n_hot
        
   
     fprintf(gid, 'edge mesh "edge.%i" successive ratio1 1 intervals %9.9f\n', 10+6*(i-1)+ed,grid_fin_hot );
     
    end
    
    
    
    fprintf(gid, 'edge mesh "edge.%i" "edge.%i" successive ratio1 1 intervals %9.9f\n',1+ed, 2+ed, grid_fin_hot );
     
        
    for i=1:1:n_hot - 1
        
   
     fprintf(gid, 'edge mesh "edge.%i" successive ratio1 1 intervals %9.9f\n', 12+6*(i-1)+ed, grid_fin_hot );
     
    end
     
     
      fprintf(gid, 'edge mesh "edge.%i" "edge.%i" successive ratio1 1 intervals %9.9f\n',4+ed,6*m_hot+ed , grid_base_hot ); 
    
      
      
      
     for i=1:1:m_hot
         fprintf(gid, 'face mesh "face.%i"\n',i+fa);
     end
   
     
     %---line to extrude--------
      fprintf(gid, 'vertex create coordinates 0 0 %9.9f \n',inlet_chn_hot );
     fprintf(gid, 'vertex create coordinates 0 0 %9.9f \n',inlet_chn_hot  + l_chn_hot );
     fprintf(gid, 'vertex create coordinates 0 0 %9.9f \n',total_l_hot );
     
      fprintf(gid, 'edge create straight "vertex.%i" "vertex.%i" "vertex.%i" "vertex.%i"\n',1+ve,12*n_hot +1 +ve, 12*n_hot +2+ve , 12*n_hot +3+ve);
       fprintf(gid, 'edge mesh "edge.%i" "edge.%i" successive ratio1 1.1 ratio2 1.1 intervals %9.9f\n', n_hot * 7+7+ed, n_hot * 7+9+ed, grid_man_fluid_hot )
     
        fprintf(gid, 'edge mesh "edge.%i" successive ratio1 1.1 ratio2 1.1 intervals %9.9f\n', n_hot * 7+8+ed , grid_man_solid_hot)
       
    
    
    
    
    
    % extrude onedge-----------------------------
        fprintf(gid, 'volume create translate')
        for i=1:1:m_hot
       fprintf(gid, '"face.%i"', i+fa);
        end
         fprintf(gid, 'onedge "edge.%i" withmesh\n', n_hot * 7+7+ed);
         
         
          %   boundary condition_hot - ---------------
         
         %------interface----------
         fprintf(gid, 'physics create "interface_hot" btype "INTERFACE" face')
         for i=m_hot +1:1:3*m_hot -1
             fprintf(gid,' "face.%i"', i+fa);
         end
         fprintf(gid, '\n')
         
 
         %---------symmetry--------
          fprintf(gid, 'physics create "symmetry_hot_1" btype "SYMMETRY" face')
         for i=1:1:m_hot
             fprintf(gid,' "face.%i"', i+fa);
         end
          fprintf(gid,' "face.%i" "face.%i" "face.%i" "face.%i"', 3*m_hot +fa , 3*m_hot +1+fa, 6*m_hot +fa , 4*m_hot +1+fa);
         fprintf(gid, '\n')
         
          %-----interior_1 boundary-----------------------
         fprintf(gid, 'physics create "interior_1_hot" btype "INTERIOR" face')
         for i=1:1:m_hot
             fprintf(gid,' "face.%i"', m_hot * 7+6+5*(i-1)+fa);
         end
          fprintf(gid,' "face.%i" ', m_hot * 7+1+fa);
         fprintf(gid, '\n')
       
         
         
          %-----inlet cold----------------------
         fprintf(gid, 'physics create "inlet_hot" btype "MASS_FLOW_INLET" face')
         for i=1:1:n_hot
             fprintf(gid,' "face.%i"', m_hot * 7+5*i+fa);
         end
          
         fprintf(gid, '\n')
       
         
     % second extrusion_hot - --------------------------
         fprintf(gid, 'volume create translate')
           for i=1:1:n_hot
             fprintf(gid,' "face.%i"', m_hot * 7+6+5*(i-1)+fa);
         end
          fprintf(gid,' "face.%i" ', m_hot * 7+1+fa);
          
          fprintf(gid, 'onedge "edge.%i" withmesh\n', n_hot * 7+8+ed);
          
           % boundary interface-----------
          
           fprintf(gid, 'physics create "interface_hot_2" btype "INTERFACE" face')
         for i=1:1:m_hot +n_hot
             fprintf(gid,' "face.%i"', 12*m_hot +5*n_hot - 4+i+fa);
         end
         fprintf(gid, '\n')
         
         
         
         %-boundary interior-------------
         
          fprintf(gid, 'physics create "interior_2_hot" btype "INTERIOR" face')
         for i=1:1:n_hot
             fprintf(gid,' "face.%i"', m_hot * 7+5*n_hot +1+5*i+fa);
         end
          fprintf(gid,' "face.%i" ', 13*m_hot +10*n_hot +2+fa);
         fprintf(gid, '\n')
        
         
         %--extrusion_hot 3-----------
         
         fprintf(gid, 'volume create translate')
          for i=1:1:n_hot
             fprintf(gid,' "face.%i"', m_hot * 7+5*n_hot +1+5*i+fa);
         end
          fprintf(gid,' "face.%i" ', 13*m_hot +10*n_hot +2+fa);
           fprintf(gid, 'onedge "edge.%i" withmesh\n', n_hot * 7+9+ed);
           
           
           % ------hot outlet boundary---------------
           
           
         fprintf(gid, 'physics create "hot_outlet" btype "PRESSURE_OUTLET" face')
         
         for i=1:1:n_hot
             fprintf(gid,'"face.%i"', 13*m_hot +10*n_hot +6+5*(i-1)+fa);
         end
         
          fprintf(gid, '\n')
       
         
         
         
         % symmetry----------------
         fprintf(gid, 'physics create "symmetry_whole_3" btype "SYMMETRY" face')
         
         for i=1:1:n_hot
             fprintf(gid,'"face.%i"', 13*m_hot +10*n_hot +2+5*i+fa);
         end
         fprintf(gid, '"face.%i"', 19*m_hot +15*n_hot +3+fa)
         
         fprintf(gid,'"face.%i" "face.%i" "face.%i" "face.%i" "face.%i" "face.%i" "face.%i" "face.%i"',19*n+10, 19*n+11,20*n+12,22*n+13,30*n+17,30*n+18,31*n+19,33*n+20);
         fprintf(gid,'"face.%i" "face.%i" "face.%i" "face.%i" "face.%i" "face.%i" "face.%i" "face.%i"',19*n_hot+10+fa, 19*n_hot+11+fa,20*n_hot+12+fa,22*n_hot+13+fa,30*n_hot+17+fa,30*n_hot+18+fa,31*n_hot+19+fa,33*n_hot+20+fa);
         fprintf(gid, '\n')
         
         
         
         
         %-interface ----------------
         
          fprintf(gid, 'physics create "interface_hot_3" btype "INTERFACE" face')
         
         for i=1:1:m_hot +n_hot
             fprintf(gid,' "face.%i"', 13*m_hot +15*n_hot +2+i+fa);
         end
         fprintf(gid, '\n') 
         
         
         
         
         % volume bc------
         
          fprintf(gid, 'physics create "hot_solid" ctype "SOLID" volume "volume.%i" "volume.%i" "volume.%i"\n',1+3*m, 2*m_hot +3*m ,3*m_hot +3*m );
         
         
         
         fprintf(gid, 'physics create "hot_fluid" ctype "FLUID" volume ')
       for i=2:1:2*m_hot -1
           
         fprintf(gid, '"volume.%i"',i+ 3*m)
       end
         
         fprintf(gid,'\n');
         
         
       fprintf(gid, 'physics create "hot_fluid_2" ctype "FLUID" volume ')  
         for i=2*m_hot +1:1:3*m_hot -1
           
        fprintf(gid, '"volume.%i"',i+3*m)
       end
         
        fprintf(gid,'\n'); 
        
        
        
        % rotate the hot side
        fprintf(gid, 'volume move')
        
        for i=1:1:3*m_hot
            
            fprintf(gid,'"volume.%i"',i+3*m)
        end
        fprintf(gid,'dangle 180 vector 1 0 0 origin 0 0 0 connected\n')
        
        
        
        
         fprintf(gid, 'volume move')
        
        for i=1:1:3*m_hot
            
            fprintf(gid,'"volume.%i"',i+3*m)
        end
        
    fprintf(gid,'dangle 90 vector 0 -1 0 origin 0 0 0 connected\n')
    
    
    
    
    
    
    %---export-----------------------------------------------------------------------
    fprintf(gid, [' export fluent5 "test.msh" \n']);
    fprintf(gid, [' save name " test.dbs" \n']);
    fclose(gid);
%% Run Gambit
    eval(['! gambit -inp "G.txt"']); 
    pause(5)