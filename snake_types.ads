package snake_types is



        type T_snake_zone is array(1..70,1..20) of boolean ;

        type Snake_direction is (LEFT,RIGHT,UP,DOWN) ;

        type Coordinates is
                record

                        x : integer ;
                        y : integer ;

                end record ;
        


        type Snake is
                record

                        snake_coord : T_snake_zone ;
                        head_position : Coordinates ;

                end record ;




        



end snake_types ;

        
        
