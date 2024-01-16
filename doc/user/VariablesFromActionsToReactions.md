# Here is the list of variables that can be used in the reactions of each action.

## How to use a variable
- You just have to enter ${variable_name} in the reaction field of the action.
- For example, if you want to use the variable `temperature` in the reaction of the action `Get Meteo`, you just have to enter ${temperature} in the reaction.

## Actions and Variables

| Actions       | Variables                |
|---------------|--------------------------|
| Get Meteo       | `type`: The weather type (sun, rain...)<br>`description`:A description of the weather<br>`localisation`: The localisation of the weather<br>`temperature`: The temperature of the weather, in °C.   |
| NASA Picture of the Day       | `title`: The title of the picture<br>`explanation`: The explanation of the picture<br>`URL`: The url of the picture<br>`hdurl`: The url of the HD picture<br>`date`: The date of the picture<br>`thumbnail_url`: The url of the thumbnail of the picture<br>`media_type`: The type of the media (image, video...)   |
| Github Branch | `branchName`: The name of the branch<br>`repoName`: The name of the repository<br>`repoOwner`: The owner of the repository<br>`repoUrl`: The url of the repository<br>`ownerName`: The name of the owner |
| Github Issue | `repoName`: The name of the repository<br>`repoUrl`: The url of the repository<br>`number`: The number of the issue<br>`title`: The title of the issue<br>`body`: The body of the issue<br>`created_at`: The date of the creation of the issue<br>`creator`: The creator of the issue |
| Github Pull-request | `number`: The number of the pull-request<br>`title`: The title of the pull-request<br>`body`: The body of the pull-request<br>`created_at`: The date of the creation of the pull-request<br>`creator`: The creator of the pull-request |
| Github star | `repoName`: The name of the repository<br>`repoUrl`: The url of the repository<br>`ownerName`: The name of the owner<br>`starred_at`: The date of the starring<br>`starCount`: The number of stars of the repository<br>`starUserName`: The name of the user who starred the repository |