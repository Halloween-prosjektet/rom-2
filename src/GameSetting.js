import Phaser from "phaser";

import Lock from "./assets/Lock.png";
import LockJSON from "./assets/Lock.json";

import { loadAnimations } from "./anime.js";

export default class GameSetting extends Phaser.Scene {
	preload() {
		this.load.atlas("Lock", Lock, LockJSON);
	}

	create() {
		loadAnimations(this);

		//! for lås sprites
		const lockSprite = this.add.sprite(985, 540, "Lock");
		lockSprite.play("Locks_anime");
	}

	update() {}
}
