---
title: "[Kubernetes] Namespace bloqué avec le statut Terminating"
date: "2020-06-08"
author: "Florent Appointaire"
permalink: "/2020/06/08/kubernetes-namespace-bloque-avec-le-statut-terminating/"
summary: 
categories: 
  - "container"
tags: 
  - "aks"
  - "kubernetes"
  - "microsoft"
---
Aujourd'hui, au moment de la suppression d'un namespace Kubernetes, j'ai remarqué qu'il était bloqué sur le statut **Terminating:**

![](https://cloudyjourney.fr/wp-content/uploads/2020/06/ns01.png)

J'ai cherché sur internet, et j'ai trouvé ce poste sur Github: https://github.com/kubernetes/kubernetes/issues/60807#issuecomment-572615776

J'ai donc exécuté la commande suivante:

```
kubectl get namespace "namespaceàsupprimer" -o json | tr -d "\n" | sed "s/\"finalizers\": \[[^]]\+\]/\"finalizers\": []/" | kubectl replace --raw /api/v1/namespaces/namespaceàsupprimer/finalize -f -
```

Ce qui a supprimé les namespaces qui étaient bloqués:

![](https://cloudyjourney.fr/wp-content/uploads/2020/06/ns02.png)
