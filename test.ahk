imageDir := A_ScriptDir
image     = %imageDir%\earth-img.jpg
If !FileExist(image)
 URLDownloadToFile, % "http://upload.wikimedia.org/wikipedia/commons/thumb/9/97/"
                    . "The_Earth_seen_from_Apollo_17.jpg/1023px-The_Earth_seen_from_Apollo_17.jpg"
                    , %image%
vert     := 305
lat      := 566
size     := imgSize(image).w
dist     := 8
Gui, Color, 0
Gui, Add, Picture, x%lat% y%vert% w%size% h-1, %image%
Gui, Show, w1375 h850, Move the Earth
size := 240
RedrawImage:
GuiControl, MoveDraw, Static1, x%lat% y%vert% w100 h100
Return

GuiEscape:
ExitApp

imgSize(img) { ; https://www.autohotkey.com/boards/viewtopic.php?f=76&t=81665
 ; Returns an array indicating the image's width (w) and height (h), obtained from the file's properties
 SplitPath, img, fn, dir
 objShell := ComObjCreate("Shell.Application")
 objFolder := objShell.NameSpace(dir), objFolderItem := objFolder.ParseName(fn)
 scale := StrSplit(RegExReplace(objFolder.GetDetailsOf(objFolderItem, 31), ".(.+).", "$1"), " x ")
 Return {w: scale.1, h: scale.2}
}