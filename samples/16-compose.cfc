component extends="../BaseTask" {

	function run(){
		// If you do a computation that returns another future, instead of returning a future, compose them
		create( "Hello" )
			// If not, the result is a future and not the actual result
			.thenCompose( ( data ) => create( data & " World" ) )
			.thenRun( ( result ) => print.greenLine( result ) )
			.get();
	}

}
