# Projet d'Infrastructure et de Déploiement Continu sur Azure

## Description du Projet

Ce projet vise à provisionner une infrastructure sur **Azure** pour une API HTTP existante tout en implémentant une pipeline CI/CD à l'aide de **GitHub Actions**. L'infrastructure est gérée avec **Terraform** et automatiquement déployée via des workflows CI/CD. L'API HTTP exposera plusieurs endpoints interagissant avec une base de données et un stockage Blob. Le projet intègre les technologies suivantes :

- **Terraform** pour le provisionnement de l'infrastructure  
- **Azure** pour les ressources cloud (App Service, Base de données, Stockage Blob, etc.)  
- **GitHub Actions** pour l'intégration et le déploiement continus  

---

## Objectifs

Le projet implique :  
1. **Le provisionnement de l'infrastructure requise sur Azure :**  
    - Azure App Service  
    - Base de données Azure  
    - Stockage Azure Blob  
    - Autres ressources pertinentes (ex : réseau virtuel)  

2. **La création d'une pipeline CI/CD avec GitHub Actions :**  
    - Tester le code lors de la création d'une pull request  
    - Construire et publier une image Docker à chaque fusion dans la branche `main`  

---

## Structure du Projet

- **`/infrastructure/`** : Contient le code Terraform pour provisionner l'infrastructure sur Azure.  
- **`/.github/`** : Contient les workflows GitHub Actions pour le CI/CD.  
- **`/examples/`** : Contient le code de l'API HTTP.  

---

## Équipe

Ce projet a été développé par les membres de l'équipe suivants :  
- **William SAVRE**  
- **Paul MAERTEN**  
- **Noe DELOOSE**  

---

## Fonctionnalités de l'API

L'API HTTP expose plusieurs endpoints :  
1. **`/`** : Endpoint public.  
2. **`/examples`** : Récupère les enregistrements depuis la base de données PostgreSQL.  
3. **`/quotes`** : Retourne des données depuis un fichier JSON stocké dans Azure Blob Storage.  

---

## CI/CD

La pipeline CI/CD est conçue pour effectuer les actions suivantes :  
1. **Tests automatisés** : Déclenchés lors de la création d'une pull request.  
2. **Build Docker** : Construit et publie l'image Docker dans un registre Docker lors de fusions dans `main`.  
3. **Déploiement** : Déploie l'image Docker vers Azure App Service.  

---

## Infrastructure-as-Code

L'infrastructure est entièrement déclarée à l'aide de **Terraform** et est modulaire. Vous pouvez facilement déployer cette infrastructure en exécutant `terraform apply` après avoir configuré les variables nécessaires.  
Il est également possible d'ajouter des modules supplémentaires tout en utilisant certaines briques existantes du projet.  

### Modules Terraform  
Les modules Terraform sont organisés pour simplifier le déploiement et la maintenance. Chaque ressource est définie de manière modulaire.

---

## Sécurité

Des mesures de sécurité ont été mises en place pour assurer une configuration appropriée des ressources :  
- La base de données n'est **pas exposée publiquement**.  
- Toutes les ressources sont placées dans un sous-réseau dédié.  
- Les secrets ne sont pas visibles dans le dépôt Git.  

---

## Comment Lancer le Projet

Pour lancer ce projet, suivez les étapes ci-dessous :  

1. **Forkez** le dépôt GitHub.  
2. Accédez au dossier `infrastructure`.  
3. Fournissez les configurations nécessaires en renseignant le fichier `terraform.tfvars` (voir `terraform.tfvars.example`) avec les valeurs spécifiques à votre environnement. Ce fichier doit inclure des variables comme les identifiants Azure, noms des ressources, et identifiants de la base de données.  
4. Initialisez Terraform avec la commande `terraform init`, puis appliquez avec `terraform apply` pour déployer le projet. Cette étape peut prendre plusieurs minutes.  
5. L'URL de l'application peut être récupérée dans les **outputs** sous le nom `app_service_fqdn`.  

---

## Architecture Fonctionnelle  

![image](https://github.com/user-attachments/assets/35285d34-e489-40f6-a763-ff0a17987f57)  

Placer chaque ressource dans son propre sous-réseau au sein d’un **Virtual Network (VNet)** offre plusieurs avantages, principalement liés à la **sécurité**, à la gestion du trafic et à l'organisation de l'infrastructure. Chaque ressource (ex : bases de données, applications web, services de stockage) a des besoins réseau spécifiques. Cela permet :  
- D'appliquer des **contrôles d'accès plus stricts** et granulaires (par exemple, garder la base de données et le stockage privés).  
- De faciliter la gestion des flux de trafic entre les ressources.  
- D'assurer une meilleure **maintenance et évolutivité** sans impacter le reste du réseau.  

---

## Ressources

Pour en savoir plus sur les technologies utilisées, consultez les ressources suivantes :  
- [GitHub Actions](https://docs.github.com/en/actions)  
- [Documentation Terraform](https://developer.hashicorp.com/terraform/docs)  

---

## Conclusion

Ce projet est une **implémentation pratique** des concepts de CI/CD, Terraform et de la gestion d'infrastructure sur Azure. Il offre une expérience concrète dans le déploiement d'applications cloud avec un haut niveau d'automatisation.



