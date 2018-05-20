<?php
/** 
 * Configures wordpress 
 */

$realpath = dirname(__FILE__);

// Absolute path to the wordpress directory. 
if (!defined('ABSPATH')) {
    define('ABSPATH', $realpath . '/');
}

$mainConfigFile = ABSPATH . '../../main-config.php';

if (!file_exists($mainConfigFile)) {
    die('Somethings wrong with something!');
}

require_once $mainConfigFile;

define('WP_HOME', $wp_home);
define('WP_SITEURL', $wp_home . '/wp');
define('WP_CONTENT_DIR', $realpath . '/content');
define('WP_LANG_DIR', WP_CONTENT_DIR . '/languages');
define('WP_CONTENT_URL', WP_HOME . '/content');
define('WP_PLUGIN_DIR', WP_CONTENT_DIR . '/plugins');
define('WP_PLUGIN_URL', WP_CONTENT_URL . '/plugins');

// Sets up wordpress vars and included files.
require_once ABSPATH . 'wp-settings.php';