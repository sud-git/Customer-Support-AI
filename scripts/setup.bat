@echo off
REM SFDX Setup Script for Customer Support AI Project (Windows)
REM This script automates the initial setup of the project

echo =========================================
echo Customer Support AI - SFDX Setup
echo =========================================
echo.

REM Check if SFDX CLI is installed
where sfdx >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Salesforce CLI (SFDX) is not installed.
    echo Please install it from: https://developer.salesforce.com/tools/sfdxcli
    pause
    exit /b 1
)

echo ✅ SFDX CLI found
echo.

REM Display current directory
echo 📁 Project Directory: %CD%
echo.

REM Check for sfdx-project.json
if not exist "sfdx-project.json" (
    echo ❌ sfdx-project.json not found!
    pause
    exit /b 1
)

echo ✅ Project configuration found
echo.

REM Step 1: Authorize Org
echo Step 1: Authorize Your Salesforce Org
echo ===========================================
set /p ORG_ALIAS="Enter org alias (e.g., MyOrg, MySandbox): "

if "%ORG_ALIAS%"=="" (
    set ORG_ALIAS=MyOrg
)

set /p IS_SANDBOX="Is this a Sandbox? (y/n): "

if "%IS_SANDBOX%"=="y" (
    set INSTANCE_URL=https://test.salesforce.com
) else (
    set INSTANCE_URL=https://login.salesforce.com
)

echo.
echo ⏳ Authorizing %ORG_ALIAS% at %INSTANCE_URL%...
call sfdx force:auth:web:login --setalias %ORG_ALIAS% --instanceurl %INSTANCE_URL%

if %ERRORLEVEL% NEQ 0 (
    echo ❌ Authorization failed!
    pause
    exit /b 1
)

echo ✅ Authorization successful
echo.

REM Step 2: Set Default Org
echo Step 2: Setting Default Org
echo ===========================================
call sfdx config:set defaultusername=%ORG_ALIAS%
echo ✅ Default org set to: %ORG_ALIAS%
echo.

REM Step 3: Verify Connection
echo Step 3: Verifying Connection
echo ===========================================
call sfdx force:org:display --targetusername=%ORG_ALIAS%
echo.

REM Step 4: Deploy Project
echo Step 4: Deploying Project to Salesforce
echo ===========================================
set /p DEPLOY="Deploy now? (y/n): "

if "%DEPLOY%"=="y" (
    echo ⏳ Deploying source to %ORG_ALIAS%...
    call sfdx force:source:push --verbose --targetusername=%ORG_ALIAS%
    
    if %ERRORLEVEL% EQU 0 (
        echo ✅ Deployment successful!
    ) else (
        echo ⚠️  Deployment had issues. Check the output above.
    )
) else (
    echo ℹ️  Skipped deployment. To deploy later, run:
    echo    sfdx force:source:push --targetusername=%ORG_ALIAS%
)

echo.
echo =========================================
echo Setup Complete!
echo =========================================
echo.
echo Next steps:
echo 1. Open your org: sfdx force:org:open --targetusername=%ORG_ALIAS%
echo 2. Check custom objects in Setup ^> Object Manager
echo 3. Create new Lightning App for support team
echo.
pause
