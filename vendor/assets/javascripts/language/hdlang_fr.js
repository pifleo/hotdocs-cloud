// HotDocs Browser Language Module: German (generic/experimental)

/* language\hdlang_fr.js */
var HOTDOC$ = window.HOTDOC$ || {}; // namespace object for HotDocs Server interviews
if (!HOTDOC$.Locales) HOTDOC$.Locales = {};
// Register the new language module with the HotDocs locale infrastructure
HOTDOC$.Locales["fr-FR"] = {
  name: "French",
  // Date & Number formatting info
  dateOrder: "DMY",
  shortDateFormat: "dd.MM.yyyy",
  months: ["Janvier", "Février", "Mars", "Avril", "Mai", "Juin", "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"],
  monthsShort: ["Jan", "Fév", "Mar", "Avr", "Mai", "Juin", "Juil", "Août", "Sept", "Oct", "Nov", "Déc"],
  days: ["Dimanche", "Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi"],
  daysShort: ["Dim", "Lun", "Mar", "Mer", "Jeu", "Ven", "Sam"],
  //yearPrefix: ["Ein", "Zwei"],
  calWeekBegin: 1,
  calWeekend: [0, 6],
  zeroFormats: ["Zéro"],
  numSeps: [",", " "], // first is decimal separator, followed by thousands separator
  // Localizable Strings

  strings: {
    // various standard user interface elements:
    ui_hd: "HotDocs", // used in the title bar of error message boxes, where possible
    ui_hdvers: "HotDocs Browser Interview Runtime version", // HotDocs Browser Interview Runtime version
    ui_logo: "Propulsé par HotDocs Server", // Powered by HotDocs Server
    ui_load: "Chargement de l'Interview HotDocs...", // Loading HotDocs Interview...
    ui_addl: "Des composants additionnels sont téléchargés ...", // Additional components are downloading...
    ui_wait: "Veuillez patienter", // Please wait
    ui_wait_cmp: "Merci de patienter pendant que d'autres composants sont téléchargés ...", // Please wait while additional components are downloaded...
    ui_help: "Aide HotDocs Server", // HotDocs Server Help
    ui_helpcaption: "Aide", // Help
    ui_io: "Structure du Questionnaire", // Interview Outline
    ui_yes: "Oui", // Yes
    ui_no: "Non", // No
    ui_other: "Autre", // Other
    ui_nota: "Aucune de ces réponses", // None of the Above
    ui_cal: "Calendrier", // Calendar
    ui_ssbedit: "Editer la ligne", // Edit Row
    ui_ssbins: "Insérer une ligne", // Insert Row
    ui_ssbdel: "Effacer la ligne", // Delete Row
    ui_rownum: " [Ligne {0}]", // [Row {0}] (appended to dialog title during "edit row" operations)
    ui_rownew: " [Nouvelle Ligne]", // [New Row] (appended to dialog title during "edit row" operations)
    ui_new: "Nouveau", // New (prefix for unanswered dialog iterations)
    ui_rtntiv: "Retour au questionnaire", // Back to Interview
    ui_sresult: "Résultats du serveur", // Server Results (default title for server results pane, not typically seen but possible with JS API)
    ui_select: "Sele&ct", // Sele&ct
    ui_selectcaption: "Choisissez parmi les sources de réponses", // Select from Answer Source
    ui_cancel: "Annuler", // Cancel
    ui_addbtn: "&Ajouter une autre", // Add Another
    ui_mnutt: "Menu Dialogue", // Dialog Menu
    ui_err: "Erreur", // Error
    ui_close: "Fermer", // Close
    ui_emptydlg: "Dialogue vide", // Empty Dialog
    ui_etc: ", etc.", // etc.
    ui_dataload: "Chargement des données...", // Loading data...

    // Interview Help page
    hlp_to: "Pour", // To
    hlp_do: "Faire", // Do This
    hlp_intro: "Ce guide décrit comment effectuer une interview HotDocs Server depuis un navigateur web. HotDocs Server est la version de HotDocs qui utilise un navigateur Web standard pour afficher les interviews HotDocs, ou des séances de collecte de réponses. Ces réponses sont ensuite utilisées pour assembler des documents sur un serveur Web. (Pour plus d'informations sur HotDocs Server, visitez <a href='http://www.hotdocs.com' target='_blank'>www.hotdocs.com</a> .)",
    hlp_intro2: "Lorsque vous sélectionnez un modèle pour l'assemblage, HotDocs Server présente une interview dans le navigateur Web pour recueillir des réponses requises par le modèle. Pour vous aider à répondre aux questions, la fenêtre d'interview est divisés en trois volets: la présentation de la structure du questionnaire, le volet de dialogue, et le volet des ressources. La structure du questionnaire donne un aperçu des questions auxquelles vous devez répondre, tandis que le volet de dialogue affiche les questions spécifiques. Le volet des ressources fournit des informations utiles pour vous aider à répondre à des questions ou des dialogues spécifiques.",
    hlp_io_ovw: "La structure du questionnaire répertorie toutes les boîtes de dialogue (ou groupes de questions) de l'interview et vous permet de vous déplacer rapidement à n'importe quel dialogue dont vous avez besoin dans l'interview. Lorsque vous cliquez sur le nom d'une boîte de dialogue, la boîte de dialogue apparaît dans le volet dialogue afin que vous puissiez répondre aux questions qui la composent.",
    hlp_io_tbl: "Les icônes suivantes sont utilisées dans la structure du questionnaire pour montrer l'état des questions dans chaque boîte de dialogue, et peut vous aider à déterminer quels dialogues contiennent des questions auxquelles vous devez encore répondre: ",
    hlp_io_du: "Aucune des questions dans la boîte de dialogue n'a de réponse.", // None of the questions in the dialog are answered.
    hlp_io_dn: "Une nouvelle répétition d'un dialogue dans lequel aucune des questions n'a de réponse.", // A new repetition of a repeated dialog in which none of the questions are answered.
    hlp_io_dp: "Au moins une des questions posées dans la boîte de dialogue a une réponse.", // At least one of the questions in the dialog is answered.
    hlp_io_da: "Toutes les questions requises dans la boîte de dialogue ont une réponse.", // All required questions in the dialog are answered.
    hlp_io_dr: "Le dialogue contient au moins une question requise sans réponse.", // The dialog contains at least one unanswered required question.
    hlp_io_dug: "Le dialogue ne peut accepter de réponses tant que les questions requises dans les dialogues précédents n'ont pas de réponses.", // The dialog cannot be answered until required questions in previous dialogs are answered.
    hlp_io_loc: "Par défaut, la structure de l'interview apparaît à gauche de la fenêtre de dialogue, mais vous pouvez modifier sa largeur ou sa position si nécessaire. Par exemple, si vous avez besoin de plus d'espace pour répondre à des questions dans le volet de dialogue, vous pouvez réduire ou masquer la structure de l'interview. Le tableau suivant montre comment modifier la largeur et la position du contour de l'interview: ", // By default, the interview outline appears to the left of the dialog pane, but you can change its width or position as needed. For example, if you need more space for answering questions in the dialog pane, you can shrink or hide the interview outline. The following table shows how to change the width and position of the interview outline:
    hlp_io_widT: "Modifier la largeur de la partie structure de l'interview", // Change the width of the interview outline
    hlp_io_widD: "Faites glisser le séparateur entre le volet avec la structure de l'interview et le volet de dialogue.", // Drag the border separating the interview outline and dialog pane.
    hlp_io_clsT: "Fermer la structure du questionnaire",
    hlp_io_clsD: "Cliquez sur le bouton <b>{0}Fermer</b> dans le coin haut droit de la structure du questionnaire. Pour l'afficher à nouveau, cliquez sur le bouton <b>{1}Afficher la structure du questionnaire</b>.",
    hlp_io_vdlT: "Voir la structure du questionnaire sous forme de liste",
    hlp_io_vdlD: "Quand la structure du questionnaire est masquée, cliquez sur la flèche à côté du bouton <b>{0}Afficher la structure du questionnaire</b>. Quand la liste apparaît, cliquez sur un titre de dialogue pour aller vers ce dialogue.",
    hlp_dp: "Boîtes de dialogue",
    hlp_dp_ovw: "Les questions auxquelles vous devez répondre sont présentées dans des boîtes de dialogue. Certaines questions apparaissent plusieurs fois comme une série de dialogues ou comme un tableau de données. Cela permet d'entrer plusieurs réponses pour une même question, en créant ainsi une liste de réponses. Enfin, certaines questions apparaissent dans un dialogue imbriqué. Les dialogues imbriqués représentent généralement des questions qui dépendent les unes des autres ou qui sont liés à des questions dans la boîte de dialogue principale. Elles apparaissent généralement comme une icône dans la boîte de dialogue principale, mais elles peuvent aussi apparaître comme un tableau de données dans la boîte de dialogue principale.",
    hlp_dp_tbl: "Le tableau suivant vous montre comment naviguer entre les boîtes de dialogue et répondre à plusieurs types de questions :",
    hlp_dp_txtT: "Champs texte",
    hlp_dp_txtD: "Entrez votre réponse dans un champ texte.",
    hlp_dp_chkT: "Cases à cocher et choix d'options",
    hlp_dp_chkD: "Cochez la case avec votre souris ou appuyez sur la barre d'espace.",
    hlp_dp_calT: "Questions date",
    hlp_dp_calD: "Cliquez sur le bouton <b>{0}Calendrier</b> et choisissez une date. Vous pouvez aussi appuyer sur la touche <b>T</b> pour avoir la date d'aujourd'hui ou entrer une date manuellement sous le format : <i>3/6/90</i>, <i>03/06/1990</i>, <i>3 Juin 1990</i> etc.",
    hlp_dp_rptT: "Questions répétées dans la même boîte de dialogue",
    hlp_dp_rptD: "Répondez à toutes les questions dans la boîte de dialogue, puis cliquez sur le bouton <b>{0}Ajouter une autre</b> pour ajouter une autre répétition de la boîte de dialogue. Le nombre de répétitions à côté de l'icône dialogue augmente à chaque fois que vous entrez un nouveau lot de réponses. Pour aller à la boîte de dialogue suivante après avoir entré toutes les réponses dans la liste, cliquez sur <b>Suivant</b> dans la barre de navigation.",
    hlp_dp_sprT: "Réponses dans un tableau de données",
    hlp_dp_sprD: "Entrez chaque lot de données sur une ligne du tableau. Pour éditer une ligne de réponses, cliquez sur <b>{0}</b>. Pour insérer une nouvelle ligne entre deux lots de données, cliquez sur <b>{1}</b>. Pour supprimer un lot de réponses, cliquez sur <b>{2}</b>.",
    hlp_dp_nstT: "Questions dans une boîte de dialogue imbriquée",
    hlp_dp_nstD: "Cliquez sur l'icône dialogue. Quand vous avez terminé de répondre aux questions, vous pouvez soit cliquer sur le bouton <b>{0}Suivant</b> dans la barre de navigation, soit cliquer sur la boîte de dialogue principale dans la structure du questionnaire sur la gauche.",
    hlp_dp_nxdT: "Boîte de dialogue suivante ou précédente",
    hlp_dp_nxdD: "Cliquez soit sur le bouton <b>{0}Suivant</b> soit sur le bouton <b>{1}Précédent</b>. (Vous pouvez aussi appuyer sur les boutons <b>Page Down/Page Up</b> ou <b>Alt+N/Alt+P</b>.)",
    hlp_dp_nxuT: "Aller à la boîte de dialogue suivante ou précédente, qui contient une question sans réponse",
    hlp_dp_nxuD: "Cliquez soit sur le bouton <b>{0}Dialogue sans réponse suivant</b> ou sur le bouton <b>{1}Dialogue sans réponse précédent</b>. (Vous pouvez aussi appuyer sur les boutons <b>Ctrl+Page Down/Ctrl+Page Up</b>.)",
    hlp_dp_frsT: "Aller à la première ou dernière boîte de dialogue de l'interview",
    hlp_dp_frsD: "Cliquez soit sur le bouton <b>{0}Première</b> ou <b>{1}Dernière</b>. (Vous pouvez aussi appuyer sur les boutons <b>Alt+R/Alt+L</b>.)",
    hlp_dp_finT: "Terminer l'interview",
    hlp_dp_finD: "Cliquez sur le bouton <b>{0}Terminer</b>",
    hlp_rp: "Aide contextuelle",
    hlp_rp_intro: "Il arrive parfois que l'auteur de l'interview propose des aides contextuelles (ou de l'information) pour vous aider à répondre à un question dans une boîte de dialogue. Par exemple, lire un certain article de loi vous aiderait à répondre à une question bien spécifique. Quand une aide contextuelle est disponible, elle apparaît dans le volet d'aide situé tout en bas, sous la boîte de dialogue.",
    hlp_rp_how: "Pour afficher ou masquer le volet d'aide, cliquez sur le bouton <b>{0}Afficher/masquer le volet d'aide</b>. Quand le volet d'aide est affiché, vous pouvez y voir l'aide contextuelle de la question en cours dans la boîte de dialogue. (Si une question n'a pas d'aide contextuelle disponible, le volet d'aide est vide.) D'autre part, vous pouvez cliquer sur le bouton <b>{1}Voir l'aide</b> à côté de chaque question qui dispose d'une aide contextuelle pour voir le contenu dans une fenêtre séparée.",
    hlp_rp_note: "Note : le volet d'aide n'est pas forcément disponible dans toutes les situations. Par exemple, l'auteur de l'interview peut choisir de masquer de façon permanente le volet d'aide d'une interview.",

    // various strings needed for formatting
    ui_and: "et", // and
    ui_or: "ou", // or
    ui_minus: "moins", // minus
    ui_percent: "pourcent", // percent
    ui_true: "vrai", // true
    ui_false: "faux", // false

    // answer summaries:
    ui_as: "Résumé des Réponses HotDocs", // HotDocs Answer Summary (answer summary title when printing)
    ui_astitle: "Modèle : ", // Template:
    ui_print: "Imprimer", // Print

    // toolbar button tooltips & status bar messages
    tb_as: 'Résumé des Réponses', // Answer Summary
    tb_ast: 'Afficher un résumé de toutes les réponses saisies dans cet interview.', // Display a summary of all answers entered in this interview.
    tb_sv: 'Enregistrer les réponses', // Save Answers
    tb_svt: 'Enregistrer les réponses actuelles.', // Save the current answers.
    tb_dp: 'Aperçu du Document', // Document Preview
    tb_dpt: 'Afficher un aperçu approximatif du document final.', // Display an approximate preview of the finished document.
    tb_ol0: 'Masquer la Structure du Questionnaire', // Hide Interview Outline
    tb_ol1: 'Afficher la Structure du Questionnaire', // Show Interview Outline
    tb_ol2: 'Afficher/Masquer la Structure du Questionnaire', // Show/Hide Interview Outline
    tb_ol3: 'Dérouler la Structure du Questionnaire', // Show Drop-down Interview Outline
    tb_olt: 'Activer ou Désactiver la Structure du Questionnaire.', // Toggle the Interview Outline on or off.
    tb_od: 'Afficher la Structure du Questionnaire', // Show Interview Outline
    tb_odt: 'Afficher la liste déroulante de la Structure du Questionnaire.', // Show the Interview Outline drop-down.
    tb_iu0: 'Désactiver la mise à jour instantanée', // Disable Instant Update
    tb_iu1: 'Activer la mise à jour instantanée', // Enable Instant Update
    tb_iut: 'Activer ou Désactiver la mise à jour instantanée du questionnaire.', // Toggle Instant Update of interview outline on or off.
    tb_pg0: 'Questionnaire Multi-page', // Multi-page Interview
    tb_pg1: 'Questionnaire Une-page', // Single-page Interview
    tb_pgt: 'Basculer entre le questionnaire Multi-page et Une-page.', // Toggle between Multi-page and Single-page interview.
    tb_rs0: 'Masquer le volet d\'aide', // Hide Resource Pane
    tb_rs1: 'Afficher le volet d\'aide', // Show Resource Pane
    tb_rst: 'Basculer entre l\'affichage des aides dans des fenêtres séparées ou le volet d\'aide.', // Toggle between showing resources in Pop-up windows or the Resource Pane.
    tb_hlp: 'Afficher la page d\'aide du Serveur HotDocs.', // Display the HotDocs Server help page.

    // dialog navigation
    // (button captions beginning with navb_ can have keyboard shortcuts designated with an & sign,
    //  but these keyboard shortcuts only work in JavaScript interviews -- not Silverlight.)
    navb_First: "Pr&emier", // Fi&rst
    navb_Prev: "&Précédent", // &Previous
    navb_Next: "&Suivant", // &Next
    navb_Last: "&Dernier", // &Last
    navb_Finish: "Term&iner", // Finish
    nav_First: "Première boîte de dialogue", // First Dialog (command name for First button)
    nav_PrevU: "Boîte de Dialogue sans Réponse Précédente", // Previous Unanswered Dialog (command name for Previous Unanswered button)
    nav_Prev: "Boîte de dialogue précédente", // Previous Dialog (command name for Previous button)
    nav_Next: "Next Dialog", // Next Dialog (command name for Next button)
    nav_NextU: "Boîte de Dialogue sans Réponse Suivante", // Next Unanswered Dialog (command name for Next Unanswered button)
    nav_Last: "Dernière Boîte de Dialogue", // Last Dialog (command name for Last button)
    nav_Finish: "Terminer l'interview", // Finish Interview (tooltip for Finish button)
    nav_FinEM: "Terminer la modification de lignes / Retour à la liste", // Finish Editing Rows / Return to List (tooltip for Finish Edit Mode button)
    nav_FinPopup: "Retour au questionnaire parent", // Return to parent interview (Tooltip for the FinishPopup button)
    nav_leave: "Cette action mettra fin à l'interview, et les réponses que vous avez saisies seront perdues. Cliquez sur les boutons Suivant ou Précédent en bas de page pour vous déplacer dans le questionnaire. Si vous avez terminé de répondre aux questions, cliquez sur Terminer pour terminer l'interview et soumettre vos réponses.", // This will terminate the interview, and any answers you have entered will be lost. Click the Next or Previous buttons at the bottom of the page to move through the interview. If you are finished answering questions, click Finish to complete the interview and submit your answers.
    nav_warnfin: "Il s'agit de la dernière boîte de dialogue du questionnaire.", // This is the last dialog of the interview.
    nav_warnfin_unans: "Vous avez {0} question(s) sans réponse", // You have {0} unanswered question(s)
    nav_warnfin_ok: "Cliquez sur OK lorsque vous avez terminé l'interview et que vous voulez soumettre vos réponses. Cliquez sur Annuler pour revenir à l'interview.", // Click OK when you are done with the interview and want to submit your answers. Click Cancel to return to the interview.

    // Various UI tooltips documenting keyboard accelerators
    uitt_First: "Première Boîte de Dialogue (Ctrl+Home)", // First Dialog (Ctrl+Home)
    uitt_PrevU: "Boîte de Dialogue sans Réponse Précédente (Ctrl+Page Up)", // Previous Unanswered Dialog (Ctrl+Page Up)
    uitt_Prev: "Boîte de Dialogue Précédente (Page Up)", // Previous Dialog (Page Up)
    uitt_Next: "Boîte de Dialogue Suivante (Page Down)", // Next Dialog (Page Down)
    uitt_NextU: "Boîte de Dialogue sans Réponse Suivante (Ctrl+Page Down)", // Next Unanswered Dialog (Ctrl+Page Down)
    uitt_Last: "Dernière boîte de dialogue (Ctrl+End)", // Last Dialog (Ctrl+End)
    uitt_ssbedit: "Editer la Ligne (Ctrl+Enter)", // Edit Row (Ctrl+Enter)
    uitt_ssbins: "Insérer une Ligne (Ctrl+Insert)", // Insert Row (Ctrl+Insert)
    uitt_ssbdel: "Effacer une Ligne (Ctrl+Delete)", // Delete Row (Ctrl+Delete)

    // HotDocs resource-related language
    rs_bcap: "Afficher l'aide contextuelle'", // View Resource
    rs_dis: "Voir chaque {0} pour les aides contextuelles disponibles", // See individual {0} for available resources
    rs_cols: "colonnes", // columns
    rs_opts: "options", // options
    rs_opt: "option", // option
    rs_fld: "champ réponse", // answer field
    rs_dlg: "boîte de Dialogue", // dialog
    rs_ind: "{0}{1}{2} pour {3}", // {0}{1}{2} for {3}: {0} & {2} are begin/end hyperlink markup, {1} is [rs_bcap], {3} is [rs_opt]/[rs_fld]/[rs_dlg].

    // validation messages
    val_invdate: "Veuillez entrer une date valide.", // Please enter a valid date.
    val_invnum: "Veuillez entrer un nombre", // Please enter a number.
    val_numrng: "Veuillez entrer un nombre entre {0} et {1}.", // Please enter a number between {0} and {1}.
    val_numlt: "Veuillez entrer un nombre qui est inférieur ou égal à {0}.", // Please enter a number that is less than or equal to {0}.
    val_numgt: "Veuillez entrer un nombre qui est supérieur ou égal à {0}.", // Please enter a number that is greater than or equal to {0}.
    val_reqg: "Une ou plusieurs questions sont obligatoires et demandent une réponse avant que vous puissiez terminer l'interview.", // One or more questions are required and must be answered before you can complete the interview.
    val_reqp: "Une ou plusieurs questions sont obligatoires et demandent une réponse avant que vous puissiez continuer.", // One or more questions are required and must be answered before you can proceed.
    val_reqd: "Une ou plusieurs questions dans le dialogue {0} sont obligatoires et demandent une réponse avant que vous puissiez continuer.", // One or more questions in the {0} dialog are required and must be answered before you can proceed.
    val_rptlim: "Vous pouvez entrer seulement {0} ensembles de réponses pour ce dialogue.", // You can enter only {0} sets of answers for this dialog.
    val_repdel: "Etes-vous sûr de vouloir supprimer cette répétition ?", // Are you sure you want to delete this repetition?
    val_err: "Vous devez régler une ou plusieurs erreurs de saisie avant de pouvoir continuer.", // You must resolve one or more input errors before you can proceed.
    val_wait: "Merci de patienter pendant que vos réponses sont traitées.", // Please wait while your answers are being processed.

    // context menu items
    hdmnuClearAns: "Effacer la Réponse", // Erase Answer
    hdmnuCut: "Couper", // Cut
    hdmnuCopy: "Copier", // Copy
    hdmnuPaste: "Coller", // Paste
    hdmnuDel: "Effacer", // Delete
    hdmnuSelAll: "Sélectionner Tout", // Select All
    hdmnuEditRow: "Editer la Ligne", // Edit Row
    hdmnuInsRow: "Insérer une ligne", // Insert Row
    hdmnuDelRow: "Effacer la ligne", // Delete Row
    hdmnuMoveRowUp: "Déplacer la Ligne vers le Haut", // Move Row Up
    hdmnuMoveRowDn: "Déplacer la Ligne vers le Bas", // Move Row Down
    hdmnuClearDlg: "Effacer les Réponses", // Erase Answers
    hdmnuInsRep: "Insérez une Répétition", // Insert Repetition
    hdmnuDelRep: "Effacer une Répétition", // Delete Repetition
    hdmnuMoveUp: "Déplacer la Répétition vers le Haut", // Move Repetition Up
    hdmnuMoveDn: "Déplacer la Répétition vers le Bas", // Move Repetition Down
    hdmnuNewRep: "Nouvelle Répétition", // New Repetition
    hdmnuEraseAllAns: "Effacer toutes les Réponses", // Erase All Answers

    // regular expressions used for parsing date input (appropriate for localization)
    dateparse_today: "(a|aujourd'hui)", //when dates are entered, users can instead enter a "T" or "TODAY" as a shortcut to today's date
    dateparse_days: "(d|jour|jours)", //if the user enters a T, it can optionally be followed by +/- num days/months/years. If the desired unit is days, it can be designated with any of these strings
    dateparse_months: "(m|mois)", //if the user enters a T, it can optionally be followed by +/- num days/months/years. If the desired unit is months, it can be designated with any of these strings
    dateparse_years: "(a|année|annee|années|annees)", //if the user enters a T, it can optionally be followed by +/- num days/months/years. If the desired unit is years, it can be designated with any of these strings
    // simple "today"-based date arithmetic is possible (and localized) during date input, because simple
    // date expressions are parsed using a regular expression built out of the above pieces:
    // "^{dateparse_today}\s*([+-])\s*(\d+)\s*({dateparse_days}|{dateparse_months}|{dateparse_years})$"

    // user-facing error messages (appropriate for localization)
    err_invint: "Invalide Interview: Le dialogue actuel ne peut pas être affichée <br> Vous pouvez toujours cliquer sur le bouton Terminer ci-dessous si vous souhaitez <br> présenter les résultats de cette interview!.", // Invalid Interview: The current dialog cannot be displayed!<br>&nbsp;<br>You may still click the Finish button below if you want to<br>submit the results of this interview.
    err_vers: 'Cette interview HotDocs (HDVers={0}) est incompatible avec le HotDocs Server interview runtime ({1}).', // This HotDocs interview (HDVers={0}) is incompatible with the current HotDocs Server interview runtime ({1}).
    err_slv: "Cette interview HotDocs Server nécessite Microsoft Silverlight version 3.0 ou ultérieure.", // This HotDocs Server interview requires Microsoft Silverlight version 3.0 or later.
    err_type: "Invalid Interview Type: {0}",
    err_load: 'Erreur: {0} a échoué à charger correctement.', // Error: {0} failed to load properly.
    err_noint: 'Interview incorrecte: il n\'y a rien à afficher!', // Invalid Interview: There is nothing to display!
    err_print: "L'impression a échoué en raison des restrictions de sécurité de votre navigateur.", // Printing failed due to your browser's security restrictions.
    err_mustret: "Vous devez revenir à l'interview avant d'effectuer cette action.", // You must return to the interview before performing this action.
    err_rowclck: "Merci de cliquer dans une cellule du tableau pour choisir une ligne.", // Please click in a table cell to choose a current row.
    err_nest: "Interview invalide: les instructions REPEAT sont imbriquées sur plus de 4 niveaux de profondeur.", // Invalid Interview: REPEAT instructions are nested more than 4 levels deep.
    err_cantadd: "Vous devez répondre à au moins une question dans cette boîte de dialogue avant de pouvoir ajouter une autre boîte de dialogue.", // You must answer at least one question in this dialog before you can add another dialog.
    err_brows: "Erreur du Navigateur Web", // browser error
    err_browsm: "Vous tentez d'utiliser une interview HotDocs Server sur une plate-forme ou un navigateur non pris en charge, l'entretien peut ne pas s'afficher correctement. Continuer malgré tout?", // You are attempting to use a HotDocs Server interview on an unsupported browser or platform; the interview may not appear correctly. Continue anyway?
    err_browssl: "HotDocs Server Silverlight interviews ne sont pris en charge que dans Internet Explorer (Windows), Chrome (Windows), Firefox (Windows or Mac), and Safari (Mac uniquement).", // HotDocs Server Silverlight interviews are only supported in Internet Explorer (Windows), Chrome (Windows), Firefox (Windows or Mac), and Safari (Mac only).
    err_browsjs: "HotDocs Server JavaScript interviews nécessite Microsoft Internet Explorer 6.0 ou une version ultérieure.", // HotDocs Server JavaScript interviews require Microsoft Internet Explorer 6.0 or later.
    err_unk: "Erreur Inconnu", // unknown error
    err_dtype: "Veuillez vous assurer que la page héberge cette interview utilise un DOCTYPE strict: comme &lt;!DOCTYPE html&gt;.",
    err_compat: "Votre navigateur semble fonctionner dans le mode IE Affichage de compatibilité. Merci de désactiver l'affichage de compatibilité pour ce site et essayez à nouveau.",
    err_handler: "Une erreur s'est produite lors de l'enregistrement des handlers pour le(s) '{0}' événement(s).",
    err_baseclass: "An error occurred while extending base classes.",
    err_siteadm: "Merci de prévenir l'administrateur du site.",
    err_invprm: "Paramètre Non Valide",
    err_invprm_tb: "Impossible d'ajouter un bouton de barre d'outils: un paramètre est invalide pour AddCustomToolbarButton.",
    err_invprm_nb: "Impossible d'ajouter un bouton de barre de navigation: un paramètre est invalide pour AddCustomNavButton.",
    err_invprm_img: "Failed to set toolbar button image: invalid parameters to SetToolbarButtonImage.",
    err_noastest: "Answer sources based on answer files are not available during test in browser.",

    err_proc: "Failed to process the {0}() for the template '{1}'.",
    err_nocmp: "The component '{0}' does not exist.",
    err_idxgt0: "Index must be greater than or equal to 0.",
    err_emptyrptstk: "Cannot modify empty repeat stack",
    err_decidx: "Error: Unable to decrement a repeat index that is already at its lowest.",
    err_badrptstk: "Bad repeat stack: correct iteration of repeated dialog '{0}' not found.",
    err_badscrstk: "Bad script stack: dialog '{0}' not found.",
    err_limit: "Unable to set LIMIT; no dialog '{0}' found.",
    err_clear: "Unable to CLEAR options; multiple choice variable '{0}' not found.",
    err_grptf: "Cannot perform grouped true false operations on this type of node",
    err_grptf_un: "Cannot perform grouped true false operations on a dialog with ungrouped true false variables",
    err_invldloc: "Attempt to retrieve the Dialog Name from an invalid Interview Location object.",
    err_insrtlev: "There are too many INSERT levels in the template.",
    err_retrvbn: "Current Build Node cannot be retrieved unless an interview rebuild is in progress.",
    err_dateof: "Using the DATE OF function will create an invalid date. The first parameter must be in the range 1-31, the second 1-12, the third 1-9999, and the resulting date must be an actual calendar day.",
    err_setvar: "Tried to set an answer for something that was not a variable!",
    err_setdat: "Tried to set a date answer for something that was not a date variable!",
    err_settf: "Tried to set a true false answer for something that was not a true false variable or a dialog!",
    err_setmc: "Tried to set a multiple choice answer for something that was not a multiple choice variable!",
    err_retrvopt: "You can only retrieve options from multiple choice variables.",
    err_navstate: "Cannot update navigation state without a current dialog.",
    err_zeroiter: "Encountered a repeat node with zero iterations.",
    err_idxexceeds: "Index exceeds answered count.",
    err_nopath: "A navigation bar custom button image name must include a path.",
    err_serviceop: "Failed to define a data source for the following reason: ",
    err_datarequest: "Failed to download the data for a data source for the following reason: ",

    errnoact: "Interview could not be initialized: FormAction not specified.",
    errpath: "Interview could not be initialized: no {0} path was specified.",
    errdiv: "Error: Unable to render HotDocs interview because the interview container (hdMainDiv) does not exist on this page. Please contact your network administrator.",
    errinit: "Error: Interview attempted to start before initialization was complete. Please report situation to HotDocs development.",
    errslimg: "Silverlight supports only PNG and JPG images.  Has an invalid or missing image file been used?",
    errpoprslt: "Error: Attempted to pop an empty result stack.",
    errsetrslt: "Error: Attempt to set the top of an empty result stack.",
    errgetrslt: "Error: Attempt to get the top of an empty result stack.",
    errpopuans: "Error: Attempted to pop an empty unanswered stack.",
    errsetuans: "Error: Attempt to set the top of an empty unanswered stack.",
    errgetuans: "Error: Attempt to get the top of an empty unanswered stack.",
    errpop: "{0}: Pop of empty stack!",
    errget: "{0}: Get on empty stack!",
    badmojo: "Bad Mojo {0}: {1}!",
    errpoprpt: "Error: Unable to pop an empty repeat stack.",
    erraccrpt: "Error: Unable to access the top of an empty repeat stack.",
    errinfunc: "Error in {0}: {1}",

    vnf: "Var not found!",
    badcomp: "Inappropriate comparison.",
    txtcomp: "Inappropriate text comparison.",
    datecomp: "Inappropriate date comparison.",
    tmccomp: "Error: Invalid text-to-MC comparison.",
    mccomp: "Invalid MC to MC comparison.",
    dateop: "Error: Inappropriate operation on a date variable.",
    badtest: "Error: Testing an invalid variable or one that does not exist.",
    badcount: "Error: Invalid item passed to HDCount.",
    baddateof: 'Error: Invalid date used in "DATE OF" calculation.'

  },

  /*
  IsOrdinalSuffix: function(val, str)
  {
    // reports whether str begins with a valid ordinal suffix for val, and if so, returns the length of the suffix.
    // returns zero if str does not contain a valid ordinal suffix for val.
    return (str.charAt(0) == '.') ? 1 : 0;
  },

  GetOrdinalSuffix: function(val)
  {
    return ".";
  },
  */
  _zero: "null",
  _teens: ["zehn", "elf", "zwölf", "dreizehn", "vierzehn", "fünfzehn", "sechzehn", "siebzehn", "achtzehn", "neunzehn"],
  _ones: ["ein", "zwei", "drei", "vier", "fünf", "sechs", "sieben", "acht", "neun"],
  _tens: ["zwanzig", "dreißig", "vierzig", "fünfzig", "sechzig", "siebzig", "achtzig", "neunzig"],
  _hundred: "hundert",
  _one_Powers_Of_Ten: ["tausend", "e Million", "e Milliarde"],
  _mult_Powers_Of_Ten: ["tausend", " Millionen", " Milliarden"],
  _ord_Powers_Of_Ten: ["tausendste", " Millionste", " Milliardste"],
  _ord_Zero: "nullte",
  _ord_Ones: ["erste", "zweite", "dritte", "vierte", "fünfte", "sechste", "siebte", "achte", "neunte"],
  _ord_Teens: ["zehnte", "elfte", "zwölfte", "dreizehnte", "vierzehnte", "fünfzehnte", "sechzehnte", "siebzehnte", "achtzehnte", "neunzehnte"],
  _ord_Tens: ["zwanzigste", "dreißigste", "vierzigste", "fünfzigste", "sechzigste", "siebzigste", "achtzigste", "neunzigste"],
  _and: "und",
  _comma_Str: "komma",
  _eins_Str: "eins",
  /*
  SpellNum: function(amount, strZero, bOrdinal)
  {
    // NOTE: strZero is expected to be one of the "zeroFormats" array specified in this language module
    amount = parseInt(amount); // only handles integer input
    if (isNaN(amount))
    {
      return "";
    }

    var numStr = "",
      spaceStr = " ",
      space = "",
      useOrd, power, tempStr, strPiece, index, div1000, numPiece, tenPiece, powerPiece, ordWOPower, gtrOne;

    if (amount == 1 && !bOrdinal)
      return this._eins_Str;
    if (amount == 0)
      numStr = bOrdinal ? this._ord_Zero : this._zero;
    else if (amount > 100000000000)
      numStr = "grösser als 100 Milliarden";
    else
    {
      useOrd = bOrdinal;
      power = 0;
      while (amount != 0)
      {
        // strPiece is assigned one millenium with no leading or trailing blanks
        div1000 = parseInt(amount / 1000);
        numPiece = amount - (div1000 * 1000);
        amount = parseInt(amount / 1000);
        if (numPiece > 0)
        {
          strPiece = "";
          // as each piece is added, it must append a neccessary space or dash
          ordWOPower = useOrd && !power;
          gtrOne = numPiece > 1;
          if (numPiece > 99)
          {
            strPiece = (parseInt(numPiece / 100) > 1 || amount > 1) ? this._ones[parseInt(numPiece / 100) - 1] : "";
            //strPiece += " ";
            strPiece += this._hundred;
            numPiece %= 100;
            if (!power && numPiece)
              strPiece += spaceStr;
            else if (ordWOPower)
              strPiece += "ste";
          }
          if (numPiece > 19 || numPiece < 10)
          {
            tenPiece = parseInt(numPiece / 10);
            numPiece %= 10;
            if (numPiece)
            {
              index = numPiece - 1;
              strPiece += (ordWOPower && !tenPiece) ? this._ord_Ones[index] : this._ones[index];
            }
            if (tenPiece)
            {
              if (numPiece)
                strPiece += this._and;
              index = tenPiece - 2;
              strPiece += ordWOPower ? this._ord_Tens[index] : this._tens[index];
            }
          }
          else if (numPiece > 9)
          {
            index = numPiece - 10;
            strPiece += ordWOPower ? this._ord_Teens[index] : this._teens[index];
          }
          if (power)
          {
            if (useOrd)
              powerPiece = this._ord_Powers_Of_Ten[power - 1];
            else if (gtrOne)
              powerPiece = this._mult_Powers_Of_Ten[power - 1];
            else
              powerPiece = this._one_Powers_Of_Ten[power - 1];
            strPiece += powerPiece;
          }
          tempStr = numStr;
          numStr = strPiece;
          numStr += space;
          if (space === "" && power > 1)
            numStr += " ";
          numStr += tempStr;
          space = spaceStr;
          useOrd = false;
        }
        power++;
      }
    }

    // Trim trailing space, if any
    while (numStr[numStr.length - 1] == " ")
      numStr = numStr.substr(0, numStr.length - 1);

    return numStr;
  }
  */
};
