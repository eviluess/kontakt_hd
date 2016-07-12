@echo off
setlocal EnableDelayedExpansion

rem debug
rem set PROCESSOR_ARCHITECTURE=x64
REM C_DRV=FAT32
REM I_DRV=FAT32


reg add "hklm\SOFTWARE\Native Instruments\Kontakt HD Edition" /v k4u /t REG_SZ /d "EVILUESS@QQ.COM" /f

set skip=skip=2

FOR /F "skip=4 tokens=1*" %%i IN ('@reg query "hklm\SOFTWARE\Native Instruments\Kontakt HD Edition" /v k4u') DO (
set skip=skip=4
)

cd /d %~dp0
set iroot=%cd%

call :nok4u

cd Packages
set proot=%cd%

rd junctest

set uz=7z x -y
set xz=7z a -t7z -mx=9

if not exist "tools" goto end_inttools

rd ".\temp"
rd /q /s ".\temp"

%uz% tools.7z -o"temp"

xcopy /s /h /r /y /i "temp\crack" "temp"
xcopy /s /h /r /y /i "temp\txt" "temp"

rd "temp\crack"
rd /q /s "temp\crack"

rd "temp\txt"
rd /q /s "temp\txt"

xcopy /s /h /r /y /i "tools" "temp"

del /q /f temp.7z
%xz% ".\temp.7z" ".\temp\*"

echo f|xcopy /h /r /y .\temp.7z .\tools.7z

rd ".\temp"
rd /q /s ".\temp"

rd ".\tools"
rd /q /s ".\tools"

del /q /f temp.7z

:end_inttools

set tools=%temp%\nilv

%uz% tools.7z -o"%tools%"
%uz% ..\SymphonicChoirs\sctools.7z -o"%tools%"

if "x86"=="%PROCESSOR_ARCHITECTURE%" goto cfgx86

set sys32=%windir%\SysWOW64
set lms=hklm\SOFTWARE\Wow6432Node
set commonx86=%CommonProgramFiles(x86)%

goto linkuserdata

:cfgx86

set sys32=%windir%\system32
set lms=hklm\SOFTWARE
set commonx86=%CommonProgramFiles%

:linkuserdata

FOR /F "%skip% tokens=2*" %%i IN ('@reg query "hklm\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CurrentVersion') DO (
 set windows_version=%%j%
)

set k5vst32xpflag=
if "%windows_version%"=="5.1" set k5vst32xpflag=XP

set jd="%tools%\junction"

call :testjunc "." "junctest"

if %jret%==fail goto movekore

%jd% -d "%USERPROFILE%\Documents\Native Instruments" 
md "%iroot%\User"
xcopy /s /h /r /y /i "%USERPROFILE%\Documents\Native Instruments" "%iroot%\User"
rd /q /s "%USERPROFILE%\Documents\Native Instruments"
%jd% "%USERPROFILE%\Documents\Native Instruments" "%iroot%\User"

%jd% -d "%iroot%\User\Kontakt 4" 
xcopy /s /h /r /y /i "%iroot%\User\Kontakt 4" "%iroot%\User\Kontakt 5"
rd /q /s "%iroot%\User\Kontakt 4"
md "%iroot%\User\Kontakt 5"
%jd% "%iroot%\User\Kontakt 4" "%iroot%\User\Kontakt 5"

rd /q /s "%iroot%\User\Kontakt 5\Crashlogs"
rd /q /s "%iroot%\User\Kontakt 4\Crashlogs"
rd /q /s "%iroot%\User\Kontakt 3\Crashlogs"

:movekore

if not exist "%iroot%\Kontakt4\kore2" goto movekore_file

xcopy /s /h /r /y /i "%iroot%\Kontakt4\kore2" "%iroot%\Kontakt5\kore2"
rd /q /s "%iroot%\Kontakt4\kore2"

:movekore_file

if not exist "%iroot%\Kontakt4\kore2.7z" goto movekore_end

echo f|xcopy /h /r /y "%iroot%\Kontakt4\kore2.7z" "%iroot%\Kontakt5\kore2.7z"
del /q /f "%iroot%\Kontakt4\kore2.7z"

:movekore_end

:lansel

rem debug
rem set commonx86=E:\Temp\commonx86
rem set CommonProgramFiles=E:\Temp\common3264

cls

echo 1. English
echo 2. �������� (Chinese Simplified)
echo.

set /p choi=[1~2]:

if %choi% == 1 goto English

set str_nontfs=Native Instrument Kontakt ���� 2016 ׼��װ��������װҪ��Common�ļ������ڷ���ΪNTFS��
set str_install_title=Native Instrument Kontakt ���� HD 2016 ����װ����
set str_install=��װ
set str_uninstall=ж��
set str_readme=�򿪰����ļ��͹���Ŀ¼
set str_reglib=����Kontakt��ɫ��ע�Ṥ��
set str_choose=��ѡ��1~
set str_keepdfd=�Ƿ���DFD��֧���Ա�Kontakt2 Player�ȳ�������������У�
set str_selvstpath=��ѡ��VST·��
set str_manualpath=�ֶ�����
set str_sysvstpath=ϵͳĬ��
set str_autosearch=�Զ�����
set str_by_cakewalk=��Cakewalk�ṩ
set str_vstpath_notfound=�޷��ҵ�VST·��
set str_vstpath_notfound64=�޷��ҵ�64λVST·��
set str_please_input=�������Ӽ��а����������VST·��������ֱ����קĿ���ļ��е������ڣ�
set str_update_syspath=�Ƿ���µ�ϵͳVSTĿ¼��
set str_yes=��
set str_no=��
set str_enter12=������1��2�����س���:
set str_clean=�Ƿ��ڰ�װǰ����ɰ棿
set str_installdxi=Ҫ��װDXi����
set str_intro_old_names=�����֮ǰ�ù�Kontakt��Ҳ����Ҫ��kontakt 2.11������ʽ���ļ�������ȷʵ�븴��һ�������ļ����İ汾�𣨽������ֶ�ȥVSTĿ¼��ɾ����ϲ�������֣���
set str_recommended=���Ƽ�
set str_share_convolution=ԭ��Kontakt 3.5���Դ�����������Kontakt 2�Ŀ����ṩ�����ã����������Kontakt 3.5��ʹ�û�����������ѡ��װ������ռ��Լ131M���̿ռ䡣��ȷ����װ��
set str_install64=���������е�ϵͳ��64λ�ģ��������Ҫѡ��64λKontakt 3/4�İ�װϸ��
set str_ovw32=ʹ��32λ��Ŀ¼��������װKontakt 3/4��32λ�汾����64λ����Ϊ�����û���
set str_64spec=ָ��64λ��Ŀ¼����32λ���棬ע�ⲻҪ���õ�32λĿ¼�У�
set str_no64=����װ64λ�İ汾
set str_pack=Kontakt�Ѿ���װ��ɡ��򲿷����û����װ�����򲿷ַ�������NTFS����Ŀǰ���ڶ�����д���Խ�ʡ���̿ռ䡭��
set str_ask_rtas=�Ƿ�װRTAS��AAX�����
set str_ask_k12=�Ƿ�װKontakt 1��2�Ĳ���汾?
set str_convolution4=�������ʹ��Kontakt 4�⣬������ȥ��װ���������⽫�����ϵͳ�̽�ʡ500M�ռ䡣ȷ��ҪװKontakt 4�õĻ�������
set str_kore2=�����������֧��Kore2������ʡȥΪϵͳ�̽�ʡ55M�ռ䡣ȷ��Ҫ��װKore2֧����
set str_great_uninstall=���ɾ��������װ�󣬰�װ���������ļ��������Խ�ʡ���̿ռ䣩
set str_uhelper=Kontakt 5.x��������
set str_run_updater=������Kontakt 5�������򣬲�������ɺ������������ǧ��Ҫ�ڰ�װ������ѡ��'Uninstall'������е�ѡ������
set str_update_fail=����ʧ�ܣ��Ƿ����ԣ�
set str_update_ok=���³ɹ������ڰѸ��µ��ļ����µ���װ���У����Ժ򡭡�
set str_must_reinstall=���ճɹ����밴��������밲װ���棬����װ�ķ�ʽ��װһ�Ρ���
set str_greatpack=���ڴ����������Խ�ʡ�ռ䡭��
set str_isxp=˵����XPϵͳ�£�Kontakt 5.3.1�����һ����ִ�еİ汾

goto install

:English

set str_nontfs=Welcome to Native Instrument Kontakt (Code Solitaire) SEMI-HD Edition Setup (The Real HD Edition requires the volume containing the common folder to be NTFS)
set str_install_title=Welcome to Native Instrument Kontakt HD Edition (Code Solitaire) Setup
set str_install=Install
set str_uninstall=Uninstall
set str_readme=Browse all tools and documents(in Chinese)
set str_reglib=Run the Kontakt Library Register Tool
set str_choose=Please choose from 1~
set str_keepdfd=Keep the DFD files for Kontakt2 player?
set str_selvstpath=Select the VST Path
set str_vstpath_notfound=VST Path Not Found
set str_vstpath_notfound64=64-bit VST Path Not Found
set str_manualpath=Input Manually
set str_sysvstpath=System Default
set str_autosearch=Auto Search
set str_by_cakewalk=By Cakewalk
set str_please_input=Please input the vst path manually or paste from the clipboard, drap and drop the folder is recommended:
set str_update_syspath=Do you want to update the result to the system vst path?
set str_yes=Yes
set str_no=No
set str_enter12=Please choose 1 or 2 and hit the Enter key:
set str_clean=Do some cleaning before install?
set str_installdxi=Install the DXi Versions?
set str_intro_old_names=If you have used kontakt before, you may need the files like kontakt 2.11. Would you still like to use the old names(You can go to the VST Directory and delete the ones you don't like in future)?
set str_recommended=, Recommended
set str_share_convolution=The Original Kontakt 3.5 doesn't contain convolution, but if you like, setup can copy the one from Kontakt 2 for it. This will take up about 131M disk space. Do you want to install?
set str_install64=You can determine how the Kontakt 3/4(x64) is installed
set str_ovw32=Install to the same location as the x86 does, which will overwrite the x86 version(for Sonar and Reaper users).
set str_64spec=Install to other location, both x86 and x64 can be used for various hosts. Please don't make it inside the path to the 32-bit's!
set str_no64=Don't want to instal the x64 version
set str_pack=Kontakt is installed successfully. Because some components are not installed, or their junction cannot be created, setup is compressing them now.
set str_ask_rtas=Install RTAS and AAX?
set str_ask_k12=Install Kontakt 1 and 2?
set str_convolution4=You don't need to install the convolution that is for the Kontakt 4 Library. You will save about 500M disk space if you decide not installing the convolution. Do you want to install it?
set str_kore2=You don't need to install the files that is for the Kore 2. You will save about 50M disk space if you decide not installing it. Do you want to install it?
set str_great_uninstall=Great Uninstall (Pack all files after the uninstallation to save disk space)
set str_uhelper=Kontakt 5.x Update helper
set str_run_updater=Press any key after the Kontakt 5 Updater is finished. DO NOT select the 'Uninstall' Option at the Updater if it shows!
set str_update_fail=Update failed, retry?
set str_update_ok=Update succeeded, integrating the new files back into the setup package. Please wait.
set str_must_reinstall=Integration succeeded, press any key to install it again as the HD Edtion.
set str_greatpack=Packing some components to save the disk space ....
set str_isxp=Note:The last executable Konakt 5 is v5.3.1 under Windows XP

:install

reg add "hkcu\Software\Sysinternals\Junction" /v EulaAccepted /t REG_DWORD /d 1 /f
reg add "hkcu\Software\Sysinternals\Movefile" /v EulaAccepted /t REG_DWORD /d 1 /f

call :testjunc "." "junctest"

set localjunc=%jret%

call :testjunc "%CommonProgramFiles%" "junctest"

set commonjunc=%jret%

call :testjunc "%commonx86%" "junctest"

set commonjuncx86=%jret%

if %commonjunc%==fail set str_install_title=%str_nontfs%
if %commonjuncx86%==fail set str_install_title=%str_nontfs%

set qupdate=no

set xpremark=
if "%k5vst32xpflag%"=="XP" set xpremark= (%str_isxp%)

call :qsel "%str_install_title%" "%str_install%%xpremark%" "%str_uninstall%" "%str_readme%" "%str_reglib%" "%str_great_uninstall%" "%str_uhelper%"

if %choi%==2 call :uninstall quit
if %choi%==3 goto readme
if %choi%==4 goto regtool
if %choi%==5 call :uninstall pack
if %choi%==6 call :update

goto dosetup


:getpaths

if not "%vstpath%"=="" goto :eof

set /a idx=0

call :fillvstpaths "?" "!str_manualpath!" add

FOR /F "%skip% tokens=2*" %%i IN ('@reg query "%lms%\VST" /v VSTPluginsPath') DO (
 set sysvstpath=%%j%
)

FOR /F "%skip% tokens=2*" %%i IN ('@reg query "hklm\SOFTWARE\Wow6432Node\VST" /v VSTPluginsPath') DO (
 call :fillvstpaths "%%j%" "!str_sysvstpath!" md
)

FOR /F "%skip% tokens=2*" %%i IN ('@reg query "hklm\SOFTWARE\VST" /v VSTPluginsPath') DO (
 call :fillvstpaths "%%j%" "!str_sysvstpath!" md
)

FOR /F "%skip% tokens=2*" %%i IN ('@reg query "hklm\SOFTWARE\Native Instruments\Kontakt HD Edition" /v InstallVSTDir') DO (
 call :fillvstpaths "%%j%" "Kontakt HD Edition" md
)

FOR /F "%skip% tokens=2*" %%i IN ('@reg query "hkcu\SOFTWARE\Native Instruments\Kontakt" /v InstallVSTDir') DO (
 call :fillvstpaths "%%j%" "Kontakt" kontakt
)

FOR /F "%skip% tokens=2*" %%i IN ('@reg query "%lms%\Native Instruments\Kontakt2" /v InstallVSTDir') DO (
 call :fillvstpaths "%%j%" "Kontakt 2" kontakt
)

FOR /F "%skip% tokens=2*" %%i IN ('@reg query "%lms%\Native Instruments\Kontakt3" /v InstallVSTDir') DO (
 call :fillvstpaths "%%j%" "Kontakt 3" kontakt
)

FOR /F "%skip% tokens=2*" %%i IN ('@reg query "hklm\SOFTWARE\Native Instruments\Kontakt 4" /v InstallVSTDir') DO (
 call :fillvstpaths "%%j%" "Kontakt 4" kontakt
)

FOR /F "%skip% tokens=2*" %%i IN ('@reg query "hklm\SOFTWARE\Native Instruments\Kontakt 5" /v InstallVSTDir') DO (
 call :fillvstpaths "%%j%" "Kontakt 5" kontakt
)

FOR %%i in (Z,Y,X,W,V,U,T,S,R,Q,P,O,N,M,L,K,J,I,H,G,F,E,D,C) do (
	call :fillvstpaths "%%i:\Program Files\Steinberg\VstPlugins" "%str_autosearch%" vst
)

FOR %%i in (Z,Y,X,W,V,U,T,S,R,Q,P,O,N,M,L,K,J,I,H,G,F,E,D,C) do (
	call :fillvstpaths "%%i:\Program Files (x86)\Steinberg\VstPlugins" "%str_autosearch%" vst
)

FOR %%i in (Z,Y,X,W,V,U,T,S,R,Q,P,O,N,M,L,K,J,I,H,G,F,E,D,C) do (
	call :fillvstpaths "%%i:\Program Files (x86)\Common Files\Steinberg\VST2" "%str_autosearch%" vst
)

FOR /F "%skip% tokens=2*" %%i IN ('@reg query "%lms%\Cakewalk Music Software\VSTPlugins" /v InstallDirectory') DO (
 call :fillvstpaths "%%j%" "!str_by_cakewalk!" vst
)

cls

if not %idx%==1 goto promptpaths

echo %str_vstpath_notfound%

goto input_vstpath

:promptpaths
echo %str_selvstpath%
echo.

set /a i=1
set /a choi=%idx%+1 

:showvstpaths

echo.
echo %i%. !vstpaths%i%! [!vstpathtypes%i%!]

set /a i+=1

if not %i%==%choi% goto showvstpaths

echo.
echo.
set /p choi=%str_choose%%idx%:

if not %choi% == 1 goto vstpath_selected

:input_vstpath

echo.
set /p vstpath=%str_please_input%

call :setvar vstpath %vstpath%

md "%vstpath%"

goto chk_vstpath

:vstpath_selected
set vstpath=!vstpaths%choi%!

:chk_vstpath

if not exist "%vstpath%" goto readme

if /i "%sysvstpath%" == "%vstpath%" goto setup

call :ask_yesno "%str_update_syspath%"

if %choi%==2 goto setup

reg add "%lms%\VST" /v VSTPluginsPath /t reg_sz /d "%vstpath%" /f

:setup

set choi64=3

if "x86"=="%PROCESSOR_ARCHITECTURE%" goto :eof

call :qsel "%str_install64%" "%str_ovw32%" "%str_64spec%" "%str_no64%"

set choi64=%choi%

if %choi%==1 goto ovw32
if %choi%==3 goto :eof

set choi64=2

set /a idx=0

call :fillvstpaths "?" "!str_manualpath!" add

FOR /F "%skip% tokens=2*" %%i IN ('@reg query "hklm\SOFTWARE\VST" /v VSTPluginsPath') DO (
 call :fillvstpaths "%%j%" "!str_sysvstpath!" md
)

FOR /F "%skip% tokens=2*" %%i IN ('@reg query "hklm\SOFTWARE\Native Instruments\Kontakt HD Edition" /v InstallVST64Dir') DO (
 call :fillvstpaths "%%j%" "Kontakt HD Edition" md
)

FOR /F "%skip% tokens=2*" %%i IN ('@reg query "%lms%\Native Instruments\Kontakt3" /v InstallVST64Dir') DO (
 call :fillvstpaths "%%j%" "Kontakt 3" kontakt
)

FOR /F "%skip% tokens=2*" %%i IN ('@reg query "hklm\Software\Native Instruments\Kontakt 4" /v InstallVST64Dir') DO (
 call :fillvstpaths "%%j%" "Kontakt 4" kontakt
)

FOR /F "%skip% tokens=2*" %%i IN ('@reg query "hklm\Software\Native Instruments\Kontakt 5" /v InstallVST64Dir') DO (
 call :fillvstpaths "%%j%" "Kontakt 5" kontakt
)

FOR %%i in (Z,Y,X,W,V,U,T,S,R,Q,P,O,N,M,L,K,J,I,H,G,F,E,D,C) do (
	call :fillvstpaths "%%i:\Program Files\VstPlugins" "%str_autosearch%" vst
)

cls

if not %idx%==1 goto promptpaths64

echo %str_vstpath_notfound64%

goto input_vstpath64

:promptpaths64
echo %str_selvstpath%
echo.

set /a i=1
set /a choi=%idx%+1 

:showvstpaths64

echo.
echo %i%. !vstpaths%i%! [!vstpathtypes%i%!]

set /a i+=1

if not %i%==%choi% goto showvstpaths64

echo.
echo.
set /p choi=%str_choose%%idx%:

if not %choi% == 1 goto vstpath_selected64

:input_vstpath64

echo.
set /p vst64path=%str_please_input%

call :setvar vst64path %vst64path%

md "%vst64path%"

goto chk_vstpath64

:vstpath_selected64
set vst64path=!vstpaths%choi%!

:chk_vstpath64

if not exist "%vst64path%" goto setup

set vstpathlead=%vstpath%\
call :strlen "%vstpathlead%"

set path64lead=%vst64path%\
set path64lead=!path64lead:~0,%result%!

if /i "%path64lead%"=="%vstpathlead%" goto setup

goto :eof

:ovw32
set vst64path=%vstpath%

goto :eof

:update

if %qupdate%==yes goto retry_update

set k5regroot="hklm\SOFTWARE\Native Instruments\Kontakt 5"
set uroot=%ProgramFiles%\Native Instruments\Kontakt 5

md "%uroot%"

md "%uroot%\VST32"
md "%uroot%\VST64"

echo X>"%uroot%\VST32\Kontakt 5.dll"
echo X>"%uroot%\VST64\Kontakt 5.dll"

REM %uz% .\Documentation.7z -o"%uroot%\Documentation"
xcopy /s /h /r /y /i "Documentation" "%uroot%\Documentation"

rd ..\Kontakt5\common\presets\effects\convolution
rd "%CommonProgramFiles%\Native Instruments\Kontakt 5\presets\effects\convolution"
rd /q /s "%CommonProgramFiles%\Native Instruments\Kontakt 5\presets\effects\convolution"

rd ..\Kontakt5\common\presets\Scripts\HD-Edition
xcopy /s /h /r /y /i ..\Kontakt5\common\presets\Scripts\HD-Edition\*.* ..\Packages\Scripts\*.*
rd /q /s ..\Kontakt5\common\presets\Scripts\HD-Edition

rd ..\Kontakt5\common\presets\Multiscripts\HD-Edition
xcopy /s /h /r /y /i ..\Kontakt5\common\presets\Multiscripts\HD-Edition\*.* ..\Packages\Multiscripts\*.*
rd /q /s ..\Kontakt5\common\presets\Multiscripts\HD-Edition

call :jc_keepack "..\Kontakt5" "common" "%CommonProgramFiles%\Native Instruments" "Kontakt 5"
call :jc_keepack "..\Kontakt5" "convolution" "%CommonProgramFiles%\Native Instruments\Kontakt 5\presets\effects" "convolution"
call :jc_keepack "..\Kontakt5" "kore2" "%CommonProgramFiles%\Native Instruments\Shared Content\Sounds" "Kontakt 5"

rd "%commonx86%\Avid\Audio\Plug-Ins\Kontakt 5.aaxplugin"
rd /q /s "%commonx86%\Avid\Audio\Plug-Ins\Kontakt 5.aaxplugin"
call :jc_keepack "..\Kontakt5" "aax32" "%commonx86%\Avid\Audio\Plug-Ins" "Kontakt 5.aaxplugin"

rd "%CommonProgramFiles%\Avid\Audio\Plug-Ins\Kontakt 5.aaxplugin"
rd /q /s "%CommonProgramFiles%\Avid\Audio\Plug-Ins\Kontakt 5.aaxplugin"
call :jc_keepack "..\Kontakt5" "aax64" "%CommonProgramFiles%\Avid\Audio\Plug-Ins" "Kontakt 5.aaxplugin"
%uz% ..\Kontakt5\rtas.7z -o"%commonx86%\Digidesign\DAE\Plug-Ins\."

reg add %k5regroot% /v InstallRTASDir /t REG_SZ /d "%uroot%" /f
reg add %k5regroot% /v InstallDir /t REG_SZ /d "%uroot%" /f
reg add %k5regroot% /v InstallVSTDir /t REG_SZ /d "%uroot%\VST32" /f
reg add %k5regroot% /v InstallVST64Dir /t REG_SZ /d "%uroot%\VST64" /f

echo f|xcopy /h /r /y "%tools%\k4u.reg" "%uroot%\Kontakt 5.exe"

:retry_update

reg add "hklm\SOFTWARE\Native Instruments\Kontakt HD Edition" /v k4u /t REG_SZ /d "bat" /f

cls
echo %str_run_updater%
pause>nul

set qupdate=no

if not exist "%uroot%\Kontakt 5\Kontakt 5.exe" goto old_update

xcopy /s /h /r /y /i "%uroot%\Kontakt 5" "%uroot%"

:old_update
if not exist "%uroot%\Kontakt 5.exe" goto update_fail

set qupdate=yes

regedit /s "%uroot%\Kontakt 5.exe"

FOR /F "%skip% tokens=2*" %%i IN ('@reg query "hklm\SOFTWARE\Native Instruments\Kontakt HD Edition" /v k4u') DO (
 set k5u_result=%%j%
)

if "%k5u_result%"=="reg" goto update_fail

cls
echo %str_update_ok%

if "x86"=="%PROCESSOR_ARCHITECTURE%" (set exe_dest=x86) else set exe_dest=x64

echo f|xcopy /h /r /y "%uroot%\Kontakt 5.exe" "..\Kontakt5\Kontakt 5 - %exe_dest%.exe"

del /q /f "..\Kontakt5\temp.7z"

%xz% "..\Kontakt5\temp.7z" "%commonx86%\Digidesign\DAE\Plug-Ins\Kontakt 5.dpm"
del /q /f "..\Kontakt5\rtas.7z"
ren "..\Kontakt5\temp.7z" "rtas.7z"

del /q /f "..\Kontakt5\temp.7z"

%xz% "..\Kontakt5\temp.7z" "%commonx86%\Avid\Audio\Plug-Ins\Kontakt 5.aaxplugin\*"
del /q /f "..\Kontakt5\aax32.7z"
ren "..\Kontakt5\temp.7z" "aax32.7z"
rd /q /s "..\Kontakt5\aax32"

del /q /f "..\Kontakt5\temp.7z"

%xz% "..\Kontakt5\temp.7z" "%CommonProgramFiles%\Avid\Audio\Plug-Ins\Kontakt 5.aaxplugin\*"
del /q /f "..\Kontakt5\aax64.7z"
ren "..\Kontakt5\temp.7z" "aax64.7z"
rd /q /s "..\Kontakt5\aax64"

del /q /f "..\Kontakt5\temp.7z"

FOR /F "%skip% tokens=2*" %%i IN ('@reg query "hklm\SOFTWARE\Native Instruments\Kontakt 5" /v InstallVSTDir') DO (
 set sysvstpathbyk5=%%j%
)

%xz% "..\Kontakt5\temp.7z" "%sysvstpathbyk5%\Kontakt 5*.*"
del /q /f "..\Kontakt5\VST32.7z"
ren "..\Kontakt5\temp.7z" "VST32.7z"
rd /q /s "..\Kontakt5\VST32"
del /q /f "%sysvstpathbyk5%\Kontakt 5*.*"

set sysvstpathbyk5=x

FOR /F "%skip% tokens=2*" %%i IN ('@reg query "hklm\SOFTWARE\Native Instruments\Kontakt 5" /v InstallVST64Dir') DO (
 set sysvstpathbyk5=%%j%
)

if "x"=="%sysvstpathbyk5%" goto update_x64_end

REM if "x86"=="%PROCESSOR_ARCHITECTURE%" goto update_x64_end

%xz% "..\Kontakt5\temp.7z" "%sysvstpathbyk5%\Kontakt 5*.*"
del /q /f "..\Kontakt5\VST64.7z"
ren "..\Kontakt5\temp.7z" "VST64.7z"
rd /q /s "..\Kontakt5\VST64"
del /q /f "%sysvstpathbyk5%\Kontakt 5*.*"

:update_x64_end

call :recycle4 "%CommonProgramFiles%\Native Instruments\Shared Content\Sounds" "Kontakt 5" "..\Kontakt5" "Kore2"
call :recycle4 "%CommonProgramFiles%\Native Instruments\Kontakt 5\presets\effects" "convolution" "..\Kontakt5" "convolution"
call :recycle4 "%CommonProgramFiles%\Native Instruments" "Kontakt 5" "..\Kontakt5" "common"

del /q /f ".\temp.7z"
rd /q /s "%uroot%\Documentation\License Agreement"
del /q /f "%uroot%\Documentation\Readme.txt"
REM %xz% ".\temp.7z" "%uroot%\Documentation\*"
xcopy /s /h /r /y /i "%uroot%\Documentation" "Documentation"
REM del /q /f ".\Documentation.7z"
REM ren ".\temp.7z" "Documentation.7z"

rd /q /s "%uroot%"

cls
echo %str_must_reinstall%
pause>nul

goto :eof

:update_fail

cls
call :ask_yesno "%str_update_fail%"

if %choi%==1 goto update

rd /q /s "%uroot%"
call :exit false true

goto :eof

:dosetup

call :getpaths

cd /d "%proot%"

call :ask_yesno "%str_clean%"

if %choi% == 1 call :uninstall return

call :ask_yesno "%str_ask_rtas%"

if %choi% == 2 goto end_rtas

%uz% ..\Kontakt3\rtas.7z -o"%commonx86%\Digidesign\DAE\Plug-Ins\."
%uz% ..\Kontakt4\rtas.7z -o"%commonx86%\Digidesign\DAE\Plug-Ins\."
%uz% ..\Kontakt5\rtas.7z -o"%commonx86%\Digidesign\DAE\Plug-Ins\."
call :juncopy jc_aax32 "..\Kontakt5" "aax32" "%commonx86%\Avid\Audio\Plug-Ins" "Kontakt 5.aaxplugin"
call :juncopy jc_aax64 "..\Kontakt5" "aax64" "%CommonProgramFiles%\Avid\Audio\Plug-Ins" "Kontakt 5.aaxplugin"

:end_rtas

call :ask_yesno "%str_ask_k12%"

set k12_needed=false

if %choi% == 2 goto end_k12

set k12_needed=true
call :juncopy jc_k12 "." "Kontakt 1-2" "%vstpath%" "Kontakt 1-2"

:end_k12
  
call :juncopy jc_sc "..\SymphonicChoirs" "SymphonicChoirs" "%vstpath%" "SymphonicChoirs"
  
%uz% system32.7z -o"%sys32%"

%uz% ..\Kontakt3\default.7z -o"%USERPROFILE%\Local Settings\Application Data\Native Instruments\Kontakt 3\default"

rd ..\Kontakt3\common\presets\effects\convolution

if not exist "%USERPROFILE%\Local Settings\Application Data\Native Instruments\Kontakt 4\Db" %uz% ..\Kontakt5\Db.7z -o"%USERPROFILE%\Local Settings\Application Data\Native Instruments\Kontakt 4\Db"

if not exist "%USERPROFILE%\Local Settings\Application Data\Native Instruments\Kontakt 5\Db" %uz% ..\Kontakt5\Db.7z -o"%USERPROFILE%\Local Settings\Application Data\Native Instruments\Kontakt 5\Db"

%uz% ..\Kontakt4\default.7z -o"%USERPROFILE%\Local Settings\Application Data\Native Instruments\Kontakt 4\default"

%uz% ..\Kontakt5\default.7z -o"%USERPROFILE%\Local Settings\Application Data\Native Instruments\Kontakt 5\default"

rd ..\Kontakt4\common\presets\effects\convolution
rd ..\Kontakt5\common\presets\effects\convolution

if %localjunc%==ok goto safe_conv

call :jc_unpack jc_k3common "..\Kontakt3" "common" "%commonx86%\Native Instruments" "Kontakt 3"
call :jc_unpack jc_k45common "..\Kontakt5" "common" "%CommonProgramFiles%\Native Instruments" "Kontakt 5"
call :jc_unpack jc_k45common "..\Kontakt5" "common" "%CommonProgramFiles%\Native Instruments" "Kontakt 4"

md "%iroot%\Kontakt5\common\presets\Scripts\HD-Edition"
xcopy /s /h /r /y /i  "%iroot%\Packages\Scripts\*.*" "%iroot%\Kontakt5\common\presets\Scripts\HD-Edition\*.*"

md "%iroot%\Kontakt5\common\presets\Multiscripts\HD-Edition"
xcopy /s /h /r /y /i  "%iroot%\Packages\Multiscripts\*.*" "%iroot%\Kontakt5\common\presets\Multiscripts\HD-Edition\*.*"

goto common_end

:safe_conv

call :juncopy jc_k3common "..\Kontakt3" "common" "%commonx86%\Native Instruments" "Kontakt 3"
call :juncopy jc_k45common "..\Kontakt5" "common" "%CommonProgramFiles%\Native Instruments" "Kontakt 5"
call :juncopy jc_k45common "..\Kontakt5" "common" "%CommonProgramFiles%\Native Instruments" "Kontakt 4"

%jd% "%iroot%\Kontakt5\common\presets\Scripts\HD-Edition" "%iroot%\Packages\Scripts"
%jd% "%iroot%\Kontakt5\common\presets\Multiscripts\HD-Edition" "%iroot%\Packages\Multiscripts"

:common_end

if %choi64%==2 goto vst3264
if %choi64%==1 goto vst64

:vst32

call :juncopy jc_k3vst "..\Kontakt3" "VST32" "%vstpath%" "Kontakt 3.5"
call :pacopy jc_k3vst64 "..\Kontakt3" "VST64"

call :juncopy jc_k4vst "..\Kontakt4" "VST32" "%vstpath%" "Kontakt 4"
call :pacopy jc_k4vst64 "..\Kontakt4" "VST64"

call :juncopy jc_k5vst%k5vst32xpflag% "..\Kontakt5" "VST32%k5vst32xpflag%" "%vstpath%" "Kontakt 5"
call :pacopy jc_k5vst64 "..\Kontakt5" "VST64"

goto vst3264_end

:vst64

call :pacopy jc_k3vst "..\Kontakt3" "VST32"
call :juncopy jc_k3vst64 "..\Kontakt3" "VST64" "%vst64path%" "Kontakt 3.5"

call :pacopy jc_k4vst "..\Kontakt4" "VST32"
call :juncopy jc_k4vst64 "..\Kontakt4" "VST64" "%vst64path%" "Kontakt 4"

call :pacopy jc_k5vst "..\Kontakt5" "VST32"
call :juncopy jc_k5vst64 "..\Kontakt5" "VST64" "%vst64path%" "Kontakt 5"

goto vst3264_end

:vst3264

call :juncopy jc_k3vst "..\Kontakt3" "VST32" "%vstpath%" "Kontakt 3.5"
call :juncopy jc_k3vst64 "..\Kontakt3" "VST64" "%vst64path%" "Kontakt 3.5"

call :juncopy jc_k4vst "..\Kontakt4" "VST32" "%vstpath%" "Kontakt 4"
call :juncopy jc_k4vst64 "..\Kontakt4" "VST64" "%vst64path%" "Kontakt 4"

call :juncopy jc_k5vst%k5vst32xpflag% "..\Kontakt5" "VST32%k5vst32xpflag%" "%vstpath%" "Kontakt 5"
call :juncopy jc_k5vst64 "..\Kontakt5" "VST64" "%vst64path%" "Kontakt 5"

:vst3264_end

REM call :ask_yesno "%str_intro_old_names%"
set choi=2

if %choi% == 2 goto share_convolution

md "%vstpath%\Kontakt ON"

copy /y "%vstpath%\Kontakt 1-2\Kontakt 153.dll" "%vstpath%\Kontakt ON\Kontakt.dll"

copy /y "%vstpath%\Kontakt 1-2\Kontakt 201.dll" "%vstpath%\Kontakt ON\Kontakt 2.01.dll"
copy /y "%vstpath%\Kontakt 1-2\Kontakt 211.dll" "%vstpath%\Kontakt ON\Kontakt 2.11.dll"
copy /y "%vstpath%\Kontakt 1-2\Kontakt 223.dll" "%vstpath%\Kontakt ON\Kontakt 2.23.dll"

:share_convolution

if %commonjunc%==ok goto shareconv
call :ask_yesno "%str_share_convolution%"

if %choi% == 2 goto end_conv3

:shareconv

rd ..\Kontakt3\common\presets\effects\convolution 
rd "%commonx86%\Native Instruments\Kontakt 3\presets\effects\convolution"  
rd /q /s "%commonx86%\Native Instruments\Kontakt 3\presets\effects\convolution" 

%jd% "%commonx86%\Native Instruments\Kontakt 3\presets\effects\convolution" "..\Kontakt2\presets\effects\convolution" 

if exist "%commonx86%\Native Instruments\Kontakt 3\presets\effects\convolution" goto end_conv3

xcopy /s /h /r /y /i "..\Kontakt2\presets\effects\convolution" "%commonx86%\Native Instruments\Kontakt 3\presets\effects\convolution"

:end_conv3


if %commonjunc%==ok goto shareconv4
call :ask_yesno "%str_convolution4%"

if %choi% == 2 goto end_conv4

:shareconv4

call :juncopy jc_k45conv "..\Kontakt5" "convolution" "%CommonProgramFiles%\Native Instruments\Kontakt 5\presets\effects" "convolution"
call :juncopy jc_k45conv "..\Kontakt5" "convolution" "%CommonProgramFiles%\Native Instruments\Kontakt 4\presets\effects" "convolution"

cd /d "%CommonProgramFiles%\Native Instruments\Kontakt 5\presets\effects\convolution"

call :cnvtchall

cd /d "%CommonProgramFiles%\Native Instruments\Kontakt 4\presets\effects\convolution"

call :cnvtchall

goto end_conv4

:cnvtchall

call :cnvtch "01 Real Rooms"
call :cnvtch "02 Digital Reverbs"
call :cnvtch "03 Real Plate Reverbs"
call :cnvtch "04 Vocal Reverbs"
call :cnvtch "05 Drum Reverbs"
call :cnvtch "06 Drum Filters"
call :cnvtch "07 Piano Reverbs"
call :cnvtch "08 Tiny Rooms"
call :cnvtch "09 Medium Rooms"
call :cnvtch "10 Big Rooms"
call :cnvtch "11 Unsusual Reverbs"
call :cnvtch "12 Reverse Reverbs"
call :cnvtch "13 Plate Reverbs"
call :cnvtch "14 Surround Reverbs"
call :cnvtch "15 Special Effects"
call :cnvtch "16 Household"
call :cnvtch "17 Cabinets"
call :cnvtch "18 Instruments"

goto :eof


:end_conv4

cd /d "%proot%"

if %commonjunc%==ok goto kore2
call :ask_yesno "%str_kore2%"

if %choi% == 2 goto end_kore2

:kore2

call :juncopy jc_kore "..\Kontakt5" "kore5" "%CommonProgramFiles%\Native Instruments\Shared Content\Sounds" "Kontakt 5"

:end_kore2

md "%CommonProgramFiles%\Native Instruments\Service Center"
echo f|xcopy /h /r /y "%tools%\Kontakt 5.xml" "%CommonProgramFiles%\Native Instruments\Service Center\Kontakt 5.xml"

regedit /s "%tools%\Kontakt.reg"
regedit /s "%tools%\sc.reg"

reg add "hklm\SOFTWARE\Native Instruments\Kontakt HD Edition" /v InstallVSTDIR /t reg_sz /d "%vstpath%" /f

reg add "hkcu\SOFTWARE\Native Instruments\Kontakt" /v InstallDIR /t reg_sz /d "%iroot%\Kontakt153" /f
reg add "hkcu\SOFTWARE\Native Instruments\Kontakt" /v InstallVSTDIR /t reg_sz /d "%vstpath%\Kontakt 1-2" /f

reg add "%lms%\Native Instruments\Kontakt2" /v InstallDir /t reg_sz /d "%iroot%\Kontakt2" /f
reg add "%lms%\Native Instruments\Kontakt2" /v InstallVSTDIR /t reg_sz /d "%vstpath%\Kontakt 1-2" /f

reg add "%lms%\Native Instruments\Kontakt2" /v SNO /t reg_sz /d "28997-70793-13884-88904-77409" /f

reg add "%lms%\Native Instruments\Kontakt3" /v InstallDir /t reg_sz /d "%iroot%\kontakt3" /f
reg add "%lms%\Native Instruments\Kontakt3" /v InstallVSTDIR /t reg_sz /d "%vstpath%\Kontakt 3.5" /f
reg add "%lms%\Native Instruments\Kontakt3" /v InstallRTASDir /t reg_sz /d "%commonx86%\Digidesign\DAE\Plug-Ins" /f

reg add "hklm\Software\Native Instruments\Kontakt 4" /v InstallRTASDir /t REG_SZ /d "%commonx86%\Digidesign\DAE\Plug-Ins" /f
reg add "hklm\Software\Native Instruments\Kontakt 4" /v InstallDir /t REG_SZ /d "%iroot%\kontakt4" /f
reg add "hklm\Software\Native Instruments\Kontakt 4" /v InstallVSTDir /t REG_SZ /d "%vstpath%\Kontakt 4" /f

reg add "hklm\Software\Native Instruments\Kontakt 5" /v InstallAAXDir /t REG_SZ /d "%commonx86%\Avid\Audio\Plug-Ins" /f
reg add "hklm\Software\Native Instruments\Kontakt 5" /v InstallRTASDir /t REG_SZ /d "%commonx86%\Digidesign\DAE\Plug-Ins" /f
reg add "hklm\Software\Native Instruments\Kontakt 5" /v InstallDir /t REG_SZ /d "%iroot%\kontakt5" /f
reg add "hklm\Software\Native Instruments\Kontakt 5" /v InstallVSTDir /t REG_SZ /d "%vstpath%\Kontakt 5" /f

reg add "%lms%\East West\WordBuilder" /v Serial /t reg_sz /d "WBAMA-EF162-MFXD8-B553P-33UIF" /f
reg add "%lms%\East West\WordBuilder" /v Location /t reg_sz /d "%iroot%\SymphonicChoirs\WordBuilder\\" /f

reg add "%lms%\Cakewalk Music Software\MIDI Filters\{CBFF562F-0D67-4B5D-B0E0-9E92A71049FE}" /f

reg add "hklm\Software\East West\WordBuilder" /v Serial /t reg_sz /d "WBAMA-EF162-MFXD8-B553P-33UIF" /f
reg add "hklm\Software\East West\WordBuilder" /v Location /t reg_sz /d "%iroot%\SymphonicChoirs\WordBuilder\\" /f

reg add "hklm\Software\Cakewalk Music Software\MIDI Filters\{CBFF562F-0D67-4B5D-B0E0-9E92A71049FE}" /f

md "%commonx86%\Steinberg"
md "%commonx86%\Steinberg\Shared Components"
copy "..\SymphonicChoirs\WordBuilder\WordBuilderVST.dll" "%commonx86%\Steinberg\Shared Components\WordBuilderVST.dll"

regsvr32 /s "..\SymphonicChoirs\WordBuilder\WordBuilderMFX.dll"

if %choi64%==3 goto askdxi

reg add "hklm\SOFTWARE\Native Instruments\Kontakt HD Edition" /v InstallVST64DIR /t reg_sz /d "%vst64path%" /f

reg add "%lms%\Native Instruments\Kontakt3" /v InstallVST64DIR /t reg_sz /d "%vst64path%\Kontakt 3.5" /f

reg add "hklm\Software\Native Instruments\Kontakt 4" /v InstallVST64Dir /t REG_SZ /d "%vst64path%\Kontakt 4" /f

reg add "hklm\Software\Native Instruments\Kontakt 5" /v InstallVST64Dir /t REG_SZ /d "%vst64path%\Kontakt 5" /f

:askdxi

REM call :ask_yesno "%str_installdxi%"
set choi=1

if %choi% == 2 ( set iu=/u /s ) else set iu=/s

regsvr32 %iu% "..\SymphonicChoirs\SymphonicChoirsDXi.dll"

if %k12_needed%==false goto register

regsvr32 %iu% "..\kontakt\Kontakt 1.53 DXi.dll"
FOR %%i in (..\kontakt2\*.dll) do regsvr32 %iu% "%%i"

:register

if "x86"=="%PROCESSOR_ARCHITECTURE%" goto registerx86

start "vc64" "%tools%\vcredist_x64.exe" /quiet /norestart

:registerx86
start "vc86" "%tools%\vcredist_x86.exe" /quiet /norestart
start "kg" "%tools%\Kontakt 2.0.2 Keygen.exe"
start "scrt" "%tools%\scrt.exe"

if %k12_needed%==false goto registerx86_end

start "reg1.53" "%tools%\KontaktRegistrationTool.exe"
start "reg2.x" "%tools%\Registration Tool.exe"

:registerx86_end

call :exit true false

:readme
start https://github.com/eviluess/kontakt_hd/wiki/Native-Instruments-Kontakt-with-SymphonicChoirs-HD-Edition-for-Windows
start explorer "%tools%\."
start notepad "%tools%\readme.txt"
call :exit false false

:regtool
start "kg" "%tools%\Kontakt 2.0.2 Keygen.exe"
call :exit false false

:uninstall

if %1==return goto skip_search

FOR /F "%skip% tokens=2*" %%i IN ('@reg query "hklm\SOFTWARE\Native Instruments\Kontakt HD Edition" /v InstallVSTDir') DO (
 set vstpath=%%j%
)

FOR /F "%skip% tokens=2*" %%i IN ('@reg query "hklm\SOFTWARE\Native Instruments\Kontakt HD Edition" /v InstallVST64Dir') DO (
 set vst64path=%%j%
)

if "%vst64path%"=="" (set choi64=3) else (set choi64=2)

set choi64=2

if "%vstpath%"=="" call :getpaths

:skip_search

cd /d "%proot%"

rd /q /s "..\UpdateFiles"

rd "%vstpath%\Kontakt 1-2"
rd /q /s "%vstpath%\Kontakt 1-2"

rd "%vstpath%\SymphonicChoirs"
rd /q /s "%vstpath%\SymphonicChoirs"

rd "%vstpath%\Kontakt 3.5"
rd /q /s "%vstpath%\Kontakt 3.5"

rd "%vstpath%\Kontakt 4"
rd /q /s "%vstpath%\Kontakt 4"

rd "%vstpath%\Kontakt 5"
rd /q /s "%vstpath%\Kontakt 5"

rd "%vstpath%\Kontakt ON"
rd /q /s "%vstpath%\Kontakt ON"

rd "%CommonProgramFiles%\Native Instruments\Shared Content\Sounds\Kontakt 4"
rd /q /s "%CommonProgramFiles%\Native Instruments\Shared Content\Sounds\Kontakt 4"

rd "%CommonProgramFiles%\Native Instruments\Shared Content\Sounds\Kontakt 5"
rd /q /s "%CommonProgramFiles%\Native Instruments\Shared Content\Sounds\Kontakt 5"

:remove_lagacy_versions
del /q /f /s "%vstpath%\Native Instruments\kontakt*.*"
rd "%vstpath%\Native Instruments"

if %choi64%==3 goto undxi

rd "%vst64path%\Kontakt 3.5"
rd /q /s "%vst64path%\Kontakt 3.5"

rd "%vst64path%\Kontakt 4"
rd /q /s "%vst64path%\Kontakt 4"

rd "%vst64path%\Kontakt 5"
rd /q /s "%vst64path%\Kontakt 5"

:undxi

regsvr32 /u /s "..\kontakt\Kontakt 1.53 DXi.dll"
FOR %%i in (..\kontakt2\*.dll) do regsvr32 /u /s "%%i"

regsvr32 /u /s "..\SymphonicChoirs\WordBuilder\WordBuilderMFX.dll"

rd /q /s "%USERPROFILE%\Local Settings\Application Data\Native Instruments\Kontakt 3"

rd ..\Kontakt3\common\presets\effects\convolution
rd "%commonx86%\Native Instruments\Kontakt 3"
rd /q /s "%commonx86%\Native Instruments\Kontakt 3"

del /q /f "%commonx86%\Digidesign\DAE\Plug-Ins\Kontakt 3.dpm"

reg delete "hkcu\SOFTWARE\Native Instruments\Kontakt" /f
reg delete "hkcu\SOFTWARE\Native Instruments\Kontakt2" /f
reg delete "hkcu\SOFTWARE\Native Instruments\Kontakt3" /f

reg delete "%lms%\Native Instruments\Kontakt2" /f
reg delete "%lms%\Native Instruments\Kontakt3" /f

rd /q /s "%USERPROFILE%\Local Settings\Application Data\Native Instruments\Kontakt 4"
rd /q /s "%USERPROFILE%\Local Settings\Application Data\Native Instruments\Kontakt 5"

rd ..\Kontakt4\common\presets\effects\convolution
rd ..\Kontakt5\common\presets\effects\convolution

rd ..\Kontakt5\common\presets\Scripts\HD-Edition
xcopy /s /h /r /y /i ..\Kontakt5\common\presets\Scripts\HD-Edition\*.* ..\Packages\Scripts\*.*
rd /q /s ..\Kontakt5\common\presets\Scripts\HD-Edition

rd ..\Kontakt5\common\presets\Multiscripts\HD-Edition
xcopy /s /h /r /y /i ..\Kontakt5\common\presets\Multiscripts\HD-Edition\*.* ..\Packages\Multiscripts\*.*
rd /q /s ..\Kontakt5\common\presets\Multiscripts\HD-Edition


rd "%CommonProgramFiles%\Native Instruments\Kontakt 4"
rd /q /s "%CommonProgramFiles%\Native Instruments\Kontakt 4"

rd "%CommonProgramFiles%\Native Instruments\Kontakt 5"
rd /q /s "%CommonProgramFiles%\Native Instruments\Kontakt 5"

del /q /f "%commonx86%\Digidesign\DAE\Plug-Ins\Kontakt 4.dpm"
del /q /f "%commonx86%\Digidesign\DAE\Plug-Ins\Kontakt 5.dpm"

del /q /f "%commonx86%\Steinberg\Shared Components\WordBuilderVST.dll"

rd "%commonx86%\Avid\Audio\Plug-Ins\Kontakt 5.aaxplugin"
rd /q /s "%commonx86%\Avid\Audio\Plug-Ins\Kontakt 5.aaxplugin"
rd "%CommonProgramFiles%\Avid\Audio\Plug-Ins\Kontakt 5.aaxplugin"
rd /q /s "%CommonProgramFiles%\Avid\Audio\Plug-Ins\Kontakt 5.aaxplugin"


rd /q /s "..\Kontakt2\KConvert Logs"
rd /q /s "..\Kontakt2\KConvert Temp"
rd /q /s "..\Kontakt2\Temporary Conversions"
rd /q /s "..\Kontakt2\UndoBuffers"

del /q /f "..\Kontakt2\QuickAccess.db"

reg delete "hkcu\SOFTWARE\Native Instruments\Kontakt 4" /f
reg delete "hklm\SOFTWARE\Native Instruments\Kontakt 4" /f

reg delete "hkcu\SOFTWARE\Native Instruments\Kontakt 5" /f
reg delete "hklm\SOFTWARE\Native Instruments\Kontakt 5" /f

reg delete "%lms%\East West\WordBuilder" /f
reg delete "%lms%\Cakewalk Music Software\MIDI Filters\{CBFF562F-0D67-4B5D-B0E0-9E92A71049FE}" /f

reg delete "hklm\Software\East West\WordBuilder" /f
reg delete "hklm\Software\Cakewalk Music Software\MIDI Filters\{CBFF562F-0D67-4B5D-B0E0-9E92A71049FE}" /f

rd "%CommonProgramFiles%\Native Instruments\Shared Content\Sounds\Kontakt 4"
rd "%CommonProgramFiles%\Native Instruments\Shared Content\Sounds"
rd "%CommonProgramFiles%\Native Instruments\Shared Content"

rd "%CommonProgramFiles%\Native Instruments"
rd "%commonx86%\Native Instruments"

if %1==return goto :eof

rd "%vst64path%"
rd "%vstpath%"

reg delete "hklm\SOFTWARE\Native Instruments\Kontakt HD Edition" /f

if not exist "%sys32%\NI_DFD_1_2_9.dll" goto uninstall_continue 

call :ask_yesno "%str_keepdfd%" 

if not %choi%==2 goto uninstall_continue

del /q /f "%sys32%\kconvert.dll"
del /q /f "%sys32%\NI_DFD_1_2_9.dll"
del /q /f "%sys32%\NI_DFD_1_3_0.dll"
del /q /f "%sys32%\NI_DFD_1_4.dll"
del /q /f "%sys32%\NI_DFD_1_5.dll"
del /q /f "%sys32%\NI_IRC_1_0_3.dll"
del /q /f "%sys32%\NI_IRC_1_1.dll"
del /q /f "%sys32%\NI_IRC_1_2.dll"
del /q /f "%sys32%\REX Shared Library.dll"

:uninstall_continue

if %1==quit call :exit false true

set str_packing=%str_greatpack%

call :pacopy . "..\SymphonicChoirs" "SymphonicChoirs"
call :pacopy . "." "Kontakt 1-2"
call :pacopy . "..\Kontakt3" "common"
call :pacopy . "..\Kontakt5" "common"
call :pacopy . "..\Kontakt3" "VST32"
call :pacopy . "..\Kontakt3" "VST64"
call :pacopy . "..\Kontakt4" "VST32"
call :pacopy . "..\Kontakt4" "VST64"
call :pacopy . "..\Kontakt5" "VST32"
call :pacopy . "..\Kontakt5" "VST32XP"
call :pacopy . "..\Kontakt5" "VST64"
call :pacopy . "..\Kontakt5" "convolution" 
call :pacopy . "..\Kontakt5" "kore2" 

call :exit false true

:fillvstpaths

if %3==add goto fvp_add
if %3==md goto fvp_md
if %3==kontakt goto fvp_k

if not exist %1 goto :eof

cd /d %1

goto fvp_kd

:fvp_add

set /a idx+=1
set vstpaths%idx%=%~1
set vstpathtypes%idx%=%~2
goto :eof

:fvp_md

md %1

if not exist %1 goto :eof

set /a idx+=1
set vstpaths%idx%=%~1
set vstpathtypes%idx%=%~2

if exist "%~1\*.dll" set vstpathtypes%idx%=%~2%str_recommended%
if exist "%~1\Native Instruments" set vstpathtypes%idx%=%~2%str_recommended%
if exist "%~1\Kontakt*" set vstpathtypes%idx%=%~2%str_recommended%

goto :eof


:fvp_k

if exist "%~1\Kontakt*.dll" goto fvp_kf

cd /d %1
cd ..

:fvp_kd

set /a fvp_kp=1

if exist "%cd%\Native Instruments" goto fvp_kcd
if exist "%cd%\Kontakt*" goto fvp_kcd
if exist "%cd%\*.dll" goto fvp_kcd

goto :eof

:fvp_kcd

set /a idx+=%fvp_kp%
set /a fvp_kp=0
set vstpaths%idx%=%cd%
set vstpathtypes%idx%=%~2%str_recommended%

goto :eof

:fvp_kf

set /a idx+=1
set vstpaths%idx%=%~1
set vstpathtypes%idx%=%~2%str_recommended%

cd /d %1
cd ..

if exist "%cd%\Native Instruments" set vstpaths%idx%=%cd%
if exist "%cd%\Kontakt*" set vstpaths%idx%=%cd%

goto :eof


:ask_yesno
cls
echo %~1
echo.
echo.
echo 1.%str_yes%
echo.
echo 2.%str_no%
echo.
echo.
set /p choi=%str_enter12%
goto :eof

:qsel
cls
echo %~1
echo.

set /a qidx=0

:qsel_loop

shift
if "%~1"=="" goto qsel_quit

set /a qidx+=1
echo.
echo %qidx%. %~1

goto qsel_loop

:qsel_quit

echo.
echo.
set /p choi=%str_choose%%qidx%:

goto :eof


:strlen

set str=%~1

set /a result=0

:strlen_next
if not "%str%"=="" (
set /a result+=1
set "str=%str:~1%"
goto strlen_next
)

goto :eof

:cnvtch

ren %1 t
ren t %1

goto :eof

REM exit pack clean_temp
:exit

start http://eviluess.droppages.com/Applications/PC/Kontakt+HD+Edition

call :nok4u

if %1==false goto exit_no_pack

cd /d %proot%

set str_packing=%str_pack%

call :delaypack jc_k12 "." "Kontakt 1-2"
call :delaypack jc_sc "..\SymphonicChoirs" "SymphonicChoirs"
call :delaypack jc_k3common "..\Kontakt3" "common"
call :delaypack jc_k45common "..\Kontakt5" "common"
call :delaypack jc_k3vst "..\Kontakt3" "VST32"
call :delaypack jc_k3vst64 "..\Kontakt3" "VST64"
call :delaypack jc_k4vst "..\Kontakt4" "VST32"
call :delaypack jc_k4vst64 "..\Kontakt4" "VST64"
call :delaypack jc_k45conv "..\Kontakt5" "convolution"
call :delaypack jc_kore "..\Kontakt5" "kore2"
call :delaypack jc_aax32 "..\Kontakt5" "aax32"
call :delaypack jc_aax64 "..\Kontakt5" "aax64"

:exit_no_pack

if %2==false goto pendmove_temp

rd /q /s "%tools%"

exit

:pendmove_temp
"%tools%\movefile" "%tools%" ""

exit

:nok4u

reg delete "hklm\SOFTWARE\Native Instruments\Kontakt HD Edition" /v k4u /f
reg delete "hklm\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Native Instruments Kontakt 4" /f
reg delete "hklm\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{43E7798A-248E-4A3D-9969-FEA63543A462}" /f
reg delete "hklm\SOFTWARE\Classes\Installer\Products\A8977E34E842D3A49996EF6A53344A26" /f

rem reg delete "hklm\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Native Instruments Kontakt 5" /f
rem reg delete "hklm\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{5552453B-BB76-45E3-973D-F95E458ED780}" /f
rem reg delete "hklm\SOFTWARE\Classes\Installer\Products\B354255567BB3E5479D39FE554E87D08" /f

goto :eof

:juncopy

rd /s /q "%~2\temp"
del /q /f "%~2\temp.7z"

if not "%1"=="." set %1=false

call :testjunc %4 %5

if %jret%==ok goto do_jcpy

:jc_unpack

if not "%1"=="." set %1=false

if exist "%~2\%~3" goto copypack

%uz% "%~2\%~3.7z" -o"%~4\%~5" 
goto :eof

:copypack

xcopy /s /h /r /y /i "%~2\%~3" "%~4\%~5" 

:pack_in_jc
if exist "%~2\%~3.7z" goto rmfolder

if "%1"=="." goto do_pack

set %1=true
goto :eof

:do_pack

cls
echo %str_packing%

%xz% "%~2\temp.7z" "%~2\%~3\*"
ren "%~2\temp.7z" "%~3.7z"

:rmfolder
ren "%~2\%~3" "temp"
rd /s /q "%~2\temp"
goto :eof

:do_jcpy

if exist "%~2\%~3" goto linkdirs

%uz% "%~2\%~3.7z" -o"%~2\temp" 
ren "%~2\temp" "%~3" 

:linkdirs
%jd% "%~4\%~5" "%~2\%~3"
del /q /f "%~2\%~3.7z"

goto :eof


:testjunc

if NOT "%C_DRV%"=="FAT32" goto testjunc_i

:testjunc_i

if NOT "%I_DRV%"=="FAT32" goto testjunc_do

set jret=fail

goto :eof

:testjunc_do

rd "%~1\%~2"
rd /q /s "%~1\%~2"
md %1
%jd% "%~1\%~2" "%tools%"
if exist "%~1\%~2" (set jret=ok) else (set jret=fail)
rd "%~1\%~2"
goto :eof

:pacopy

set %1=false
rd /s /q "%~2\temp"
del /q /f "%~2\temp.7z"

goto pack_in_jc


:jc_keepack

rd "%~3\%~4"
rd /q /s "%~3\%~4"

if exist "%~1\%~2" goto kp_dir

%uz% "%~1\%~2.7z" -o"%~3\%~4" 
goto :eof

:kp_dir
xcopy /s /h /r /y /i "%~1\%~2" "%~3\%~4"  

goto :eof

:recycle4 
rd /q /s "%~3\temp" 
rd /q /s "%~3\tmp" 
xcopy /s /h /r /y /i "%~1\%~2" "%~3\temp" 
ren "%~3\%~4" "tmp"
ren "%~3\temp" "%~4"
rd /q /s "%~3\tmp" 
del /q /f "%~3\%~4.7z"
rd /q /s "%~1\%~2"
goto :eof

:delaypack

if "false"=="!%1!" goto :eof

call :pack_in_jc . %2 %3
goto :eof

:setvar 

if "%~2%"=="" goto readme

set %1=%~2%
goto :eof

