Hooks:PostHook(NewNPCRaycastWeaponBase, "init", "ExtraNPCLights_NewNPCRaycastWeaponBase_init", function(self, unit)
	NPCRaycastWeaponBase.add_fallback_flashlight(self)
end)

Hooks:PostHook(NewNPCRaycastWeaponBase, "destroy", "ExtraNPCLights_NewNPCRaycastWeaponBase_destroy", function(self, unit)
	NPCRaycastWeaponBase.destroy_fallback_flashlight(self)
end)