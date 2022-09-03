/**
 * This exercise goes over:
 *     + Catching exceptions the traditional way
 *     + Catching exceptions asynchronously
 *     + Recovering from exceptions
 *     + Built in LogBox logging
 *     + Handling both results and errors in the same callback
 *
 * You can run this exercise from the root in CommandBox by running:
 *     `task run exercises/03-exceptions.cfc`
 *
 * You can use the `print` helper provided by CommandBox to log messages.
 * (Use `print.line( "message" ).toConsole()` if you're not familiar with it.)
 * Make sure to end with `.toConsole()` so your message is flushed
 * to the console the moment it is printed.
 */
component extends="../BaseTask" {

    /**
     * Create a future that throws an exception.
     * Catch this exception using a `try` / `catch` statement when calling `future.get()`.
     *
     * Question: What is the exception type in the `catch` statement?
     */
    function partOne() {
        return;
    }

    /**
     * Create a future that throws an exception.
     * Catch this exception asynchronously.
     * Log a friendly error message to the console asynchronously.
     *
     * Question: What is the exception type in the asynchronous `catch`?
     */
    function partTwo() {
        return;
    }

    /**
     * Create a future that may throw an exception using the `fakeAjax` helper.
     * Catch this exception asynchronously. Return the a default quote of your choosing from this step.
     * Output the value of the pipeline to the console asynchronously.
     */
    function partThree() {
        return;
    }

    /**
     * Create a future that may throw an exception using the `fakeAjax` helper.
     * Handle both the error case and the success case at the same time.
     * In the error case, use a default quote of your choosing.
     * In the success case, use the passed in quote.
     * Output the quote to the console asynchronously.
     */
    function partFour() {
        return;
    }

    /**
     * Create a future that may throw an exception using the `fakeAjax` helper.
     * Catch this exception asynchronously. Return the a default quote of your choosing from this step.
     * Process the quote value asynchronously by passing it to `flakyAnalyticsRequest`.
     * Catch this execption asynchronously. Return the current quote value.
     * Output the value of the pipeline to the console asynchronously.
     */
    function partFive() {
        return;
    }

    function run() {
        print.blueLine( "Running all `03-exceptions` exercises" ).toConsole();
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

    private string function fakeAjax() {
        sleep( randRange( 300, 1500 ) );
        if ( randRange( 1, 2 ) == 1 ) {
            var errors = [
                "Server is down",
                "Database is down",
                "Request timeout",
                "Out for lunch"
            ];
            throw( errors[ randRange( 1, errors.len() ) ] );
        }
        var quotesPath = expandPath( "/commandbox" ) & "/system/Quotes.txt";
        var quotes = fileRead( quotesPath ).listToArray( chr( 13 ) & chr( 10 ) );
        return quotes[ randRange( 1, quotes.len() ) ];
    }

}