#include "..\String Constants.hpp"

class BLWK_waveTypes
{
    class normalWaves
    {
        class standardWave
        {
            // uncompiled code that is run on the server when the wave is selected (started). 
            // For context of execution see BLWK_fnc_startWave's use of BLWK_fnc_getConfigForWave
            // onSelected = "remoteExecCall ['BLWK_fnc_handleStandardWave',BLWK_theAIHandlerOwnerID]";
            
            generateMenClassnames = "BLWK_fnc_standardWave_generateMenClassnames";
            generateManSpawnPosition = "BLWK_fnc_standardWave_generateManSpawnPosition";

            // The name of a function that exists on the AI handler owner that will be called
            onWaveInit = "BLWK_fnc_standardWave_onWaveInit";
            onManCreated = "BLWK_fnc_standardWave_onManCreated";
            
            // uncompiled code that is run on the server when the wave is ended
            //onWaveEnd = ""; 
            
            // a CfgNotification template for when the wave starts
            creationNotificationTemplate = TASK_ASSIGNED_TEMPLATE; 
            
            // "notificationText" is text to appear in wave start notification
            notificationText = "['','Incoming Wave: ' + (str BLWK_currentWaveNumber)]"; 
            
            // whether notificationText will be compiled and called or not. 
            // It must return an array compatible with the "arguments" parameter of BIS_fnc_showNotification
            compileNotificationText = 1; 

            // A missionNamespace variable that is available on the server and must evaluate to a number
            // This will determine the likelihood (relative to other normal waves) that it is created on any given wave
            weightVariable = "BLWK_standardWaveWeight";
        };
        class paratrooperWave : standardWave
        {
            onSelected = "remoteExecCall ['BLWK_fnc_handleParatrooperWave',BLWK_theAIHandlerOwnerID]";
            weightVariable = "BLWK_paratrooperWaveWeight";
        };
        class defectorWave : standardWave
        {
            onSelected = "remoteExecCall ['BLWK_fnc_handleDefectorWave',BLWK_theAIHandlerOwnerID]";
            weightVariable = "BLWK_defectorWaveWeight";
        };
    };

    class specialWaves
    {
        class suicideWave
        {
            onSelected = "remoteExecCall ['BLWK_fnc_handleSuicideWave',BLWK_theAIHandlerOwnerID]";
            creationNotificationTemplate = SPECIAL_WARNING_TEMPLATE;
            notificationText = "Enemy Suicide Bombers Are Incoming!";
            // The "toggleVariable" is a name of a missionNamespace variable (on the server) 
            // that can be set to true or false to toggle the ability to have the wave 
            // (likely paired with a KISKA parameter menu mission param)
            toggleVariable = "BLWK_allowSuicideWave"; 
        };
        class civilianWave : suicideWave
        {
            onSelected = "remoteExecCall ['BLWK_fnc_handleStandardWave',BLWK_theAIHandlerOwnerID]; call BLWK_fnc_civiliansWave";
            notificationText = "Civilians Are Fleeing, Watch Your Fire!";
            onWaveEnd = "call BLWK_fnc_onCivWaveEnd";
            toggleVariable = "BLWK_allowCivWave";
        };
        class droneWave : suicideWave
        {
            onSelected = "remoteExecCall ['BLWK_fnc_handleDroneWave',BLWK_theAIHandlerOwnerID]";
            notificationText = "Enemy Drones Inbound!";
            onWaveEnd = "call BLWK_fnc_onDroneWaveEnd";
            toggleVariable = "BLWK_allowDroneWave";
        };
        class overrunWave : suicideWave
        {
            onSelected = "remoteExecCall ['BLWK_fnc_handleOverrunWave',BLWK_theAIHandlerOwnerID]";
            notificationText = "The Area Was Overrun!";
            toggleVariable = "BLWK_allowOverrunWave";
        };
        class heliWave : suicideWave
        {
            onSelected = "remoteExecCall ['BLWK_fnc_handleHelicopterWave',BLWK_theAIHandlerOwnerID]";
            notificationText = "Enemy Helicopters Inbound!";
            toggleVariable = "BLWK_allowHeliWave";
        };
        class mortarWave : suicideWave
        {
            onSelected = "remoteExecCall ['BLWK_fnc_handleMortarWave',BLWK_theAIHandlerOwnerID]";
            notificationText = "Incoming Mortar Fire!";
            toggleVariable = "BLWK_allowMortarWave";
        };
    };
};
