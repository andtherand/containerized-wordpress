<?php
/**
 * Tells wordpress to load the wordpress theme and output it.
 *
 * @var bool
 */

define('WP_USE_THEMES', true);

// Loads the wordpress Environment and Template
require dirname(__FILE__) . '/wp/wp-blog-header.php';
