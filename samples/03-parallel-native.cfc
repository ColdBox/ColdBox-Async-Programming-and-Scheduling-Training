component {

	function run(){
		a = [ "a", "b", "c", "d", "e" ];
		b = a.map( function( element, index, array ){
            if( index == 3 ){
               throw( "nasty error" )
            }
            var newData = "#index#:#element#"
			//systemOutput( newData , true )
            return newData
		}, true );
        systemOutput( b , true )
	}

}
