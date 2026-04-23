//! Input
//!

type DeviceId = Int


external 15000 fn get_active_devices() -> Vec<DeviceId>
external 15001 fn set_active_action_set(action_set_type: TypeId, device_id: DeviceId)
external 15002 fn get(device_id: DeviceId) -> Any
