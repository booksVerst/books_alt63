rem clean trash after building if success
if exist 00000030.datf (
	if exist *.stb del /q *.stb
	if exist *.time del /q *.time
	if exist ogre.cfg del /q ogre.cfg
	echo Trash cleared
) else echo No datf file found to clear
