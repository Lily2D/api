//! # Input API for Lily2D
//!
//! Input abstraction for Gamepad, Keyboard and Mouse. Will support Steam Input in the future.



// DO NOT MODIFY THIS FILE!

#![api]

type DeviceId = Int


external 15000 fn get_active_devices() -> Vec<DeviceId>
external 15001 fn set_active_action_set(action_set_type: TypeId, device_id: DeviceId)
external 15002 fn get(device_id: DeviceId) -> Any


/// The DeviceType is not 100% reliable, so you can not rely on getting the exact information about the device
enum DeviceType {
    /// Generic
    Unknown
    KeyboardAndMouse
    GenericGamepad

    /// Valve
    SteamController
    SteamDeckController

    /// Sony / Playstation
    Ps4
    Ps5

    /// Microsoft / Xbox
    Xbox360
    XboxOne
    Xinput

    /// Nintendo / Switch
    SwitchJoyConPair // Is this reliable?
    SwitchJoyConSingle // not sure if this is reliable?
    SwitchPro
}

external 15003 fn get_device_type(device_id: DeviceId) -> DeviceType

enum ActionSource {
    /// Generic
    GenericButton

    GenericA
    GenericB
    GenericX
    GenericY

    GenericCross
    GenericCircle
    GenericTriangle
    GenericSquare

    GenericLeftStickMove
    GenericLeftStickClick
    GenericRightStickMove
    GenericRightStickClick

    GenericLeftTriggerPull
    GenericLeftTriggerClick
    GenericRightTriggerPull
    GenericRightTriggerClick

    GenericLeftBumper
    GenericRightBumper

    GenericLeftDPadNorth
    GenericLeftDPadSouth
    GenericLeftDPadWest
    GenericLeftDPadEast

    GenericRightDPadNorth
    GenericRightDPadSouth
    GenericRightDPadWest
    GenericRightDPadEast

    /// Keyboard & Mouse
    Key // TODO: should store the key glyph?
    MouseLeft
    MouseRight
    MouseWheel
    CursorPosition

    /// Valve
	SteamControllerA
	SteamControllerB
	SteamControllerX
	SteamControllerY
	SteamControllerLeftBumper
	SteamControllerRightBumper
	SteamControllerLeftGrip
	SteamControllerRightGrip
	SteamControllerStart
	SteamControllerBack
	SteamControllerLeftPadTouch
	SteamControllerLeftPadSwipe
	SteamControllerLeftPadClick
	SteamControllerLeftPadDPadNorth
	SteamControllerLeftPadDPadSouth
	SteamControllerLeftPadDPadWest
	SteamControllerLeftPadDPadEast
	SteamControllerRightPadTouch
	SteamControllerRightPadSwipe
	SteamControllerRightPadClick
	SteamControllerRightPadDPadNorth
	SteamControllerRightPadDPadSouth
	SteamControllerRightPadDPadWest
	SteamControllerRightPadDPadEast
	SteamControllerLeftTriggerPull
	SteamControllerLeftTriggerClick
	SteamControllerRightTriggerPull
	SteamControllerRightTriggerClick
	SteamControllerLeftStickMove
	SteamControllerLeftStickClick
	SteamControllerLeftStickDPadNorth
	SteamControllerLeftStickDPadSouth
	SteamControllerLeftStickDPadWest
	SteamControllerLeftStickDPadEast
	SteamControllerGyroMove
	SteamControllerGyroPitch
	SteamControllerGyroYaw
	SteamControllerGyroRoll

    SteamDeckA
    SteamDeckB
    SteamDeckX
    SteamDeckY
    SteamDeckL1
    SteamDeckR1
    SteamDeckMenu
    SteamDeckView
    SteamDeckLeftPadTouch
    SteamDeckLeftPadSwipe
    SteamDeckLeftPadClick
    SteamDeckLeftPadDPadNorth
    SteamDeckLeftPadDPadSouth
    SteamDeckLeftPadDPadWest
    SteamDeckLeftPadDPadEast
    SteamDeckRightPadTouch
    SteamDeckRightPadSwipe
    SteamDeckRightPadClick
    SteamDeckRightPadDPadNorth
    SteamDeckRightPadDPadSouth
    SteamDeckRightPadDPadWest
    SteamDeckRightPadDPadEast
    SteamDeckL2SoftPull
    SteamDeckL2
    SteamDeckR2SoftPull
    SteamDeckR2
    SteamDeckLeftStickMove
    SteamDeckL3
    SteamDeckLeftStickDPadNorth
    SteamDeckLeftStickDPadSouth
    SteamDeckLeftStickDPadWest
    SteamDeckLeftStickDPadEast
    SteamDeckLeftStickTouch
    SteamDeckRightStickMove
    SteamDeckR3
    SteamDeckRightStickDPadNorth
    SteamDeckRightStickDPadSouth
    SteamDeckRightStickDPadWest
    SteamDeckRightStickDPadEast
    SteamDeckRightStickTouch
    SteamDeckL4
    SteamDeckR4
    SteamDeckL5
    SteamDeckR5
    SteamDeckDPadMove
    SteamDeckDPadNorth
    SteamDeckDPadSouth
    SteamDeckDPadWest
    SteamDeckDPadEast
    SteamDeckGyroMove
    SteamDeckGyroPitch
    SteamDeckGyroYaw
    SteamDeckGyroRoll


    /// Sony
    Ps4X
    Ps4Circle
    Ps4Triangle
    Ps4Square
    Ps4LeftBumper
    Ps4RightBumper
    Ps4Options	//Start
    Ps4Share		//Back
    Ps4LeftPadTouch
    Ps4LeftPadSwipe
    Ps4LeftPadClick
    Ps4LeftPadDPadNorth
    Ps4LeftPadDPadSouth
    Ps4LeftPadDPadWest
    Ps4LeftPadDPadEast
    Ps4RightPadTouch
    Ps4RightPadSwipe
    Ps4RightPadClick
    Ps4RightPadDPadNorth
    Ps4RightPadDPadSouth
    Ps4RightPadDPadWest
    Ps4RightPadDPadEast
    Ps4CenterPadTouch
    Ps4CenterPadSwipe
    Ps4CenterPadClick
    Ps4CenterPadDPadNorth
    Ps4CenterPadDPadSouth
    Ps4CenterPadDPadWest
    Ps4CenterPadDPadEast
    Ps4LeftTriggerPull
    Ps4LeftTriggerClick
    Ps4RightTriggerPull
    Ps4RightTriggerClick
    Ps4LeftStickMove
    Ps4LeftStickClick
    Ps4LeftStickDPadNorth
    Ps4LeftStickDPadSouth
    Ps4LeftStickDPadWest
    Ps4LeftStickDPadEast
    Ps4RightStickMove
    Ps4RightStickClick
    Ps4RightStickDPadNorth
    Ps4RightStickDPadSouth
    Ps4RightStickDPadWest
    Ps4RightStickDPadEast
    Ps4DPadNorth
    Ps4DPadSouth
    Ps4DPadWest
    Ps4DPadEast
    Ps4GyroMove
    Ps4GyroPitch
    Ps4GyroYaw
    Ps4GyroRoll
    Ps4DPadMove

	Ps5X
    Ps5Circle
    Ps5Triangle
    Ps5Square
    Ps5LeftBumper
    Ps5RightBumper
    Ps5Option	//Start
    Ps5Create		//Back
    Ps5Mute
    Ps5LeftPadTouch
    Ps5LeftPadSwipe
    Ps5LeftPadClick
    Ps5LeftPadDPadNorth
    Ps5LeftPadDPadSouth
    Ps5LeftPadDPadWest
    Ps5LeftPadDPadEast
    Ps5RightPadTouch
    Ps5RightPadSwipe
    Ps5RightPadClick
    Ps5RightPadDPadNorth
    Ps5RightPadDPadSouth
    Ps5RightPadDPadWest
    Ps5RightPadDPadEast
    Ps5CenterPadTouch
    Ps5CenterPadSwipe
    Ps5CenterPadClick
    Ps5CenterPadDPadNorth
    Ps5CenterPadDPadSouth
    Ps5CenterPadDPadWest
    Ps5CenterPadDPadEast
    Ps5LeftTriggerPull
    Ps5LeftTriggerClick
    Ps5RightTriggerPull
    Ps5RightTriggerClick
    Ps5LeftStickMove
    Ps5LeftStickClick
    Ps5LeftStickDPadNorth
    Ps5LeftStickDPadSouth
    Ps5LeftStickDPadWest
    Ps5LeftStickDPadEast
    Ps5RightStickMove
    Ps5RightStickClick
    Ps5RightStickDPadNorth
    Ps5RightStickDPadSouth
    Ps5RightStickDPadWest
    Ps5RightStickDPadEast
    Ps5DPadNorth
    Ps5DPadSouth
    Ps5DPadWest
    Ps5DPadEast
    Ps5GyroMove
    Ps5GyroPitch
    Ps5GyroYaw
    Ps5GyroRoll
    Ps5DPadMove
    Ps5LeftGrip
    Ps5RightGrip
    Ps5LeftFn
    Ps5RightFn

    /// Microsoft
	XboxOneA
	XboxOneB
	XboxOneX
	XboxOneY
	XboxOneLeftBumper
	XboxOneRightBumper
	XboxOneMenu  //Start
	XboxOneView  //Back
	XboxOneLeftTriggerPull
	XboxOneLeftTriggerClick
	XboxOneRightTriggerPull
	XboxOneRightTriggerClick
	XboxOneLeftStickMove
	XboxOneLeftStickClick
	XboxOneLeftStickDPadNorth
	XboxOneLeftStickDPadSouth
	XboxOneLeftStickDPadWest
	XboxOneLeftStickDPadEast
	XboxOneRightStickMove
	XboxOneRightStickClick
	XboxOneRightStickDPadNorth
	XboxOneRightStickDPadSouth
	XboxOneRightStickDPadWest
	XboxOneRightStickDPadEast
	XboxOneDPadNorth
	XboxOneDPadSouth
	XboxOneDPadWest
	XboxOneDPadEast
	XboxOneDPadMove
	XboxOneLeftGripLower
	XboxOneLeftGripUpper
	XboxOneRightGripLower
	XboxOneRightGripUpper


    Xbox360A
    Xbox360B
    Xbox360X
    Xbox360Y
    Xbox360LeftBumper
    Xbox360RightBumper
    Xbox360Start
    Xbox360Back
    Xbox360LeftTriggerPull
    Xbox360LeftTriggerClick
    Xbox360RightTriggerPull
    Xbox360RightTriggerClick
    Xbox360LeftStickMove
    Xbox360LeftStickClick
    Xbox360LeftStickDPadNorth
    Xbox360LeftStickDPadSouth
    Xbox360LeftStickDPadWest
    Xbox360LeftStickDPadEast
    Xbox360RightStickMove
    Xbox360RightStickClick
    Xbox360RightStickDPadNorth
    Xbox360RightStickDPadSouth
    Xbox360RightStickDPadWest
    Xbox360RightStickDPadEast
    Xbox360DPadNorth
    Xbox360DPadSouth
    Xbox360DPadWest
    Xbox360DPadEast
    Xbox360DPadMove

    /// Nintendo
    SwitchA
    SwitchB
    SwitchX
    SwitchY
    SwitchLeftBumper
    SwitchRightBumper
    SwitchPlus	//Start
    SwitchMinus	//Back
    SwitchCapture
    SwitchLeftTriggerPull
    SwitchLeftTriggerClick
    SwitchRightTriggerPull
    SwitchRightTriggerClick
    SwitchLeftStickMove
    SwitchLeftStickClick
    SwitchLeftStickDPadNorth
    SwitchLeftStickDPadSouth
    SwitchLeftStickDPadWest
    SwitchLeftStickDPadEast
    SwitchRightStickMove
    SwitchRightStickClick
    SwitchRightStickDPadNorth
    SwitchRightStickDPadSouth
    SwitchRightStickDPadWest
    SwitchRightStickDPadEast
    SwitchDPadNorth
    SwitchDPadSouth
    SwitchDPadWest
    SwitchDPadEast
    SwitchProGyroMove
    SwitchProGyroPitch
    SwitchProGyroYaw
    SwitchProGyroRoll


	SwitchRightGyroMove
	SwitchRightGyroPitch
	SwitchRightGyroYaw
	SwitchRightGyroRoll
	SwitchLeftGyroMove
	SwitchLeftGyroPitch
	SwitchLeftGyroYaw
	SwitchLeftGyroRoll
	SwitchLeftGripLower
	SwitchLeftGripUpper
	SwitchRightGripLower
	SwitchRightGripUpper
	SwitchJoyConButtonN
	SwitchJoyConButtonE
	SwitchJoyConButtonS
	SwitchJoyConButtonW
}

external 15004 fn get_action_source(action_set_type: TypeId, action_name: String, device_id: DeviceId) -> ActionSource
