#include "..\String Constants.hpp"

class BLWK_waveTypes
{
    class normalWaves
    {
        class standardWave
        {
            // The name of a missionNamespace variable that must be code that will return
            // an array of weighted or unweighted classnames (<STRING[] | [STRING,NUMBER,STRING,NUMBER,...]>)
            // that will be randomly selected from when spawning an enemy man
            // Executes on the SERVER
            // (see BLWK_fnc_waves_create for context)
            generateMenClassnames = "BLWK_fnc_standardWave_generateMenClassnames";

            // The name of a missionNamespace variable that must be code that will return
            // a single position in ATL format (<PositionATL[]>)
            // Executes on the SERVER
            // (see BLWK_fnc_waves_create for context)
            generateManSpawnPosition = "BLWK_fnc_standardWave_generateManSpawnPosition";

            // The name of a missionNamespace variable that must be code.
            // This will be executed after all initial units have spawned for the start of a wave
            // Executes on the SERVER
            // (see BLWK_fnc_waves_create and BLWK_fnc_waves_onInitialized for context)
            // Parameters:
            /// 0: <CONFIG> - the config of the wave 
            onWaveInit = "BLWK_fnc_standardWave_onWaveInit";

            // The name of a missionNamespace variable that must be code.
            // Runs once a unit is created from the queue of enemies to spawn.
            // Executes on the AI Handler (either headless or server)
            // (see BLWK_fnc_spawnQueue_create for context)
            // Parameters:
            /// 0: <OBJECT> - the unit created 
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
            onWaveInit = "BLWK_fnc_paratrooperWave_onWaveInit";
            weightVariable = "BLWK_paratrooperWaveWeight";
        };
        class defectorWave : standardWave
        {
            generateMenClassnames = "BLWK_fnc_defectorWave_generateMenClassnames";
            weightVariable = "BLWK_defectorWaveWeight";
            onWaveInit = "BLWK_fnc_defectorWave_onWaveInit";
        };
    };

    class specialWaves
    {
        class suicideWave
        {
            onWaveInit = "BLWK_fnc_suicideWave_onWaveInit";
            creationNotificationTemplate = SPECIAL_WARNING_TEMPLATE;
            notificationText = "Enemy Suicide Bombers Are Incoming!";
            // The "toggleVariable" is a name of a missionNamespace variable (on the server) 
            // that can be set to true or false to toggle the ability to have the wave 
            // (likely paired with a KISKA parameter menu mission param)
            toggleVariable = "BLWK_allowSuicideWave"; 
        };
        class civilianWave
        {
            creationNotificationTemplate = SPECIAL_WARNING_TEMPLATE;
            onWaveInit = "BLWK_fnc_civilianWave_onWaveInit";
            onWaveEnd = "BLWK_fnc_civilianWave_onWaveEnd";
            notificationText = "Civilians Are Fleeing, Watch Your Fire!";
            toggleVariable = "BLWK_allowCivWave";
        };
        class droneWave : suicideWave
        {
            onSelected = "remoteExecCall ['BLWK_fnc_handleDroneWave',BLWK_theAIHandlerOwnerID]";
            notificationText = "Enemy Drones Inbound!";
            onWaveEnd = "call BLWK_fnc_onDroneWaveEnd";
            toggleVariable = "BLWK_allowDroneWave";
        };
        class overrunWave
        {
            creationNotificationTemplate = SPECIAL_WARNING_TEMPLATE;
            onWaveInit = "BLWK_fnc_overrunWave_onWaveInit";
            onWaveEnd = "BLWK_fnc_overrunWave_onWaveEnd";
            generateManSpawnPosition = "BLWK_fnc_overrunWave_generateManSpawnPosition";
            condition = "BLWK_fnc_overrunWave_condition";
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
