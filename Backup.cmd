@ECHO OFF

SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

REM Setup Variables...

REM Folder location where you want to store the resulting backup archive.
REM Do not put a '\' on the end, this will be added automatically.
REM You can enter a local path, an external drive letter (ex. F:) or a network location (ex. \\server\backups)
SET backupdir=G:\#BACKUP

REM Location where 7-Zip is installed on your computer.
REM The default is in a folder, '7-Zip' in your Program Files directory.
REM SET dir7Zip=%ProgramFiles%\7-Zip
SET dir7Zip=C:\Program Files\7-Zip

REM Usage variables.
SET exe7Zip=%dir7zip%\7z.exe
SET day=%DATE:~0,2%
SET month=%DATE:~3,2%
SET year=%DATE:~6,4%
SET hour=%TIME:~0,2%
SET minute=%TIME:~3,2%
SET second=%TIME:~6,2%

REM Validation
IF NOT EXIST "%exe7Zip%" (
  ECHO 7-Zip is not installed in the location: %dir7Zip%
  ECHO Please update the directory where 7-Zip is installed.
  GOTO End
)
	
REM Make Directories...
IF NOT EXIST "%backupdir%\%year%\%month%\%day%\" (
  ECHO Folder for backup "%backupdir%\%year%\%month%\%day%\" doesn`t exist
  ECHO Created...
  ECHO.
  MKDIR "%backupdir%\%year%\%month%\%day%\"
)

REM BACKUP...
ECHO Compressing backed up files. (New window)
REM Compress files using 7-Zip in a lower priority process.
START "Compressing Backup. DO NOT CLOSE" /belownormal /wait "%exe7Zip%" a -tzip -mx5 "%backupdir%\%year%\%month%\%day%\%year%_%month%_%day%.zip" @backup_include.lst
ECHO Done compressing backed up files.
ECHO.

:End
ECHO Finished.
ECHO.

ENDLOCAL