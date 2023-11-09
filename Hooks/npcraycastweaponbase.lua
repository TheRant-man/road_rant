function NPCRaycastWeaponBase:add_fallback_flashlight()
	if self._flashlight_data then return end	

	local effect = self._unit:effect_spawner(Idstring("flashlight"))
	if not effect then return end

	local fallback_objects = {
		"a_effect_flashlight",
		--"fire"
	}

	local fallback_object = nil
	for _, fallback_object_name in pairs(fallback_objects) do
		fallback_object = self._unit:get_object(Idstring(fallback_object_name))

		if fallback_object then break end
	end

	if not fallback_object then return end

	self._fallback_flashlight = World:create_light("spot|specular")
	self._fallback_flashlight:set_enable(false)
	self._fallback_flashlight:link(fallback_object)
	self._fallback_flashlight:set_rotation(Rotation(
		 fallback_object:rotation():z(),
		-fallback_object:rotation():x(),
		-fallback_object:rotation():y()
	))

	self._fallback_flashlight:set_far_range(400)
	self._fallback_flashlight:set_spot_angle_end(25)
	self._fallback_flashlight:set_multiplier(2)

	self._flashlight_data = {
		light = self._fallback_flashlight,
		effect = effect
	}
end

function NPCRaycastWeaponBase:destroy_fallback_flashlight()
	if self._fallback_flashlight and alive(self._fallback_flashlight) then
		World:delete_light(self._fallback_flashlight)
	end
end

Hooks:PostHook(NPCRaycastWeaponBase, "init", "ExtraNPCLights_NPCRaycastWeaponBase_init", function(self, unit)
	self:add_fallback_flashlight()
end)

Hooks:PostHook(NPCRaycastWeaponBase, "destroy", "ExtraNPCLights_NPCRaycastWeaponBase_destroy", function(self, unit)
	self:destroy_fallback_flashlight()
end)