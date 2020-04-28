/**
 * WordPress dependencies
 */
import { addAction } from '@wordpress/hooks';

/**
 * Internal dependencies
 */
import setupJetpackEditor from './jetpack-editor-setup';

addAction( 'native.render', 'core/react-native-editor', ( props ) => {
	console.log( 'rendered from gutenberg-mobile', props );
	setupJetpackEditor( props.jetpackState || { blogId: 1, isJetpackActive: true } );
} );

require( '@wordpress/react-native-editor' );

