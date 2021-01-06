---
title: "[AWS] Amazon Polly: Texte en Voix"
date: "2018-01-26"
author: "Florent Appointaire"
permalink: "/2018/01/22/aws-amazon-polly-texte-en-voix"
summary:
categories: 
  - "amazon-polly"
tags: 
  - "aws"
  - "polly"
  - "text-to-speech"
  - "texte-en-voix"
---
En continuant le développement de mes workflows pour le service desk, j'ai eu besoin de faire des messages pour les utilisateurs. Le souci de la partie built-in de Amazon Connect est que seulement l'anglais est disponible.

Après quelques recherches, j'ai vu qu'il y avait Amazon Polly qui était disponible sur AWS, et qui permet de faire ceci. Et il est pas mal fourni en langues: [https://docs.aws.amazon.com/polly/latest/dg/voicelist.html](https://docs.aws.amazon.com/polly/latest/dg/voicelist.html)

J'ai donc décidé de l'essayer, et le résultat a été très concluant. Je vais donc vous expliquer comment créer votre texte, et l'importer dans AWS Connect, pour l'utiliser dans nos workflows.

Pour commencer, allez sur votre console AWS, et dans la partie **Machine Learning**, sélectionnez **Amazon Polly:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSPolly01.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSPolly01.png)

Cliquez sur **Get started** pour commencer:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSPolly02.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSPolly02.png)

Renseignez le texte que vous souhaitez faire, ainsi que la langue, et surtout, si vous souhaitez une voix féminine ou masculine. Une fois terminé, vous pouvez écouter le texte avant de le télécharger. Seul bémole ici, Amazon Connect ne supporte que du WAV en format, et ici, on peut télécharger du MP3, OGG, mais pas de WAV... Bizarre donc. Téléchargez le fichier, en MP3:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSPolly03.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSPolly03.png)

J'ai ensuite trouvé le convertisseur MP3 en WAV suivant : [https://audio.online-convert.com/fr/convertir-en-wav](https://audio.online-convert.com/fr/convertir-en-wav)

Il suffit d'importer le son, de convertir le fichier, et voila :)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSPolly04.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSPolly04.png)

Allez sur Amazon Connect, dans **Routing > Prompts**. Cliquez sur **Create new prompt** pour importer notre fichier WAV:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSPolly05.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSPolly05.png)

Uploadez votre fichier et donnez lui un nom pour le reconnaitre facilement:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSPolly06.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSPolly06.png)

Le fichier a été correctement importé, vous pouvez l'écouter si vous le souhaitez:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSPolly07.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSPolly07.png)

Nous verrons dans le prochaine article, lors de la création du workflow, comment utiliser ce fichier audio :)
