component {

    property name="asyncManager" inject="wirebox:asyncManager";

	function compute(){
		print.greenLine( "Computing from: #getThreadname()#" ).toConsole();
		print.line( "compute(): 2" ).line().toConsole();
		return 2;
	}

	function create(){
		return asyncManager.newFuture( () => compute() )
	}

	function run() {
		print.line().boldWhiteOnYellowLine( "Press Ctrl-C to exit" ).line();
		print.blueLine( "Starting from: #getThreadname()#" ).toConsole();

		var future = create()
			// Use then like a map() operation and work on the results
			.then( (data) => {
				print.greenLine( "Computing from: #getThreadname()#" ).toConsole();
				print.line( "incoming: #data#" ).toConsole();
				print.line( "outgoing: #data * 2#" ).line().toConsole();
				return data * 2;
			} )
			.then( (data) => {
				print.greenLine( "Computing from: #getThreadname()#" ).toConsole();
				print.line( "incoming: #data#" ).toConsole();
				print.line( "outgoing: #data + 1#" ).line().toConsole();
				return data + 1;
			} )
			.then( (data) => {
				print.greenLine( "Computing from: #getThreadname()#" ).toConsole();
				print.boldGreenLine( "Final Result: " & data ).toConsole();
			} );

		while ( true ) {
			if ( !isNull( checkInterrupted() ) ) {
				return;
			}
			sleep( 100 );
		}
	}

	function getThreadname(){
		return createObject( "java", "java.lang.Thread" ).currentThread().getName();
	}

}
