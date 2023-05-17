component extends="../BaseTask" {

	function compute(){
		sleep( 1000 );
		print.greenLine( "Computing from: #getThreadname()#" ).toConsole();
		return 2;
	}

	Future function create(){
		return asyncManager.newFuture( () => compute() )
	}

	function run(){
		print.blueLine( "Starting from: #getThreadname()#" ).toConsole();

		create().thenRun( ( data ) => {
            sleep( 1000 );
			// Where is this executing? same thread?
			// Think about it, we want a non-blocking mode.
			print.redLine( "Then Executed From: #getThreadname()#" ).toConsole();
			print.redLine( data ).toConsole();
		} );

		sleep( 2000 );
	}

}
