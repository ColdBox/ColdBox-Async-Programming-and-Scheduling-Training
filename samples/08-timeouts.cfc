component extends="../BaseTask" {

    function run(){
		var future = asyncManager.newFuture()
			.run( () => {
				for ( var i = 1; i <= 20; i++ ) {
					sleep( 500 );
					print.greenLine( "to infinity and beyond..." ).toConsole();
					if ( !isNull( checkInterrupted() ) ) {
						break;
					}
				}
				return -1;
			})
			// .orTimeout( 5, "seconds" )
			.completeOnTimeout( 50, 5, "seconds" )

		print.blueLine( "Finished! #future.get()#" ).toConsole();

		// 1. Show infinity!
		// 2. Timeout with an exception
		// 3. Timeout with a result
		// 4. Custom Pool as best practice for shutting down threads
    }

}