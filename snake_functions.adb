with snake_types,ada.text_io,ada.integer_text_io,ada.float_text_io,display,nt_console, ada.calendar,ada.numerics.discrete_random ;
use ada.text_io,snake_types ;


package body snake_functions is

        function get_user_controls_default return snake_types.User_Controls.Map is
                user_controls_default: snake_types.User_Controls.Map;
        begin


                snake_types.User_Controls.Insert(user_controls_default, 'o', snake_types.UP );
                snake_types.User_Controls.Insert(user_controls_default, 'l', snake_types.DOWN );
                snake_types.User_Controls.Insert(user_controls_default, 'k', snake_types.LEFT );
                snake_types.User_Controls.Insert(user_controls_default, 'm', snake_types.RIGHT );

                return user_controls_default;

        end get_user_controls_default;




        function are_same_coord(point1 : snake_types.Coordinates ; point2 : snake_types.Coordinates) return boolean is
        begin
                return point1.x = point2.x and point1.y = point2.y ;

        end are_same_coord ;






        function create_snake return snake_types.Snake is
                s : snake_types.Snake ;
        begin
                for i in 25..29 loop 
                        snake_list.append(s,(10,i)) ;

                end loop ;



                return s ;

        end create_snake ;

        procedure move_snake(s : in out snake_types.Snake ; dir : snake_types.Snake_direction ; fruit_coord : in out snake_types.Coordinates ; time_out : in out integer ; score : in out integer) is
                procedure snake_through_wall(s : in out snake_types.snake ; dir : snake_types.snake_direction ; head : in out snake_types.Coordinates ; is_on_edge : out boolean)  is

                        c : snake_list.cursor ;


                begin
                        if head.x = display.screen'first(1) and dir = UP then

                                snake_list.prepend(s,(x => display.screen'last(1), y => head.y)) ;
                                is_on_edge := true ;

                        elsif head.x = display.screen'last(1) and dir = DOWN then

                                snake_list.prepend(s,(x => display.screen'first(1), y => head.y)) ;
                                is_on_edge := true ; 

                        elsif head.y = display.screen'first(2) and dir = LEFT then

                                snake_list.prepend(s,(x => head.x, y => display.screen'last(2))) ;
                                is_on_edge := true ;

                        elsif head.y = display.screen'last(2) and dir = RIGHT then

                                snake_list.prepend(s,(x => head.x, y => display.screen'first(2))) ;
                                is_on_edge := true ;

                        end if ; 

                        c := snake_list.first(s) ;
                        head := snake_list.Element(c) ;

                end snake_through_wall ;


                head : Coordinates ;
                c : snake_list.cursor ;
                is_on_edge : boolean := false ;



        begin
                c := snake_list.first(s) ;
                head := snake_list.Element(c) ;


                snake_through_wall(s,dir,head,is_on_edge) ;
                if is_on_edge then
                        snake_list.delete(s,c) ;
                end if ;




                case dir is

                        when snake_types.UP =>

                                snake_list.prepend(s,(x=>head.x-1,y=>head.y)) ;

                        when snake_types.DOWN =>

                                snake_list.prepend(s,(x =>head.x+1,y=>head.y)) ;

                        when snake_types.LEFT =>

                                snake_list.prepend(s,(x=> head.x,y=>head.y-1)) ;

                        when snake_types.RIGHT =>

                                snake_list.prepend(s,(x=>head.x,y=>head.y+1)) ;

                end case ;

                c := snake_list.last(s) ;

                if not are_same_coord(snake_list.Element(c), fruit_coord ) then 
                        snake_list.delete(s,c) ;
                else
                        generate_fruit(fruit_coord,s,time_out) ;
                        score := score + 1 ;
                end if;



        end move_snake ;





        procedure is_end_of_game(s : snake_types.snake ; end_game : out boolean) is
                c_head : snake_list.cursor ;
                c_tail : snake_list.cursor ;

                snake_tail : snake_types.Coordinates ;
                snake_head : snake_types.Coordinates ;
                count : integer := integer(snake_list.length(s)) ;
        begin
                c_head := snake_list.first(s) ;
                c_tail := snake_list.last(s) ;
                snake_head := snake_list.Element(c_head) ;

                for i in 1..count - 1 loop 
                        snake_tail := snake_list.Element(c_tail) ;

                        if snake_tail.x = snake_head.x and snake_tail.y = snake_head.y then
                                end_game := true ;
                        end if ;
                        c_tail := snake_list.previous(c_tail) ;
                        snake_tail := snake_list.element(c_tail) ;

                end loop ;



        end is_end_of_game ;



        procedure retreve_user_input(
                has_new_user_input: out boolean;
                direction: out snake_types.Snake_direction ; 
                user_controls_value: in snake_types.User_Controls.Map
                )is
                char : character ;
        begin


                has_new_user_input :=false;

                if nt_console.Key_Available then

                        char := nt_console.get_key ;

                        if snake_types.User_Controls.Contains(user_controls_value, char) then

                                has_new_user_input := true;

                                direction:= snake_types.User_Controls.Element(user_controls_value, char) ;
                        end if ;

                end if ;

        end retreve_user_input;




        procedure update_direction(
                dir : in out snake_types.Snake_direction ; 
                new_direction : snake_types.Snake_direction
                ) is
        begin

                if
                        ( dir = snake_types.UP and new_direction = snake_types.DOWN )
                        or
                                ( dir = snake_types.DOWN and new_direction = snake_types.UP )
                                or
                                        ( dir = snake_types.LEFT and new_direction = snake_types.RIGHT )
                                        or
                                                ( dir = snake_types.RIGHT and new_direction = snake_types.LEFT )
                then

                        return;

                end if;

                dir := new_direction ;

        end update_direction ;







        procedure generate_fruit(fruit : out snake_types.Coordinates ; s : snake_types.snake ; time_out : out integer) is

                procedure random_time_to_generate_fruit(time_out : out integer) is 
                        subtype intervall is integer range 40..90 ;
                        package aleatoire is new ada.numerics.discrete_random(intervall) ;
                        hasard : aleatoire.generator ;

                begin
                        aleatoire.reset(hasard) ;
                        time_out := aleatoire.random(hasard) ;



                end random_time_to_generate_fruit ;

                procedure sub_generate_fruit(fruit : out snake_types.Coordinates) is

                        subtype intervall_x is integer range display.screen'range(1) ;
                        package aleatoire_x is new ada.numerics.discrete_random(intervall_x) ;
                        x_generator : aleatoire_x.generator ;

                        subtype intervall_y is integer range display.screen'range(2) ;
                        package aleatoire_y is new ada.numerics.discrete_random(intervall_y) ;
                        y_generator : aleatoire_y.generator ;

                begin
                        aleatoire_x.reset(x_generator) ;
                        aleatoire_y.reset(y_generator) ;
                        fruit.x := aleatoire_x.random(x_generator) ;
                        fruit.y := aleatoire_y.random(y_generator) ;

                end sub_generate_fruit ;

                function is_fruit_on_snake(fruit:snake_types.Coordinates ; s: snake_types.Snake ) return boolean is
                begin


                        for dot of s loop

                                if are_same_coord(fruit,dot) then
                                        return true;
                                end if ;

                        end loop;

                        return false;

                end is_fruit_on_snake;


                procedure place_fruit_on_list(fruit : out snake_types.Coordinates ; s : in snake_types.snake) is


                        screen : display.grid := (others => (others => false)) ;

                        length_of_snake : integer := integer( snake_list.length(s)) ;

                        type array_of_coord is array(1..(screen'length(1) * screen'length(2)) - length_of_snake) of snake_types.Coordinates ;

                        coord_not_belonging_to_serpent : array_of_coord ;

                        procedure create_list_not_on_snake(s : in snake_types.snake ; coord_not_belonging_to_serpent : out array_of_coord ; screen : in out display.grid) is

                                count : integer := coord_not_belonging_to_serpent'first ;

                        begin
                                for dot of s loop
                                        screen(dot.x,dot.y) := true ;
                                end loop ;

                                for i in screen'range(1) loop
                                        for j in screen'range(2) loop
                                                if not screen(i,j) then

                                                        coord_not_belonging_to_serpent(count).x := i ; 
                                                        coord_not_belonging_to_serpent(count).y := j ;
                                                        count := count + 1 ;

                                                end if ;
                                        end loop ;
                                end loop ;

                        end create_list_not_on_snake ;



                        subtype intervall is integer range coord_not_belonging_to_serpent'range ;
                        package randomizer is new ada.numerics.discrete_random(intervall) ;
                        hasard : randomizer.generator ;

                        point_on_list : integer ;


                begin
                        randomizer.reset(hasard) ;

                        point_on_list := randomizer.random(hasard) ;

                        create_list_not_on_snake(s,coord_not_belonging_to_serpent,screen) ;
                        fruit.x := coord_not_belonging_to_serpent(point_on_list).x ;
                        fruit.y := coord_not_belonging_to_serpent(point_on_list).y ;

                end place_fruit_on_list ;

                snake_length : integer := integer(snake_list.length(s)) ;
                fraction : float := 0.7 ;


        begin
                if float(snake_length) >= fraction * (float(display.screen'length(1)) * float(display.screen'length(2))) then

                        place_fruit_on_list(fruit,s) ;

                else
                        loop
                                sub_generate_fruit(fruit) ;

                                if not is_fruit_on_snake(fruit,s) then
                                        exit ;
                                end if ;


                        end loop ;

                end if ;

                random_time_to_generate_fruit(time_out) ;


        end generate_fruit ;



        procedure render_game(s : snake_types.snake ; fruit : Coordinates) is
                point_coordinates : snake_types.Coordinates ;
                c : snake_list.cursor ;
                screen : display.grid := (others => (others => false)) ;
        begin

                c := snake_list.first(s) ;
                for i in 1..snake_list.length(s) loop 
                        point_coordinates := snake_list.element(c) ;
                        screen(point_coordinates.x,point_coordinates.y) := true ;
                        snake_list.next(c) ;
                end loop ;
                screen(fruit.x,fruit.y) := true ;

                display.render(screen) ;



        end render_game ; 











end snake_functions ;
