export const loadAnimations = (scene) => {
	//! ANIMATIONS
	scene.anims.create({
		key: "Locks_anime",
		frames: scene.anims.generateFrameNames("Lock", {
			prefix: "Lock",
			start: 0,
			end: 12,
			zeroPad: 0
		}),
		frameRate: 12,
		repeat: -1,
		repeatDelay: 2000
	});
};
