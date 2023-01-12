** Prova utilizzando il NetBridge di Arca
Local oBridge As wwDotnetBridge
Local cDllPath;
    , cPathBridge;
    , cRetVal;
    , oDll;
    , oDll4Async


cDllPath = "F:\Progetti_CSharp\xTestNetBridgeArca\xTestNetBridgeArca\bin\Debug\xTestNetBridgeArca.dll" && Impostare la path della dll costruita!

** Prova utilizzando il NetBridge di WKI

** Lanciare i due metodi commetando prima l'altro.
*!*    oDll = oApp.Netbridge.CreateInstanceFromFile0(cDllPath,"xTestNetBridgeArca.Programma")
*!*    cRetVal = oDll.HelloWorldAsync4VFP()
*!*    MESSAGEBOX(cRetVal)

** Prova utilizzando il wwDotNetBridge
** Scaricarlo da: https://github.com/RickStrahl/wwDotnetBridge
** Chiamando il metodo direttamente anche da wwDotNetBridge questo provvoca la stessa cosa del bridge di WKI!
** Qui faremo una prova di chiamare il metodo in modalità asincrona


** Metodo con wwDotNetBridge

** L'oggetto di Callback deve essere pubblico!
PUBLIC oCallback

** Sistemare la path con quella corretta dove si trova il bridge!
SET PATH TO "F:\Dev\3_2022\Pers\Demo\User1\" ADDITIVE 

DO "wwDotnetBridge"

oBridge = GetwwDotnetBridge("V4")

oBridge.Loadassembly(cDllPath)
oDll4Async = oBridge.CreateInstance("xTestNetBridgeArca.Programma")

oCallback = CREATEOBJECT("MyCallback")

oBridge.InvokeMethodAsync(oCallback,oDll4Async,"HelloWorldAsync4VFP")

DECLARE Sleep IN WIN32API INTEGER 

** Attesa della risposta prima di continuare!
DO WHILE !oCallback.IsCompleted
    Sleep(0)
    LOOP
ENDDO

MESSAGEBOX(oCallback.RetVal)

DEFINE CLASS MyCallback as Custom
    IsCompleted = .F.
    RetVal = null

    FUNCTION OnCompleted(vResult, lcMethod)
        This.IsCompleted = .T.
        This.Retval = vResult

    ENDFUNC

    FUNCTION OnError(lcErrorMessage, loException, lcMethod)

    ENDFUNC
ENDDEFINE

   