# How to connect to Slack

## Create a Slack App

1. Go to [slack](https://api.slack.com/apps) and click on "Create New App"
[![My Skills](https://cdn.discordapp.com/attachments/684788230515851297/1193857127341629521/create.png?ex=65ae3d17&is=659bc817&hm=0efb709b7e66658e793c0c367333ec675151c3cb117cd4ed3e71ac1d86ef6145&)](https://api.slack.com/apps)
2. Click on "From scratch"
[![My Skills](https://cdn.discordapp.com/attachments/684788230515851297/1193857127765262336/create2.png?ex=65ae3d18&is=659bc818&hm=90d355099fadc6c77db49cdd59680085d56b5d79903045b7d9bd17171ba8509c&)](https://api.slack.com/apps)
3. Enter a name for your app and select the workspace you want to connect to
[![My Skills](https://cdn.discordapp.com/attachments/684788230515851297/1193857128612503612/create4.png?ex=65ae3d18&is=659bc818&hm=559701faf7379ae47845ed3e361d7d30206e2002a624e331ce5daf1920949b1d&&)](https://api.slack.com/apps)
4. Click on "Create App"
5. Click on "OAuth & Permissions" in the left menu
[![My Skills](https://cdn.discordapp.com/attachments/684788230515851297/1193857128138559529/create3.png?ex=65ae3d18&is=659bc818&hm=cc8a26b2f471fe8e4b1ed03d119e16cab8ae48762d90a7fd5076c5f2bceffc02&)](https://api.slack.com/apps)
6. Add rediret URL `https://localhost`
[![My Skills](https://cdn.discordapp.com/attachments/684788230515851297/1193857128998387712/create5.png?ex=65ae3d18&is=659bc818&hm=384ae0b47d811c226f8fcb031c171c8ec7d39c401685ef6961a44bca5e8279b8&)](https://api.slack.com/apps)
7. Add User scopes
    - `channels:history`
    - `channels:read`
    - `chat:write`
    - `groups:history`
    - `groups:read`
    - `im:history`
    - `im:read`
    - `mpim:history`
    - `mpim:read`
    - `users:read`
    - `admin`
[![My Skills](https://cdn.discordapp.com/attachments/684788230515851297/1193857129858211940/create7.png?ex=65ae3d18&is=659bc818&hm=6df9e574705ab29ca317c15ded918cad9a51c34b03f3e13b60f34791a963633b&)](https://api.slack.com/apps)
[![My Skills](https://cdn.discordapp.com/attachments/684788230515851297/1193857130218930216/create8.png?ex=65ae3d18&is=659bc818&hm=00868b01e1c975799bb706b120aaefbfc73a665310f9a23ce25a608a9df2b7a1&)](https://api.slack.com/apps)
8. Click on "Install App to Workspace"
[![My Skills](https://cdn.discordapp.com/attachments/684788230515851297/1193857130625781801/create9.png?ex=65ae3d18&is=659bc818&hm=5f8c3b54a1ff08cd8022a2fc606455e7417fd9ee48cfdfdd53f57891d40c1643&)](https://api.slack.com/apps)
9. Click on "Allow"
[![My Skills](https://cdn.discordapp.com/attachments/684788230515851297/1193857131024228493/create10.png?ex=65ae3d18&is=659bc818&hm=2f33c703750f2795986326ec666376a3a4613f8f994262114713cb8a70495973&)](https://api.slack.com/apps)
10. Copy the token from "OAuth Access Token" and paste it into the `slack_token` field in the Maker front connection form.
[![My Skills](https://cdn.discordapp.com/attachments/684788230515851297/1193857137785450558/create11.png?ex=65ae3d1a&is=659bc81a&hm=0dd426b1a38d278ce611c8718f9b846d4db95014e395d5cba093807dcebbfeb6&)](https://api.slack.com/apps)
