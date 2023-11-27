import cron from "node-cron"

import { checkDiscordAction } from "./discord.js"
import { checkGmailAction } from "./gmail.js"
import { checkDriveAction } from "./drive.js"
import { checkTiktokAction } from "./tiktok.js"
import { checkTimerAction } from "./timer.js"
import { checkYoutubeAction } from "./youtube.js"

export function runCron() {
    cron.schedule("*/10 * * * * *", () => {
        console.log("running a task every 10 seconds")
        checkDiscordAction()
        checkGmailAction()
        checkDriveAction()
        checkTiktokAction()
        checkTimerAction()
        checkYoutubeAction()
    })
}
