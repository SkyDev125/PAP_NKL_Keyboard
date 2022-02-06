@ECHO OFF 
flutter build bundle & ssh -t pi@nkl 'rm' '-r' 'my_apps_flutter_assets' & scp -r ./build/flutter_assets/ pi@nkl:/home/pi/my_apps_flutter_assets