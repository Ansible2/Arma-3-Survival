#define WAIT_FOR_OWNERSHIP(TRANSFER_OBJECT) \
	if !(local TRANSFER_OBJECT) then {\
		[TRANSFER_OBJECT,clientOwner] remoteExecCall ["setOwner",2];\
		hintsilent (parseText "Standby.<br></br>Tansfering object to your machine.");\
		private _ownerShipWaitTime = 0;\
		private _messagesSent = 1;\
		waitUntil {\
			if (local TRANSFER_OBJECT) exitWith {\
				hintsilent "The object is now local to you.";\
				true\
			};\
			sleep 1;\
			_ownerShipWaitTime = _ownerShipWaitTime + 1;\
			if (_ownerShipWaitTime isEqualTo 3) then {\
				[TRANSFER_OBJECT,clientOwner] remoteExecCall ["setOwner",2];\
				_messagesSent = _messagesSent + 1;\
				_ownerShipWaitTime = 0;\
			};\
			if (_messagesSent isEqualTo 5) exitWith {\
				hintsilent (parseText "Sorry.<br></br>The tranfer failed.<br></br>The object will likely be slow to respond");\
				true\
			};\
			false\
		};\
	};