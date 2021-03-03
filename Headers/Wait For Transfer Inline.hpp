#define WAIT_FOR_OWNERSHIP(TRANSFER_OBJECT) \
	if !(local TRANSFER_OBJECT) then {\
		[TRANSFER_OBJECT,clientOwner] remoteExecCall ["setOwner",2];\
		hint (parseText "Standby.<br></br>Tansfering object to your machine.");\
		private _ownershipWaitTime = 0;\
		private _messagesSent = 1;\
		private _sleepTime = 0.5;\
		waitUntil {\
			if (local TRANSFER_OBJECT) exitWith {\
				hintsilent "The object is now local to you.";\
				sleep _sleepTime;\
				true\
			};\
			sleep _sleepTime;\
			_ownershipWaitTime = _ownershipWaitTime + _sleepTime;\
			if (_ownershipWaitTime isEqualTo 3) then {\
				[TRANSFER_OBJECT,clientOwner] remoteExecCall ["setOwner",2];\
				_messagesSent = _messagesSent + 1;\
				_ownershipWaitTime = 0;\
			};\
			if (_messagesSent isEqualTo 5) exitWith {\
				hint (parseText "Sorry.<br></br>The transfer failed.<br></br>The object will likely be slow to respond");\
				true\
			};\
			false\
		};\
	};