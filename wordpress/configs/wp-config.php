<?php
/**
 * The base configuration for WordPress
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** MySQL database username */
define( 'DB_USER', 'wordpress' );

/** MySQL database password */
define( 'DB_PASSWORD', 'wordpress' );

/** MySQL hostname */
define( 'DB_HOST', 'wordpress-mysql' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8mb4' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         '^^ww@aSskl8/Ix$(eCBD~f={VnxO|zFuq@}ed+s?*)v{>D]I,Q-Md #r,fH.$n+E' );
define( 'SECURE_AUTH_KEY',  'Cwuf2~Uk084IIo~hGZ!H$Gn:9kX%zcFZ,p3?LeWo``Ex*bG:--%PSH)O0tgxqH.(' );
define( 'LOGGED_IN_KEY',    'Q*:3<|34BJ`NR>&Bm~2?12juN-Im}g0N2vQbng-=+wvaM$Z6>h._<DWncEkyj[z{' );
define( 'NONCE_KEY',        '2kdf@^phOgHxp/#E:c0vtYbY&*/yApx|{:) Qvpih205J(AzyL%T$NBBGyqnNf_*' );
define( 'AUTH_SALT',        'O]RASd5]@K5iaP5RaV,@,8:,S.B)XD(fQN(,MSgK,xGmu1/]@<dJMr0?VeO-h+m<' );
define( 'SECURE_AUTH_SALT', 'qxv2d6$`B~Th@nns2er65;14ng`2e7>eMeucGTg$2*T#/KXvu1YAg$i$ggyk]>%I' );
define( 'LOGGED_IN_SALT',   ' ]0@4ORz>92=k8Gg_,^]gAKXG.u6>@Ujxc],=(=qnoBIU83CB6[B)#77y]$D{LB`' );
define( 'NONCE_SALT',       '%f9v{( ea8($bl%wWs|&hj:A)xJ)J)&=qES(3U;QmVLvt$#:i-myi%dPohY^wBtt' );

/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* Add any custom values between this line and the "stop editing" line. */



/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
