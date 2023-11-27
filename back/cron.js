import cron from 'node-cron'

export function runCron() {
  cron.schedule(
      '*/10 * * * * *', () => {console.log('running a task every 10 seconds')})
}
