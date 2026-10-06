import Phaser from "phaser";

import Lock from "./assets/Lock.png";
import LockJSON from "./assets/Lock.json";

export default class GameSetting extends Phaser.Scene {
	preload() {
		this.load.atlas("Lock", Lock, LockJSON);
	}

	create() {}

	update() {}
}
