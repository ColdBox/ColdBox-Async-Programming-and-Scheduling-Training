component extends="../BaseTask" {

    function create( n ){
        return asyncManager.newFuture( () => {
            sleep( randRange( 100, 2000 ) );
            print.line( "creating new number: #n#" ).toConsole();
            return n;
        } );
    }

    function run(){
		// Let's combine two async operations and when both arrive continue operation
		var future = create( 2 )
			.thenCombine( create( 3 ), ( a, b ) => a + b );

		print.greenLine( future.get() ).toConsole();
    }

}