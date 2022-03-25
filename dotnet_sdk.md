# Build and deploy all dotnet core samples

```base
$ sudo apt-get install npm
$ dotnet new --list
Usage: new [options]

Options:
  -h, --help          Displays help for this command.
  -l, --list          Lists templates containing the specified name. If no name is specified, lists all templates.
  -n, --name          The name for the output being created. If no name is specified, the name of the current directory is used.
  -o, --output        Location to place the generated output.
  -i, --install       Installs a source or a template pack.
  -u, --uninstall     Uninstalls a source or a template pack.
  --nuget-source      Specifies a NuGet source to use during install.
  --type              Filters templates based on available types. Predefined values are "project", "item" or "other".
  --dry-run           Displays a summary of what would happen if the given command line were run if it would result in a template creation.
  --force             Forces content to be generated even if it would change existing files.
  -lang, --language   Filters templates based on language and specifies the language of the template to create.
  --update-check      Check the currently installed template packs for updates.
  --update-apply      Check the currently installed template packs for update, and install the updates.


Templates                                         Short Name               Language          Tags
----------------------------------------------------------------------------------------------------------------------------------
Console Application                               console                  [C#], F#, VB      Common/Console
Class library                                     classlib                 [C#], F#, VB      Common/Library
WPF Application                                   wpf                      [C#]              Common/WPF
WPF Class library                                 wpflib                   [C#]              Common/WPF
WPF Custom Control Library                        wpfcustomcontrollib      [C#]              Common/WPF
WPF User Control Library                          wpfusercontrollib        [C#]              Common/WPF
Windows Forms (WinForms) Application              winforms                 [C#]              Common/WinForms
Windows Forms (WinForms) Class library            winformslib              [C#]              Common/WinForms
Worker Service                                    worker                   [C#]              Common/Worker/Web
Unit Test Project                                 mstest                   [C#], F#, VB      Test/MSTest
NUnit 3 Test Project                              nunit                    [C#], F#, VB      Test/NUnit
NUnit 3 Test Item                                 nunit-test               [C#], F#, VB      Test/NUnit
xUnit Test Project                                xunit                    [C#], F#, VB      Test/xUnit
Razor Component                                   razorcomponent           [C#]              Web/ASP.NET
Razor Page                                        page                     [C#]              Web/ASP.NET
MVC ViewImports                                   viewimports              [C#]              Web/ASP.NET
MVC ViewStart                                     viewstart                [C#]              Web/ASP.NET
Blazor Server App                                 blazorserver             [C#]              Web/Blazor
ASP.NET Core Empty                                web                      [C#], F#          Web/Empty
ASP.NET Core Web App (Model-View-Controller)      mvc                      [C#], F#          Web/MVC
ASP.NET Core Web App                              webapp                   [C#]              Web/MVC/Razor Pages
ASP.NET Core with Angular                         angular                  [C#]              Web/MVC/SPA
ASP.NET Core with React.js                        react                    [C#]              Web/MVC/SPA
ASP.NET Core with React.js and Redux              reactredux               [C#]              Web/MVC/SPA
Razor Class Library                               razorclasslib            [C#]              Web/Razor/Library/Razor Class Library
ASP.NET Core Web API                              webapi                   [C#], F#          Web/WebAPI
ASP.NET Core gRPC Service                         grpc                     [C#]              Web/gRPC
dotnet gitignore file                             gitignore                                  Config
global.json file                                  globaljson                                 Config
NuGet Config                                      nugetconfig                                Config
Dotnet local tool manifest file                   tool-manifest                              Config
Web Config                                        webconfig                                  Config
Solution File                                     sln                                        Solution
Protocol Buffer File                              proto                                      Web/gRPC

```

```base
#!/bin/sh

SDK_SAMPLE="console classlib wpf wpflib wpfcustomcontrollib wpfusercontrollib winforms winformslib worker mstest nunit nunit-test xunit razorcomponent page viewimports viewstart blazorserver web mvc webapp angular react reactredux razorclasslib webapi grpc gitignore globaljson nugetconfig tool-manifest webconfig sln proto"

for i in $SDK_SAMPLE; do
  prj_folder=$i"_x64"
  if [ -d "$prj_folder" ]; then rm -rf $prj_folder;  fi
done

PATH_CUR=`pwd`
ERROR_FILE="dotnet_sdk.txt"
echo "dotnet core sdk testing...."
for i in $SDK_SAMPLE; do
  prj_folder=$i"_x64"
  echo "==========================="
  echo "dotnet new $i -o $i"
  dotnet new $i -o $prj_folder
  cd $prj_folder
  echo `pwd`
  dotnet build
  dotnet publish -c Release -r linux-arm64 --self-contained
  echo "==========================="
  cd $PATH_CURT
done
```

## All samples testing status

|**sample**|**Description**|***x64_ubuntu20.04***|***arm64_ma35d1***|
|-|-|-|-|
|console  | Print Hello world on console | OK | OK |
|classlib | | library | |
|wpf, wpflib, wpfcustomcontrollib, wpfusercontrollib | | error NETSDK1100: Windows is required to build Windows desktop applications. | |
|winforms, winformslib | | error NETSDK1100: Windows is required to build Windows desktop applications. | |
|worker | Worker Service (Print timestamp) | OK | OK |
|mstest | | OK | OK |
|nunit | | Not a executable | |
|nunit-test | | Not a executable |  |
|xunit | | Not a executable | |
|razorcomponent | | Not a executable. | |
|page | | Not a executable. | |
|viewimports | | Not a executable | |
|viewstart | | Not a executable | |
|blazorserver | | OK | OK |
|web  | HTTP Server | OK | OK |
|mvc  | Model-View-Controller (MVC) architectural | OK | OK |
|webapp  | HTTP Server | OK | OK |
|angular  | | OK | OK |
|react   | | OK | OK |
|reactredux | | OK  | OK |
|webapi | HTTP Server | OK | OK |
|grpc | language agnostic, high-performance Remote Procedure Call (RPC) framework | OK | OK |
|gitignore   | | Not a executable | |
|globaljson   | | Not a executable | |
|nugetconfig   | | Not a executable | |
|tool-manifest   | | Not a executable | |
|webconfig   | | Not a executable | |
|sln   | | Not a executable | |
|proto  | | Not a executable | |
