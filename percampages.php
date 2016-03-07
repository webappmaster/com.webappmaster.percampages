<?php

require_once 'percampages.civix.php';

/**
 * Implements hook_civicrm_config().
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_config
 */
function percampages_civicrm_config(&$config) {
    _percampages_civix_civicrm_config($config);
}



/**
 * Implements hook_civicrm_xmlMenu().
 *
 * @param array $files
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_xmlMenu
 */
function percampages_civicrm_xmlMenu(&$files) {
    _percampages_civix_civicrm_xmlMenu($files);
}

/**
 * Implements hook_civicrm_install().
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_install
 */
function percampages_civicrm_install() {
    _percampages_civix_civicrm_install();
}

/**
 * Implements hook_civicrm_uninstall().
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_uninstall
 */
function percampages_civicrm_uninstall() {
    _percampages_civix_civicrm_uninstall();
}

/**
 * Implements hook_civicrm_enable().
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_enable
 */
function percampages_civicrm_enable() {
    _percampages_civix_civicrm_enable();
}

/**
 * Implements hook_civicrm_disable().
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_disable
 */
function percampages_civicrm_disable() {
    _percampages_civix_civicrm_disable();
}

/**
 * Implements hook_civicrm_upgrade().
 *
 * @param $op string, the type of operation being performed; 'check' or 'enqueue'
 * @param $queue CRM_Queue_Queue, (for 'enqueue') the modifiable list of pending up upgrade tasks
 *
 * @return mixed
 *   Based on op. for 'check', returns array(boolean) (TRUE if upgrades are pending)
 *                for 'enqueue', returns void
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_upgrade
 */
function percampages_civicrm_upgrade($op, CRM_Queue_Queue $queue = NULL) {
    return _percampages_civix_civicrm_upgrade($op, $queue);
}

/**
 * Implements hook_civicrm_managed().
 *
 * Generate a list of entities to create/deactivate/delete when this module
 * is installed, disabled, uninstalled.
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_managed
 */
function percampages_civicrm_managed(&$entities) {
    _percampages_civix_civicrm_managed($entities);
}

/**
 * Implements hook_civicrm_caseTypes().
 *
 * Generate a list of case-types.
 *
 * @param array $caseTypes
 *
 * Note: This hook only runs in CiviCRM 4.4+.
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_caseTypes
 */
function percampages_civicrm_caseTypes(&$caseTypes) {
    _percampages_civix_civicrm_caseTypes($caseTypes);
}

/**
 * Implements hook_civicrm_angularModules().
 *
 * Generate a list of Angular modules.
 *
 * Note: This hook only runs in CiviCRM 4.5+. It may
 * use features only available in v4.6+.
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_caseTypes
 */
function percampages_civicrm_angularModules(&$angularModules) {
    $angularModules['example'] = array('ext'=>'com.webappmaster.percampages', 'js'=> array('js/example.js') );
    _percampages_civix_civicrm_angularModules($angularModules);
}

/**
 * Implements hook_civicrm_alterSettingsFolders().
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_alterSettingsFolders
 */
function percampages_civicrm_alterSettingsFolders(&$metaDataFolders = NULL) {
    _percampages_civix_civicrm_alterSettingsFolders($metaDataFolders);
}

/**
 * Functions below this ship commented out. Uncomment as required.
 *

/**
 * Implements hook_civicrm_preProcess().
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_preProcess
 **/
function percampages_civicrm_preProcess($formName, &$form) {
    //CRM_Core_Resources::singleton()->addScriptUrl('https://ajax.googleapis.com/ajax/libs/angularjs/1.5.0/angular.min.js', 0, 'html-header');
    //CRM_Core_Resources::singleton()->addScriptFile('com.webappmaster.percampages', 'js/angular.min.js', 0, 'html-header');
    //CRM_Core_Resources::singleton()->addScriptFile('com.webappmaster.percampages', 'js/angular-route.js', 1, 'html-header');
} 


function percampages_civicrm_buildForm($formName, &$form) {
    //echo $formName;die;
    //if($formName == 'CRM_Report_Form_Contact_Detail') {
        CRM_Core_Resources::singleton()->addScriptFile('com.webappmaster.percampages', 'js/angular.min.js', 0, 'html-header');
        //CRM_Core_Resources::singleton()->addScriptFile('com.webappmaster.percampages', 'https://ajax.googleapis.com/ajax/libs/angularjs/1.5.0/angular.min.js', 'html-header');
    //}
}

/**
 * Implements hook_civicrm_navigationMenu().
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_navigationMenu
 *
function percampages_civicrm_navigationMenu(&$menu) {
  _percampages_civix_insert_navigation_menu($menu, NULL, array(
    'label' => ts('The Page', array('domain' => 'com.webappmaster.percampages')),
    'name' => 'the_page',
    'url' => 'civicrm/the-page',
    'permission' => 'access CiviReport,access CiviContribute',
    'operator' => 'OR',
    'separator' => 0,
  ));
  _percampages_civix_navigationMenu($menu);
} // */
