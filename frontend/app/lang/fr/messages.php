<?php

return array(

	'account_creation_failed' => 'Could not create account.',
	'account_update_failed' => 'Could not update account.',
	'invalid_credentials' => 'Your credentials are invalid.',
	'note_version_info' => 'You are previewing an older version of this note.',
	'found_bug' => 'Found a bug? <a href="https://github.com/twostairs/paperwork/issues/new" target="_blank" title="Submit Issue">Submit it on GitHub!</a>',
	'new_version_available' => 'Found a bug? It seems like you are not running the latest version of Paperwork. Please consider updating before submitting an issue. ',
	'error_version_check' => 'Found a bug? Paperwork cannot check whether your version is the latest. Please make sure you are running the latest version before reporting any issues. ', 
	'error_message' => 'Whooops!',
	'onbeforeunload_info' => 'Data will be lost if you leave the page, are you sure?',
	'user' => array(
		'settings' => array(
			'language_label' => 'Language',
			'client_label' => 'Client',
			'import_slash_export' => 'Import/Export',
			'language' => array(
				'ui_language' => 'Langage de l\'interface utilisateur',
				'document_languages' => 'Langages des documents',
				'document_languages_description' => 'The languages you select here will be used for parsing text within attachments you upload, allowing you to search for the content of these. An attachment could be a photo of a document you took with your smartphone, for example. Select the languages these documents are usually written in.',
			),
			'client' => array(
				'qrcode' => 'QR Code',
				'scan' => 'Scannez ce QR code avec votre application mobile pour configurer automatiquement votre compte Paperwork.'
			),
			'import' => array(
				'evernotexml' => 'Importer un fichier XML de Evernote:',
				'upload_evernotexml' => 'Importez votre export Evernote XML ici, pour importer vos notes Evernote dans Paperwork.'
			),
			'export' => array(
				'evernotexml' => 'Exporter un fichier XML de Evernote:',
				'download_evernotexml' => 'Download an ENEX file compatible with Evernote to move your notes from Paperwork. '
			)
		)
	)
);
