component extends="../BaseTask" {

	function run() {
		var future = asyncManager.newFuture( () => {
            if ( randRange( 1, 2 ) == 1 ) {
                return 1 / 0;
            } else {
                return randRange( 1, 10 ) / randRange( 1, 10 );
            }
        } ).handle( ( data, e ) => {
            if ( !isNull( e ) ) {
                print.redLine( e.message ).toConsole();
            } else {
                print.greenLine( data ).toConsole();
            }
        } );

        future.get();
	}

}