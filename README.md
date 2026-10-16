# Lavagna Progetti

Una lavagna di foglietti per raccogliere e categorizzare le idee, più un diagramma di Gantt su cui trascinarle per pianificarle e assegnarle alle persone.

È una pagina statica (`index.html`), pensata per GitHub Pages. I dati condivisi stanno su Supabase. Senza Supabase, la pagina funziona lo stesso ma salva solo nel browser di chi la usa.

## Cosa si può fare

- **Lavagna:** le idee sono foglietti, in colonne per categoria. Trascinando un foglietto su un'altra colonna se ne cambia la categoria.
- **Diagramma:** si trascina un'idea sulla linguetta "Diagramma" oppure dal pannello "Idee da pianificare" su una riga. La data dipende da dove la si lascia, la riga decide la persona (o la categoria).
- **Barre:** si spostano trascinandole, si allungano o accorciano dai bordi. Riportate nel pannello o sulla linguetta "Lavagna" tornano idee.
- **Scale:** Giorni, Settimane e Mesi; in tutte si vede ogni singolo giorno.
- **Dettagli:** con un clic su un foglietto o su una barra si modificano titolo, note, categoria, persona, date e avanzamento.
- **Persone e categorie:** si gestiscono dal pulsante in alto, con nome e colore.

## Configurare Supabase

1. Crea un progetto gratuito su [supabase.com](https://supabase.com).
2. In **SQL Editor** incolla ed esegui `supabase/schema.sql`.
3. In **Project Settings → API** copia il **Project URL** e la chiave pubblica (`anon public` o `publishable`).
4. Inseriscili in `config.js`:

   ```js
   window.LAVAGNA_CONFIG = {
     supabaseUrl: 'https://xxxx.supabase.co',
     supabaseAnonKey: '...',
   };
   ```

La chiave pubblica finisce nella pagina ed è leggibile da chiunque la apra: è normale per Supabase. Non usare mai la chiave `service_role`/`secret`.

**Accesso:** non c'è login. Chi conosce l'indirizzo della pagina può leggere e modificare la lavagna.

## Pubblicare su GitHub Pages

1. In **Settings → Pages** del repository scegli **Deploy from a branch**.
2. Seleziona il branch con questi file e la cartella `/ (root)`.
3. La pagina sarà su `https://<utente>.github.io/<repository>/`.

Su un account GitHub gratuito, Pages funziona solo con repository pubblici.

## Provarla in locale

```sh
python3 -m http.server 8000
```

poi apri `http://localhost:8000`.
