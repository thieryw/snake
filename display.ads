package display is

        type grid is array(1..20,1..70) of boolean ;
        screen : grid ;
        procedure render(screen : grid) ;

end display ;

        
