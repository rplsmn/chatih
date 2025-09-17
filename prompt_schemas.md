Base : mco_decennale
Table : fixe
Colonnes :
- ident (VARCHAR)
  PRIMARY KEY : une valeur unique par ligne. Une ligne = un séjour.
- annee (VARCHAR)
  Catégories : 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024.
- finess (VARCHAR)
  Environ 3000 valeurs uniques possibles. Code FINESS de l'établissement.
- duree (INTEGER)
  Entier positif de 0 à N nuits.
- age (INTEGER)
  Entier positif de 0 à N années.
- agejour (INTEGER)
  Entier positif de 0 à N jours si age = 0.
- sexe (VARCHAR)
  Catégories : 1 (masculin), 2 (féminin).
- ghm2 (VARCHAR)
  Environ 2000 valeurs uniques possibles. Toujours 6 caractères pour un GHM. Les 2 premiers chiffres correspondent à la 'catégorie majeure de diagnostic'. Le 3e caractère (lettre parmi C, K, M et Z) est une sous-catégorie d'activité (chirurgie, interventionnel, médecine, autre). Les 5 premiers caractères correspondent à la 'racine' du GHM et le dernier chiffre son 'niveau'. Exemple : 10C113.
- modeentree (VARCHAR)
  Catégories : 0, 6, 7, 8, N, O, X. Le mode d'entrée du patient dans l'établissement.
  0 : transfert provisoire, 6 : mutation, 7 : transfert définitif, 8 : domicile, N : naissance, O : Patient entré décédé pour prélèvement d'organes, X : non attendu.
- modesortie (VARCHAR)
  Catégories : 0, 6, 7, 8, 9. Le mode de sortie du patient à la fin de son séjour. 0 : transfert provisoire, 6 : mutation, 7 : transfert définitif, 8 : domicile, 9 : décès, X : non attendu.
- typ_sej (VARCHAR)
  Catégories : A, B ou NULL. A : 
- codepost (VARCHAR)
- destination (VARCHAR)
- provenance (VARCHAR)

Base : mco_decennale
Table : diag
Colonnes :
- ident (VARCHAR)
    FOREIGN KEY : valeur unique par séjour, correspond à `ident` de la table fixe.
- diag (VARCHAR)
    Un code CIM-10 version française ATIH, environ 42000 valeurs distinctes possibles. Exemple : A001.
- typ_diag (VARCHAR)
    Catégories : 1, 2, 3, 4 ou 5. 1 : diagnostic principal (DP) du séjour, 2 : diagnostic relié (DR) du séjour, 3 : DP de RUM considéré DAS de séjour, 4 : DR de RUM considéré DAS de séjour, 5 : diagnostic associé significatif (DAS).
- rum (INTEGER)
    Entier positif de 1 à N RUM. Un numéro de RUM (résumé d'unité médical) par passage dans une unité médicale (UM) dans le séjour, l'ensemble formant le séjour. 