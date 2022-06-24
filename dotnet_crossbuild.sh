#!/bin/sh

#SDK_SAMPLE="console classlib wpf wpflib wpfcustomcontrollib wpfusercontrollib winforms winformslib worker mstest nunit nunit-test xunit razorcomponent page viewimports viewstart blazorserver web mvc webapp angular react reactredux razorclasslib webapi grpc gitignore globaljson nugetconfig tool-manifest webconfig sln proto"

SDK_SAMPLE="console worker mstest nunit nunit-test xunit web mvc webapp webapi grpc"

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
	dotnet build
	dotnet publish -c Release -r linux-arm64 --self-contained
	echo "==========================="
	cd $PATH_CURT
done

