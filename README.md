# 🐳 Docker GHA Training Project

Ce projet est un exemple complet de containerisation et d’automatisation CI/CD pour une application Python avec base de données PostgreSQL.

---

## 🚀 Fonctionnalités

- 📦 Application Python containerisée avec Docker
- 🗄️ Base de données PostgreSQL sans persistance (volatile, pour dev/test)
- 🐘 Démarrage synchronisé avec PostgreSQL (attente native en Python)
- 🔒 Utilisation sécurisée des secrets via Docker secrets (pas d'env vars sensibles)
- 🔁 Deux workflows GitHub Actions :
  - `build-and-test`: installe et teste le projet à chaque push/PR
  - `docker-build-push`: construit et publie une image Docker sur `main` uniquement
- ♻️ Image Docker optimisée : légère, non-root, avec cache et sécurité

---

## 🛠️ Lancer le projet en local

### 1. Démarrer via Docker Compose

```bash
docker compose up --build
