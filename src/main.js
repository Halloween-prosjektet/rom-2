import Phaser, { Scene } from "phaser";


import gameSetting from "./GameSetting.js";

let config = {
	type: Phaser.WEBGL,
	width: 1920,
	height: 1080,
	parent: "game",
	backgroundColor: "#2d2d2d",
	input: {
		keyboard: true
	},
	parent: "game-container",
	dom: {
		createContainer: true
	},

	scale: {
		mode: Phaser.Scale.FIT,
		autoCenter: Phaser.Scale.CENTER_BOTH
	},
	type: Phaser.CANVAS,
	physics: {
		default: "arcade"
	},
	scene: [gameSetting]
};

let game = new Phaser.Game(config);
