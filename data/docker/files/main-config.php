<?php

require_once(__DIR__ . '/vendor/autoload.php');
(new \Dotenv\Dotenv(__DIR__))->load();

ini_set('html_errors', getenv('WP_HTML_ERRORS'));

$wp_home = getenv('WP_HOME');
$table_prefix = getenv('DB_PREFIX');

define('DB_NAME', getenv('DB_NAME'));
define('DB_USER', getenv('DB_USER'));
define('DB_PASSWORD', getenv('DB_PASSWORD'));
define('DB_HOST', getenv('DB_HOST'));
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', 'utf8_general_ci');

// NO Theme or Plugin Editor
define('DISALLOW_FILE_EDIT', true);
define('WP_POST_REVISIONS', 5);
define('EMPTY_TRASH_DAYS', 28);

define('WPLANG', 'de_DE');
define('WP_DEBUG', getenv('WP_DEBUG'));
define('WP_AUTO_UPDATE_CORE', true);

require_once 'secrets.php';