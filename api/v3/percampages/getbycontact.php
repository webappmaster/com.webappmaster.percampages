<?php

/**
 * This api exposes CiviCRM pcp records.
 *
 *
 * @package CiviCRM_APIv3
 */

/**
 * Retrieve Personal Campaign Pages List for a given Contact.
 *
 * This API is used to create list of Personal Campaign Pages by contact id
 *
 * @param array $params
 * @return array
 *
 */
function civicrm_api3_percampages_getbycontact($params) {

//    if(!isset($params['contact_id']) || !is_numeric($params['contact_id']) || $params['contact_id'] <= 0 ) {
//        return civicrm_api3_create_error('"contact_id" parameter is missing or invalid.');
//    }
    
    $result = array();

    $query = "
        SELECT p.id, p.contact_id, p.status_id, p.title, p.goal_amount,  cp.title as page_title, 
            CASE WHEN p.status_id = 1 THEN 'Waiting Review'
                 WHEN p.status_id = 2 THEN 'Approved'
                 WHEN p.status_id = 3 THEN 'Not Approved'
            END as `status`,
            CONCAT('".CIVICRM_UF_BASEURL."/civicrm/pcp/info?action=update&amp;reset=1&amp;id=',`p`.page_id, '&amp;context=dashboard') as `editlink`,
            (SELECT count(cs.id) from civicrm_contribution_soft cs 
                WHERE `cs`.pcp_id = `p`.id
             )  as `total_contribution`
        FROM `civicrm_pcp` as `p`
            JOIN `civicrm_contact` as `c` on c.id = p.contact_id
            JOIN `civicrm_contribution_page` as `cp` on `cp`.id = `p`.page_id
        WHERE p.contact_id in (".$params['contact_id'].")
        
        ORDER By p.contact_id ";
            

    //GROUP BY p.id, p.contact_id, p.status_id, p.title, p.goal_amount, cp.title, p.status_id
    //echo $query;die;
    $query_params = array(
        '1' => array($params['contact_id'], 'String'),
    );

    $dao = CRM_Core_DAO::executeQuery($query, $query_params);
    
    while ($dao->fetch()) {

        $result['a'.$dao->contact_id][] = $dao->toArray();
        
        /*
          $data[$dao->id] = array(
          'table_name' => $dao->table_name,
          'column_name' => $dao->column_name,
          'data_type' => $dao->data_type,
          ); */
    }
    $dao->free();

//    $result['is_error'] = 0;
//    $result['version'] = 3;
//    $result['count'] = 10;
//    $result['values'] = $data;
//
//    return $result;
    
    

    return civicrm_api3_create_success( $result, [], 'percampages', 'get_by_contact', $dao);
    //return _civicrm_api3_basic_create(_civicrm_api3_get_BAO(__FUNCTION__), $params, 'Campaign');
}
