@echo off
color 5F
mode con:cols=94
set title=Wi-Fi HotSpot^! [W.H]
set version=[wfhots.bat 4.08102017] [W.H]
set pathBat=C:\Progra~1\wfhots
setlocal EnableDelayedExpansion
md %pathBat% & cd %pathBat%
call :update
title %title%
cls
echo.
echo.
echo                             ██                                              ██████  made by
echo                             ██                                              ██████   [W.H]
echo                             ██                                              ██████
echo                             ██                                               ████
echo     ██      ██  ██████████  ████████    ██████████  ██████████  ██████████   ████
echo     ██  ██  ██  ██████  ██  ██████████  ██████████  ██████████  ██████  ██   ████
echo     ██████  ██  ████        ██████████  ██  ██  ██  ██████  ██  ████          ██
echo     ██████████  ██████      ████    ██  ██      ██  ██  ██  ██  ██████████    ██
echo     ██████████  ██          ██      ██  ██    ████      ██            ████      
echo       ██  ██    ██          ██      ██  ██████████      ██      ██████████    ██
echo.
echo.
::sc start W32Time| findstr /i "1056"
WHOAMI /PRIV | find /i "SeRemoteShutdownPrivilege"
if not %ERRORLEVEL%==0 (
echo     Внимание^^! Запустите программу от имени администратора^^!
echo     Attention^^! Run program as administrator^^!
echo.
pause && exit /b
)
cls

:language
::========menu========
set m_choice=Выберите действие
set m_uchoice=Ваш выбор
set m_back=Вернуться назад
::=======hotspot======
set hotspot=Главное меню
set h_stati=Просмотреть статистику
set stati1=Информация о размещенной сети и о безопасности.
set stati2=Настройки беспроводной сети.
set h_addse=Мастер настройки
set addse1=Мастер настройки
set addse2=Введите название точки доступа
set addse3=SSID введено.
set addse4=Внимание. Пароль должен содержать минимум 8 знаков^^!
set addse5=Введите пароль
set manua0=Мастер настройки может проговорить вам дальнейшие действия голосом.
set manua1=Инструкция по перенаправлению интернета на хост Wi-Fi.
set manua2=Найдите в панели управления "Сетевые подключения".
set manua3=В окне найдите источник вашего интернета и войдите в Свойства.
set manua4=Далее вкладка "Доступ", поставте все галочки.
set manua5=Выберите ниже в списке "беспроводная сеть(2)". ОК.
set h_start=Запустить
set h_resta=Перезапустить
set h_stopp=Остановить
set h_setti=Настройки
set h_netse=Сетевые настройки
set h_abaut=О программе...
set h_toolb=Приложения
::======settings======
set settings=Настройки
set s_cname=Изменить название
set s_cpass=Изменить пароль
set s_pathb=Открыть папку программы
set s_insta=Установить программу
set s_unins=Удалить программу
set unins1=Вы точно хотите удалить программу wfhots^?
::==network-settings==
set network-settings=Сетевые настройки
set n_netse=Сетевые настройки
set netsh1=Network Shell - конфигурирование сетевых параметров.
set n_chaip=Изменить IP-адрес
set n_showi=Просмотр состояния интерфейсов
set n_editi=Изменение состояния интерфейсов
set editi1=Изменить состояние интерфейса.
set editi2=Введите название интерфейса
set editi3=Введите
set n_netsh=Network Shell (netsh)
set n_helpm=Помощь (netsh)
::======edit-ip=======
set edit-ip=Изменить IP-адрес
set e_autoi=Автоматичесое получение IP-адреса
set autoi1=Введите название интерфейса
set e_write=Ввести значение IP-адреса
set write1=Введите название интерфейса
set write2=Введите IP-адрес
set write3=Введите маску подсети
set write4=Введите шлюз
set write5=Введите DNS
set e_stati=Использовать IP из конфига.
set e_confi=Редактировать конфиг файл
::====================
goto hotspot
cls & goto language
:hotspot
title %title% - %hotspot%
echo.
echo  %version%
echo.
echo ===== %hotspot% =====
echo  SSID: [ %ssid% ] Key: [ %key% ]
echo.
echo  %m_choice%:
echo   1 - %h_stati%
echo   2 - %h_addse%
echo   3 - %h_start%
echo   4 - %h_resta%
echo   5 - %h_stopp%
echo   6 - %h_setti%
echo   7 - %h_netse%
echo   8 - %h_abaut%
echo   9 - %h_toolb%
echo.
Set /p choice="%m_uchoice%: "
if not defined choice goto hotspot

if "%choice%"=="1" ( cls
echo %stati1%
netsh wlan show hostednetwork
netsh wlan show hostednetwork setting=security
pause & cls
)
if "%choice%"=="2" ( cls
title %addse1%
echo.
echo  %m_choice%:
echo   1 - %addse1%
echo.
echo   0 - %m_back%
echo.
set /p addsel_choice="%m_uchoice%: "
if not defined choice goto hotspot
	if "!addsel_choice!"=="1" ( cls
	echo.
	set /P ssid="%addse2%: "
	echo  %addse3%
	echo.
	echo  %addse4%
	set /P key="%addse5%: "
	netsh wlan set hostednetwork mode=allow ssid=!ssid! key=!key!
	netsh wlan stop hostednetwork
	netsh wlan start hostednetwork
	echo !ssid!>info.ini
	echo !key!>>info.ini
	echo !ip!>>info.ini
	echo !mask!>>info.ini
	echo !gateway!>>info.ini
	echo !dns!>>info.ini
	echo !interface!>>info.ini
	cls
	title %manua1%
	echo.
	echo  %manua1%
	echo.
	echo   1. %manua3%
	echo   2. %manua4%
	echo   3. %manua5%
	ncpa.cpl
	echo.
	pause
	netsh wlan stop hostednetwork
	netsh wlan start hostednetwork
	cls
	)
cls & goto hotspot
)
if "%choice%"=="3" ( cls 
netsh wlan set hostednetwork mode=allow ssid="%ssid%" key="%key%"
netsh wlan start hostednetwork )
if "%choice%"=="4" ( cls & netsh wlan stop hostednetwork & netsh wlan start hostednetwork & cls )
if "%choice%"=="5" ( cls & netsh wlan stop hostednetwork & cls )
if "%choice%"=="6" ( cls & goto settings )
if "%choice%"=="7" ( cls & goto network-settings )
if "%choice%"=="8" ( cls
echo. & echo  %version% & echo.
echo  Программа предназначена для поднятия точки доступа wi-fi на устройствах
echo   под Windows 7/8/10. Она открывает возможность использования устройства
echo   как отличную замену роутеру, если его у вас нет, или он потребовался 
echo   вам вне дома. Вы так же можете ретранслировать wi-fi, например, от 
echo   соседей или изменять настройки сети на вашем устройстве.
echo.
echo  Программа свободна в распространении. Помощь по доработке приветствую.
echo  Надеюсь на то, что данная программа будет всем полезна.
echo. & echo.
echo                                                       [welcomehom3@ya.ru]
echo.
pause & cls
)
if "%choice%"=="9" ( cls
start C:\Progra~1\wfhots\toolbox.bat
)
if "%choice%"=="version" ( cls
echo  Version 1 - Wi-Fi Router for Laptop.
echo   1. Программа с меню для ввода названия точки доступа и пароля.
echo  Version 2 - Wi-Fi Hot Spot.
echo   1. Появилось предупреждение "Откройте программу от имени администратора!"
echo   2. Сделана возможность локализации программы.
echo   3. Появилась инструкция.
echo   4. Точку доступа можно перезапустить, остановить.
echo   5. Программу можно установить с введёнными ssid и pass.
echo  Version 3 - wfhots!
echo   1. Изменены консольные цвета и добавлены заголовки.
echo   2. Изменено меню.
echo   3. Добавлен глобальный пункт "Настройки сети".
echo   3.1 Просмотр статистики интерфейсов.
echo   3.2 Доступ к netsh для более гибких действий.
echo   3.3 Изменение IP-адреса.
echo   3.4 Просмотр и изменение состояния интерфейсов.
echo  Version 4.
echo   1. Изменён метод запуска от имени Администратора.
echo   2. Появился пункт меню "Мастер настройки сети".
echo   2.1 Автоматически открывается окно "Сетевые подключения" для удобства.
echo   3. Программа полностью готова к локализации.
echo   4. Сделана установка программы.
echo   4.1 При установке программа добавляется в автозагрузку системы.
echo   5. Программа научилась запоминать введённое значение SSID и Key.
echo   6. В папке source лежат исходники пакетных файлов.
echo   7. Появился пункт меню "Приложения". В него входят программы:
echo   7.1 Dumpper для дополнительных действий с другой точкой доступа.
echo   7.2 Wi-Fi Guard для уведомления о появлении нового устройства в сети.
echo   7.3 Port Scanner для сканирования портов.
echo   7.4 Intercepter-NG для действий с другими устройствами.
echo   7.5 DarkComet-RAT для действий с Windows.
echo   7.6 Crypters для DarkComet-RAT и не только.
echo   7.6.1 editors.exe - архив SFX с редакторами для .exe и от антивирусов.
echo   7.7 MAC Changer для смены MAC-адреса.
echo   7.8 Редактор hosts.
echo   7.9 Редактор списка приложений.

pause & cls
)

cls & goto hotspot
:settings
title %title% - %settings%
echo. & echo  %version% & echo.
echo ===== %hotspot% =====
echo  SSID: [ %ssid% ] Key: [ %key% ]
echo.
echo  %m_choice%:
echo   1 - %s_cname%
echo   2 - %s_cpass%
echo   3 - %s_pathb%
echo   4 - %s_insta%
echo   5 - %s_unins%
echo.
echo   0 - %m_back%
echo.
Set /p choice=" %m_uchoice%: "
if not defined choice goto settings

if "%choice%"=="1" ( cls
title %addse1%
echo.
set /P ssid="%addse2%: "
netsh wlan stop hostednetwork
netsh wlan set hostednetwork mode=allow ssid=!ssid! key=!key!
netsh wlan start hostednetwork
echo !ssid!>info.ini
echo !key!>>info.ini
echo !ip!>>info.ini
echo !mask!>>info.ini
echo !gateway!>>info.ini
echo !dns!>>info.ini
echo !interface!>>info.ini
cls
)
if "%choice%"=="2" ( cls
title %addse1%
echo  %addse4%
set /P key="%addse5%: "
netsh wlan stop hostednetwork
netsh wlan set hostednetwork mode=allow ssid=!ssid! key=!key!
netsh wlan start hostednetwork
echo !ssid!>info.ini
echo !key!>>info.ini
echo !ip!>>info.ini
echo !mask!>>info.ini
echo !gateway!>>info.ini
echo !dns!>>info.ini
echo !interface!>>info.ini
cls
)
if "%choice%"=="3" ( cls
start !pathBat!
)
if "%choice%"=="4" ( cls
setlocal DisableDelayedExpansion
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Wi-Fi HotSpot^!" /t reg_sz /d "C:\Progra~1\wfhots\wfhots_autorun.exe" /f
setlocal EnableDelayedExpansion
)
if "%choice%"=="5" ( cls & echo.
echo %unins1%
RD /S %pathBat%
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Wi-Fi HotSpot^!" /f
)

if "%choice%"=="0" ( cls & goto hotspot )
cls & goto settings
:network-settings
title %title% - %network-settings%
echo. & echo  %version% & echo.
echo  %m_choice%:
echo   1 - %n_netse%
echo   2 - %n_chaip%
echo   3 - %n_showi%
echo   4 - %n_editi%
echo   5 - %n_netsh%
echo   6 - %n_helpm%
echo.
echo   0 - %m_back%
echo.
Set /p choice=" %m_uchoice%: "
if not defined choice goto network-settings

if "%choice%"=="1" ( cls
ipconfig /all
pause
)
if "%choice%"=="2" ( cls
goto edit-ip
)
if "%choice%"=="3" ( cls
netsh interface ip show config
netsh interface ip show interface
pause
)
if "%choice%"=="4" ( cls
netsh interface ip show interface
echo.
echo %editi1%
echo.
set /p nameInterface=%editi2%:
set /p status=%editi3%: ENABLED / DISABLED:
netsh interface set interface name="!nameInterface!" admin=!status!
)
if "%choice%"=="5" ( cls & echo.
echo %netsh1%
echo help exit
netsh
)
if "%choice%"=="6" ( cls
netsh interface ip set help
pause
)

if "%choice%"=="0" ( cls & goto hotspot )
cls & goto network-settings
:edit-ip
title %title% - %edit-ip%
echo. & echo  %version% & echo.
echo  %m_choice%:
echo   1 - %e_autoi%
echo   2 - %e_write%
echo   3 - %e_stati%
echo   4 - %e_confi%
echo.
echo   0 - %m_back%
echo.
Set /p choice=" %m_uchoice%: "
if not defined choice goto edit-ip

if "%choice%"=="1" ( cls
set /p Cinterface=%autoi1%:
netsh interface ip set address "!Cinterface!" dhcp
netsh interface ip set dns "!Cinterface!" dhcp
)
if "%choice%"=="2" ( cls
set /p Cinterface=%write1%: 
set /p Cip=%write2%:
set /p Cmask=%write3%:
set /p Cgateway=%write4%:
set /p Cdns=%write5%:
netsh interface ip set address "!Cinterface!" source=static !Cip! !Cmask! !Cgateway! 1
netsh interface ip set dns "!Cinterface!" source=static !Cdns!
)
if "%choice%"=="3" ( cls
chcp 1251 & cls
call :update
netsh interface ip set address "!interface!" source=static !ip! !mask! !gateway! 1
netsh interface ip set dns "!interface!" static !dns!
chcp 866 & cls
)
if "%choice%"=="4" ( cls
start info.ini
echo.
echo   1 - SSID
echo   2 - Key
echo   3 - IP
echo   4 - Mask
echo   5 - Gateway
echo   6 - DNS
echo   7 - Interface name
echo.
pause
)

if "%choice%"=="0" ( cls & goto network-settings )
cls & goto edit-ip
:update
chcp 1251 & cls
set /a c=0
for /f "UseBackQ Delims=" %%A in (info.ini) do (
set /a c+=1
if !c!==1 set "ssid=%%A"
if !c!==2 set "key=%%A"
if !c!==3 set "ip=%%A"
if !c!==4 set "mask=%%A"
if !c!==5 set "gateway=%%A"
if !c!==6 set "dns=%%A"
if !c!==7 set "interface=%%A"
)
chcp 866 & cls
	exit /b
