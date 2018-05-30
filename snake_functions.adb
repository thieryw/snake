with snake_types,ada.text_io,ada.integer_text_io,display,nt_console, ada.calendar,ada.numerics.discrete_random ;
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
                for i in 25..28 loop 
                        snake_list.append(s,(10,i)) ;

                end loop ;



                return s ;

        end create_snake ;

        procedure move_snake(s : in out snake_types.Snake ; dir : snake_types.Snake_direction) is

                snake_coord : Coordinates ;
                c : snake_list.cursor ;
                


        begin
                c := snake_list.first(s) ;
                snake_coord := snake_list.Element(c) ;

                

                case dir is
                        when snake_types.UP =>
                                snake_list.prepend(s,(snake_coord.x-1,snake_coord.y)) ;
                        when snake_types.DOWN =>
                                snake_list.prepend(s,(snake_coord.x+1,snake_coord.y)) ;
                        when snake_types.LEFT =>
                                snake_list.prepend(s,(snake_coord.x,snake_coord.y-1)) ;
                        when snake_types.right =>
                                snake_list.prepend(s,(snake_coord.x,snake_coord.y+1)) ;
                                
                end case ;

                
                c := snake_list.last(s) ;

                snake_list.delete(s,c) ;


        end move_snake ;

        -- Test if key has assotiated value
        -- User_Controlls.Contains(user_controls_value, 'o') => boolean

        --Get value of key
        -- User_Controlls.Element(user_controls_value, 'o') => Direction


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

        procedure generate_fruit(fruit : in out snake_types.Coordinates ; s : snake_types.snake) is

                procedure generate_fruit(fruit : out snake_types.Coordinates) is
                        subtype intervall_x is integer range 1..20 ;
                        subtype intervall_y is integer range 1..70 ;
                        package aleatoire_x is new ada.numerics.discrete_random(intervall_x) ;
                        package aleatoire_y is new ada.numerics.discrete_random(intervall_y) ;
                        hasard_x : aleatoire_x.generator ;
                        hasard_y : aleatoire_y.generator ;
                begin
                        aleatoire_x.reset(hasard_x) ;
                        aleatoire_y.reset(hasard_y) ;
                        fruit.x := aleatoire_x.random(hasard_x) ;
                        fruit.y := aleatoire_y.random(hasard_y) ;

                end generate_fruit ;
                c : snake_list.cursor ;
                head_coord : Coordinates ;
        begin
                c := snake_list.first(s) ;
                head_coord := snake_list.element(c) ;
                if fruit.x = head_coord.x and fruit.y = head_coord.y then
                        generate_fruit(fruit) ;
                end if ;

                

        end generate_fruit ;






        procedure render_game(s : snake_types.snake ; fruit : Coordinates) is
                screen : display.grid := (others => (others => false)) ;
                point_coordinates : snake_types.Coordinates ;
                c : snake_list.cursor ;
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
