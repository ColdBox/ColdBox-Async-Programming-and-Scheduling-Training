/**
 * This exercise goes over:
 *     + Combining Futures
 *     + Composing Futures
 *     + Racing Futures
 *     + Waiting for multiple Futures
 *
 * You can run this exercise from the root in CommandBox by running:
 *     `task run exercises/05-parallel-tasks.cfc`
 *
 * You can use the `print` helper provided by CommandBox to log messages.
 * (Use `print.line( "message" ).toConsole()` if you're not familiar with it.)
 * Make sure to end with `.toConsole()` so your message is flushed
 * to the console the moment it is printed.
 */
component extends="../BaseTask" {

    /**
     * Use the `secureRandomNumber` function to asynchronously fetch a random number twice.
     * Combine these futures by adding their results.
     * Then print out the sum asynchronously.
     */
    function partOne() {
        return asyncManager.newFuture( () => secureRandomNumber() )
            .thenCombine(
                asyncManager.newFuture( () => secureRandomNumber() ),
                ( x, y ) => x + y
            )
            .then( ( sum ) => print.line( sum ).toConsole() );
    }

    /**
     * Use a `fetchLocation` function to asynchronously fetch a user's location.
     * The location response is as follows:
     * ```
     * { "lat": number, "lon": number }
     * ```
     * Then use the `fetchWeather( lat, lon )` function to asynchronously fetch a user's weather.
     * The location response is as follows:
     * ```
     * { "high": number, "low": number, "name": string }
     * ```
     * Use the weather information to print out a helpful message for the user asynchronously.
     */
    function partTwo() {
        return asyncManager.newFuture( () => fetchLocation() )
            .thenCompose( ( location ) => asyncManager.newFuture( () => fetchWeather( location.lat, location.lon ) ) )
            .then( ( weather ) => print.line( "Today has a high of #weather.high# and a low of #weather.low#." ).toConsole() );
    }

    /**
     * Use the `fetchWeather( lat, lon, name )` function to asynchronously fetch a user's weather.
     * The location response is as follows:
     * ```
     * { "high": number, "low": number, "name": string }
     * ```
     * Make three concurrent `fetchWeather` requests.
     * Use the fastest response to print out a helpful weather message for the user asynchronously.
     */
    function partThree() {
        return asyncManager.anyOf( [
            () => fetchWeather( 29.760427, -95.369804, "Weather.com" ),
            () => fetchWeather( 29.760427, -95.369804, "AccuWeather" ),
            () => fetchWeather( 29.760427, -95.369804, "DarkSky" )
        ] ).then( ( weather ) => {
            print.line( "This weather report brought to you by #weather.name#." ).toConsole();
            print.line( "Today has a high of #weather.high# and a low of #weather.low#." ).toConsole();
        } );
    }

    /**
     * Use the `secureRandomNumber` function to generate 10 random numbers concurrently.
     * When all the Futures have completed, sum them.
     * Then print out the sum asynchronously.
     */
    function partFour() {
        var randomNumberFutures = [];
        for ( var i = 1; i <= 10; i++ ) {
            randomNumberFutures.append( () => secureRandomNumber() );
        }
        return asyncManager.all( randomNumberFutures ).then( ( randomNumbers ) => {
            print.line( "The random numbers are: #randomNumbers.toList( ", " )#" ).toConsole();
            print.line( "The sum is: #randomNumbers.sum()#" ).toConsole();
        } );
    }

    function run() {
        print.blueLine( "Running all `05-parallel-tasks` exercises" ).toConsole();

        print.line().line( "Part One" ).toConsole();
        partOne().get();

        print.line().line( "Part Two" ).toConsole();
        partTwo().get();

        print.line().line( "Part Three" ).toConsole();
        partThree().get();

        print.line().line( "Part Four" ).toConsole();
        partFour().get();
    }

    private numeric function secureRandomNumber() {
        sleep( randRange( 300, 1500 ) );
        return randRange( 1, 100 );
    }

    private struct function fetchLocation() {
        sleep( randRange( 1000, 3000 ) );
        return {
            "lat": rand() * 100,
            "lon": rand() * 100
        };
    }

    private struct function fetchWeather(
        required numeric lat,
        required numeric lon,
        string name = "default"
    ) {
        sleep( randRange( 1000, 3000 ) );
        return {
            "name": arguments.name,
            "high": randRange( 0, 110 ),
            "low": randRange( 0, 110 )
        };
    }

}