# 📱 Farano Mobile

**Farano** est une application mobile de divertissement et de challenge linguistique entre deux joueurs. Le principe est simple et addictif : les joueurs s'affrontent en entrant à tour de rôle une lettre pour former progressivement un mot. Le premier à compléter un mot valide gagne la partie.

## 🎯 Objectif du jeu

- Deux joueurs s'affrontent tour par tour.
- Chaque joueur ajoute une lettre à la suite de l'autre pour construire un mot.
- Le joueur qui entre la **dernière lettre d'un mot valide** (présent dans le dictionnaire) remporte la manche.
- Le mot ne doit pas être inventé : il est validé automatiquement via des dictionnaires intégrés.

---

## 🧠 Fonctionnalités principales

- 🔤 Saisie alternée de lettres entre deux joueurs en temps réel.
- 📚 Validation automatique des mots via des dictionnaires en **français**, **anglais** et **malgache**.
- 🏆 Système de score et gestion des manches.
- ☁️ Backend en **Firebase** pour la gestion des sessions de jeu, des utilisateurs et des scores.
- 🔐 Authentification simple des joueurs (Firebase Auth).
- 📱 Interface fluide et responsive construite avec **Flutter**.

---

## ⚙️ Technologies utilisées

| Composant        | Stack / Outil       |
|------------------|---------------------|
| Frontend         | Flutter             |
| Backend (BaaS)   | Firebase (Auth, Firestore, etc.) |
| Dictionnaires    | Word lists en FR / EN / MG |
| State Management | Bloc |
| Architecture     | Clean Architecture  |

---

