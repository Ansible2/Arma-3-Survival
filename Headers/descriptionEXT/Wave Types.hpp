#include "..\String Constants.hpp"

class BLWK_waveTypes
{
    class normalWaves
    {
        class infantryWave
        {
            onSelected = "remoteExec ['BLWK_fnc_handleStandardWave',BLWK_theAIHandlerOwnerID]"; // uncompiled code that is run on the server when the wave is selected (started). For context of execution see BLWK_fnc_startWave's use of BLWK_fnc_decideWaveType
            //onWaveEnd = ""; // uncompiled code that is run on the server when the wave is ended
            creationNotificationTemplate = TASK_ASSIGNED_TEMPLATE; // a CfgNotification template for when the wave starts
            notificationText = "['','Incoming Wave: ' + (str BLWK_currentWaveNumber)]"; // text to appear in wave start notification
            compileNotificationText = 1; // notificationText will be compiled and called. It must return an array compatible with the "arguments" parameter of BIS_fnc_showNotification
            //weightVariable = "";
        };
    /*
        class vehicleWave : infantryWave
        {
            onSelected = "remoteExec ['BLWK_fnc_handleVehicleWave',BLWK_theAIHandlerOwnerID]";
        };
    */
        class paratrooperWave : infantryWave
        {
            onSelected = "remoteExec ['BLWK_fnc_handleParatrooperWave',BLWK_theAIHandlerOwnerID]";
            weightVariable = "BLWK_paratrooperWaveWeight";
        };
    };

    class specialWaves
    {
        class suicideWave
        {
            onSelected = "remoteExec ['BLWK_fnc_handleSuicideWave',BLWK_theAIHandlerOwnerID]";
            creationNotificationTemplate = SPECIAL_WARNING_TEMPLATE;
            notificationText = "Enemy Suicide Bombers Are Incoming!";
            toggleVariable = "BLWK_allowSuicideWave"; // a name of a missionNamespace variable (on the server) that can be set to true or false to toggle the ability to have the wave (usually paired with the KISKA parameter menu)
        };
        class civilianWave : suicideWave
        {
            onSelected = "remoteExec ['BLWK_fnc_handleInfantryWave',BLWK_theAIHandlerOwnerID]; call BLWK_fnc_civiliansWave";
            notificationText = "Civilians Are Fleeing, Watch Your Fire!";
            toggleVariable = "BLWK_allowCivWave";
        };
    };
};
