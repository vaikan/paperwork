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
				'ui_language' => 'Мова інтерфейсу',
				'document_languages' => 'Мови документів',
				'document_languages_description' => 'Мови, що ви виберете тут, будуть використані для розпізнавання тексту в файлах, що ви завантажуєте, дозволяючи пошук по їхньому вмістові. Наприклад, прикладеним файлом може бути фото документу, що ви зробили за допомогою смартфону. Виберіть мови, які зазвичай використовуються у цих документах.',
			),
			'client' => array(
				'qrcode' => 'QR Код',
				'scan' => 'Відскануйте QR код за допомогою мобільного додатку для автоматичної конфігурації облікового запису Paperwork.'
			),
			'import' => array(
				'evernotexml' => 'Evernote XML:',
				'upload_evernotexml' => 'Завантажте ваш експортований Evernote XML, щоб імпортувати нотатки з Evernote в Paperwork.'
			),
			'export' => array(
				'evernotexml' => 'Evernote XML:',
				'download_evernotexml' => 'Завантажити ENEX файл сумісний з Evernote щоб перенести ваші нотатки з Paperwork.'
			)
		)
	)
);
