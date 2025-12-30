#Requires AutoHotkey v2.0


CONFIG_DIR := 'C:/Users/' . A_UserName . '/.cmd/config.ini'
VERSION := '1.1.2'
BUILT_DATE := '10:10:42 PM, Dec 29, 2025'

adminMenu(*) {
    pwd := InputBox('请输入管理员密码', '管理员面板', 'password')
    if (pwd.Value == IniRead(CONFIG_DIR, 'Main', 'PWD', '123456')) {
        c := '1'
        while (c != '0') {
            c := InputBox('0.关闭快捷命令`n1.打开个人主页`n2.打开游戏站`n3.打开塔防游戏`n4.打开哔哩哔哩`n5.打开自定义网站', '管理员面板', , 'close').Value
            if (c == '0') {
                MsgBox('即将关闭快捷命令...', '信息', 64)
                ExitApp()
            }
            switch (c) {
                case '1':
                    Run 'https://apartkp.pages.dev/'
                case '2':
                    Run 'https://apar.pages.dev/'
                case '3':
                    Run 'https://apakpdemo.netlify.app/t'
                case '4':
                    Run 'https://www.bilibili.com/'
                case '5':
                    Run IniRead(CONFIG_DIR, 'Main', 'CustomSite', 'https://www.example.com')
                default: 
                    break
            }
        }
    } else {
        if (pwd.Result == 'OK')
            MsgBox('密码错误！', '错误', 16)
    }
}

newTask(*) {
    proc := InputBox('请输入要启动的进程名', '启动进程')
    if (proc.Value != '') {
        Run proc
    } else {
        if (proc.Result == 'OK')
            MsgBox('未输入进程名称', '错误', 16)
    }
}

showTips(*) {
    MsgBox('快捷命令 v' . VERSION . ' by ApartKP`n构建日期:' . BUILT_DATE . '`n配置文件目录：' . CONFIG_DIR . '`n从任务栏托盘或管理员面板关闭本程序，也可按Alt+Shift+F静默关闭`n按Alt+Shift+R运行任意程序，按Alt+Shift+K结束任意进程，按Alt+Shift+C打开控制面板，按Alt+Shift+O打开管理员面板', '提示', 64)
}

endTask(*) {
    proc := InputBox('请输入要结束的进程名', '结束进程')
    if (proc.Value != '') {
        ProcessClose(proc.Value)
        MsgBox('已结束进程：' . proc.Value, '信息', 64)
    } else {
        if (proc.Result == 'OK')
            MsgBox('未输入进程名称', '错误', 16)
    }
}

trayMenu := Menu()
trayMenu.Add('管理员面板', adminMenu)
trayMenu.Add('新建进程', newTask)
trayMenu.Add('结束进程', endTask)
trayMenu.Add('提示信息', showTips)

if (!FileExist(CONFIG_DIR)) {
    MsgBox('快捷命令配置文件夹位于：' . CONFIG_DIR . ' 请根据需要修改快捷启动', '信息', 64)
    MsgBox('CustomKey1 对应 Alt+1 快捷键`nCustomKey2 对应 Alt+2 快捷键`nCustomKey3 对应 Alt+3 快捷键...', '信息', 64)
    MsgBox('按Alt+C打开cmd，按Alt+Shift+A打开提示窗口', '信息', 64)
    DirCreate('C:/Users/' . A_UserName . '/.cmd')
    IniWrite('123456', CONFIG_DIR, 'Main', 'PWD')
    IniWrite('https://www.example.com', CONFIG_DIR, 'Main', 'CustomSite')
    IniWrite('calc.exe', CONFIG_DIR, 'Hotkey', 'CustomKey1')
    IniWrite('notepad.exe', CONFIG_DIR, 'Hotkey', 'CustomKey2')
    IniWrite('taskmgr.exe', CONFIG_DIR, 'Hotkey', 'CustomKey3')
    IniWrite('gpedit.msc', CONFIG_DIR, 'Hotkey', 'CustomKey4')
    IniWrite('services.msc', CONFIG_DIR, 'Hotkey', 'CustomKey5')
    IniWrite('osk.exe', CONFIG_DIR, 'Hotkey', 'CustomKey6')
    IniWrite('', CONFIG_DIR, 'Hotkey', 'CustomKey7')
    IniWrite('', CONFIG_DIR, 'Hotkey', 'CustomKey8')
    IniWrite('', CONFIG_DIR, 'Hotkey', 'CustomKey9')
}

MsgBox('程序正在后台运行，可从任务栏托盘或管理员面板退出，也可按Alt+Shift+F静默关闭程序。', '信息', 64)

!+a:: {
    showTips()
}

!+r:: {
    newTask()
}

!+c:: {
    Run 'control.exe'
}

!+k:: {
    endTask()
}

!+o:: {
    adminMenu()
}

!+f:: {
    ExitApp()
}

!c:: {
    Run 'cmd.exe'
}

!1:: {
    app := IniRead(CONFIG_DIR, 'Hotkey', 'CustomKey1', 'calc.exe')
    Run app
}

!2:: {
    app := IniRead(CONFIG_DIR, 'Hotkey', 'CustomKey2', 'notepad.exe')
    Run app
}

!3:: {
    app := IniRead(CONFIG_DIR, 'Hotkey', 'CustomKey3', 'taskmgr.exe')
    Run app
}

!4:: {
    app := IniRead(CONFIG_DIR, 'Hotkey', 'CustomKey4', 'gpedit.msc')
    Run app
}

!5:: {
    app := IniRead(CONFIG_DIR, 'Hotkey', 'CustomKey5', 'services.msc')
    Run app
}

!6:: {
    app := IniRead(CONFIG_DIR, 'Hotkey', 'CustomKey6', 'osk.exe')
    Run app
}

!7:: {
    app := IniRead(CONFIG_DIR, 'Hotkey', 'CustomKey7', '')
    if (app != '') {
        Run app
    }
}

!8:: {
    app := IniRead(CONFIG_DIR, 'Hotkey', 'CustomKey8', '')
    if (app != '') {
        Run app
    }
}

!9:: {
    app := IniRead(CONFIG_DIR, 'Hotkey', 'CustomKey9', '')
    if (app != '') {
        Run app
    }
}