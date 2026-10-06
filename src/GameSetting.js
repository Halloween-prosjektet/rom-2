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

		//insta play
		lockSprite.play("Locks_anime");

		this.add.dom(
			x,
			y,
			"div",
			"background-color: lime; width: 220px; height: 100px; font: 48px Arial",
			"Phaser"
		);
	}

	update() {}
}
