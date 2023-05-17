component {

	variables.files = {
		"file1.txt" : "One",
		"file2.txt" : "Two",
		"file3.txt" : "Three"
	};

	function run(){
		// how can I run these at the same time but wait until they are all done?
		// I have to manage the state myself in a nested runAsync.
		var all = runAsync( function(){
			var f1 = runAsync( () => getFile( "file1.txt" ) );
			var f2 = runAsync( () => getFile( "file2.txt" ) );
			var f3 = runAsync( () => getFile( "file3.txt" ) );

			return [ f1.get(), f2.get(), f3.get() ];
		} );

		print.line( all.get() ).toConsole();
	}

	/**
	 * Mocks retrieving a file from the filesystem
	 */
	function getFile( required string fileName ){
		sleep( randRange( 1, 1500 ) );
		print.line( "#fileName# finished" ).toConsole();
		return variables.files[ arguments.fileName ] ?: "Does not exist";
	}

}
