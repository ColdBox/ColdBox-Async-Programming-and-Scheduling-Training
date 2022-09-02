/**
 * =================================================================================
 * THIS IS THE SOLUTION FILE. TO WORK ON THE EXERCISES GO TO THE `exercises` FOLDER.
 * =================================================================================
 *
 * This exercise goes over:
 *     + creating new Futures
 *     + running Futures
 *     + waiting for Futures to complete
 *     + Assigning timeouts and default values to Futures
 *
 * You can run this exercise from the root in CommandBox by running:
 *     `task run exercises/01-intro-to-futures.cfc`
 *
 * You can use the `print` helper provided by CommandBox to log messages.
 * (Use `print.line( "message" ).toConsole()` if you're not familiar with it.)
 * Make sure to end with `.toConsole()` so your message is flushed
 * to the console the moment it is printed.
 */
component extends="../BaseTask" {

    /**
     * Create a future that prints out a greeting immediately.
     */
    function partOne() {
        asyncManager.newFuture( () => {
            print.line( "Hi!" ).toConsole();
        } );
    }

    /**
     * Create a future that prints out a greeting after 2 seconds.
     */
    function partTwo() {
        asyncManager.newFuture( () => {
            sleep( 2000 );
            print.line( "Hi again!" ).toConsole();
        } );
    }

    /**
     * Create a future that _returns_ a message to print out after 5 seconds.
     * Print out that message on the main thread.
     */
    function partThree() {
        var future = asyncManager.newFuture( () => {
            sleep( 5000 );
            return "Please wait for my greeting.";
        } );
        print.line( future.get() ).toConsole();
    }

    /**
     * Create a future that _returns_ a message to print out after 5 seconds.
     * Wait for a 3 second timeout before returning a default value.
     * Print out that message on the main thread.
     */
    function partFour() {
        var future = asyncManager.newFuture( () => {
            sleep( 5000 );
            return "Please wait for my greeting.";
        } );

        print.line(
            future.get( timeout = 3000, defaultValue = "Nevermind....Goodbye." )
        ).toConsole();
    }

    /**
     * Create a future that _returns_ a message to print out after 5 seconds.
     * Wait for a 3 second timeout. Do not return a default value.
     * See what happens on the main thread
     *     - when you do not wait for the future to complete?
     *     - when you wait for the future to complete?
     */
    function partFive() {
        var future = asyncManager.newFuture( () => {
            sleep( 5000 );
            return "Please wait for my greeting.";
        } );

        try {
            future.get( timeout = 3000 );
        } catch ( any e ) {
            print.redLine( "Whoops! We ran in to a timeout here." ).toConsole();
        }
    }

    function run() {
        print.blueLine( "Running all `01-intro-to-futures` exercises" ).toConsole();
        print.yellowLine( "Press Ctrl-C to exit" ).line().toConsole();

        partOne();
        partTwo();
        partThree();
        partFour();
        partFive();

        while ( true ) {
			if ( !isNull( checkInterrupted() ) ) {
				return;
			}
			sleep( 100 );
		}
    }

}