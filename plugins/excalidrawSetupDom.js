import { Path2D } from "canvas";
import "global-jsdom/register";

import excalidrawPkg from "@excalidraw/excalidraw/package.json" assert { type: "json" };
const excalidrawAssets = `https://unpkg.com/@excalidraw/excalidraw@${excalidrawPkg.version}`;

const localDistUrl = import.meta.resolve("@excalidraw/excalidraw/dist");

global.Path2D = Path2D;
global.window.EXCALIDRAW_ASSET_PATH = excalidrawAssets;
global.window.EXCALIDRAW_WEBPACK_ASSET_PATH = localDistUrl + "/";
