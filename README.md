
## Contributing Applications

1. **Add .bat Files to APPS:**
   - Create a new .bat file in the `C:\CommandPower\Sys32\APPS` directory for your application.
   - The .bat file in APPS should call the corresponding executable in the LIB folder.

2. **Place Executables in LIB:**
   - Put your application's executable or related files in the `C:\CommandPower\Sys32\LIB` directory.

3. **Update YourApp.bat in APPS:**
   - Edit the `YourApp.bat` file in APPS to reflect the correct paths and executable name.

   ```batch
   @echo off
   setlocal

   rem Change the path and executable name accordingly
   set "LIB_PATH=C:\CommandPower\Sys32\LIB"
   set "APP_EXECUTABLE=YourApp.exe"

   rem Change to the LIB directory
   pushd "%LIB_PATH%"

   rem Run the application
   start "" "%LIB_PATH%\%APP_EXECUTABLE%"

   rem Return to the APPS directory
   popd

   endlocal
