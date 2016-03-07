{*
 +--------------------------------------------------------------------+
 | CiviCRM version 4.7                                                |
 +--------------------------------------------------------------------+
 | Copyright CiviCRM LLC (c) 2004-2015                                |
 +--------------------------------------------------------------------+
 | This file is a part of CiviCRM.                                    |
 |                                                                    |
 | CiviCRM is free software; you can copy, modify, and distribute it  |
 | under the terms of the GNU Affero General Public License           |
 | Version 3, 19 November 2007 and the CiviCRM Licensing Exception.   |
 |                                                                    |
 | CiviCRM is distributed in the hope that it will be useful, but     |
 | WITHOUT ANY WARRANTY; without even the implied warranty of         |
 | MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.               |
 | See the GNU Affero General Public License for more details.        |
 |                                                                    |
 | You should have received a copy of the GNU Affero General Public   |
 | License and the CiviCRM Licensing Exception along                  |
 | with this program; if not, contact CiviCRM LLC                     |
 | at info[AT]civicrm[DOT]org. If you have questions about the        |
 | GNU Affero General Public License or the licensing of CiviCRM,     |
 | see the CiviCRM license FAQ at http://civicrm.org/licensing        |
 +--------------------------------------------------------------------+
*}
{* this div is being used to apply special css *}
    {if !$section }
    <div class="crm-block crm-form-block crm-report-field-form-block">
        {include file="CRM/Report/Form/Fields.tpl"}
    </div>
    {/if}

<div class="crm-block crm-content-block crm-report-form-block" ng-app="percampagesApp" ng-controller="percampagesController">
{include file="CRM/Report/Form/Actions.tpl"}
{if !$section }
{include file="CRM/Report/Form/Statistics.tpl" top=true}
{/if}
    {if $rows}
        <div class="report-pager">
            {include file="CRM/common/pager.tpl" location="top"}
        </div>

        {* pre-compile section header here, rather than doing it every time under foreach *}
        {capture assign=sectionHeaderTemplate}
            {assign var=columnCount value=$columnHeaders|@count}
            {assign var=l value=$smarty.ldelim}
            {assign var=r value=$smarty.rdelim}
            {foreach from=$sections item=section key=column name=sections}
                {counter assign="h"}
                {$l}isValueChange value=$row.{$column} key="{$column}" assign=isValueChanged{$r}
                {$l}if $isValueChanged{$r}

                    {$l}if $sections.{$column}.type & 4{$r}
                        {$l}assign var=printValue value=$row.{$column}|crmDate{$r}
                    {$l}elseif $sections.{$column}.type eq 1024{$r}
                        {$l}assign var=printValue value=$row.{$column}|crmMoney{$r}
                    {$l}else{$r}
                        {$l}assign var=printValue value=$row.{$column}{$r}
                    {$l}/if{$r}

                    <tr><th colspan="{$columnCount}">
                        <h{$h}>{$section.title}: {$l}$printValue|default:"<em>none</em>"{$r}
                            ({$l}sectionTotal key=$row.{$column} depth={$smarty.foreach.sections.index}{$r})
                        </h{$h}>
                    </th></tr>
                    {if $smarty.foreach.sections.last}
                        <tr>{$l}$tableHeader{$r}</tr>
                    {/if}
                {$l}/if{$r}
            {/foreach}
        {/capture}

        {foreach from=$rows item=row}
                {assign var="myrow" value="$row"}
                
                  <table class="report-layout crm-report_contact_civireport" data-id='{$row.civicrm_contact_id}'>
                        {eval var=$sectionHeaderTemplate}
                            <tr>
                                {foreach from=$columnHeaders item=header key=field}
                                    {if !$skip}
                                        {if $header.colspan}
                                            <th colspan={$header.colspan}>{$header.title}</th>
                                            {assign var=skip value=true}
                                            {assign var=skipCount value=`$header.colspan`}
                                            {assign var=skipMade  value=1}
                                        {else}
                                            <th>{$header.title}</th>
                                            {assign var=skip value=false}
                                        {/if}
                                    {else} {* for skip case *}
                                        {assign var=skipMade value=`$skipMade+1`}
                                        {if $skipMade >= $skipCount}{assign var=skip value=false}{/if}
                                    {/if}
                                {/foreach}
                            </tr>
                            <tr class="group-row crm-report">
                                {foreach from=$columnHeaders item=header key=field}
                                    {assign var=fieldLink value=$field|cat:"_link"}
                                    {assign var=fieldHover value=$field|cat:"_hover"}
                                    <td  class="report-contents crm-report_{$field}">
                                        {if $row.$fieldLink}<a title="{$row.$fieldHover}" href="{$row.$fieldLink}">{/if}

                                        {if $row.$field eq 'Subtotal'}
                                            {$row.$field}
                                        {elseif $header.type eq 12 || $header.type eq 4}
                                            {if $header.group_by eq 'MONTH' or $header.group_by eq 'QUARTER'}
                                                {$row.$field|crmDate:$config->dateformatPartial}
                                            {elseif $header.group_by eq 'YEAR'}
                                                {$row.$field|crmDate:$config->dateformatYear}
                                            {else}
                                                {$row.$field|truncate:10:''|crmDate}
                                            {/if}
                                        {elseif $header.type eq 1024}
                                            {$row.$field|crmMoney}
                                        {else}
                                            {$row.$field}
                                        {/if}

                                        {if $row.contactID} {/if}

                                        {if $row.$fieldLink}</a>{/if}
                                    </td>
                                {/foreach}
                            </tr>
                        </table>

                        {if $columnHeadersComponent}
                            {assign var=componentContactId value=$row.contactID}
                            {foreach from=$columnHeadersComponent item=pheader key=component}
                                {if $componentRows.$componentContactId.$component}
                                    <h3>{$component|replace:'_civireport':''|upper}</h3>
                          <table class="report-layout crm-report_{$component}">
                              {*add space before headers*}
                            <tr>
                                {foreach from=$pheader item=header}
                              <th>{$header.title}</th>
                                {/foreach}
                            </tr>

                              {foreach from=$componentRows.$componentContactId.$component item=row key=rowid}
                            <tr class="{cycle values="odd-row,even-row"} crm-report" id="crm-report_{$rowid}">
                                {foreach from=$columnHeadersComponent.$component item=header key=field}
                              {assign var=fieldLink value=$field|cat:"_link"}
                                                {assign var=fieldHover value=$field|cat:"_hover"}
                              <td class="report-contents crm-report_{$field}">
                                  {if $row.$fieldLink}
                                <a title="{$row.$fieldHover} "href="{$row.$fieldLink}">
                                  {/if}

                                  {if $row.$field eq 'Sub Total'}
                                {$row.$field}
                                  {elseif $header.type & 4}
                                      {if $header.group_by eq 'MONTH' or $header.group_by eq 'QUARTER'}
                                    {$row.$field|crmDate:$config->dateformatPartial}
                                {elseif $header.group_by eq 'YEAR'}
                                    {$row.$field|crmDate:$config->dateformatYear}
                                {else}
                                    {$row.$field|truncate:10:''|crmDate}
                                {/if}
                                  {elseif $header.type eq 1024}
                                {$row.$field|crmMoney}
                                  {else}
                                {$row.$field}
                                  {/if}

                                  {if $row.$fieldLink}</a>{/if}
                              </td>
                                {/foreach}
                            </tr>
                              {/foreach}
                          </table>
                          
                            {/if}
                            {/foreach}
                            
                            <div class="ng-hide" ng-show="personalCampaignPages.values.a{$myrow.civicrm_contact_id}">
                                <h3>PERSONAL CAMPAIGN PAGES</h3>
                                <table class="report-layout crm-report_pcp_civireport">
                                    <tbody><tr>
                                        <th>Page Title</th>
                                        <th>Status</th>
                                        <th>Contribution Page/Event</th>
                                        <th>No. of contributions</th>
                                        <th>Amount Raised</th>
                                        <th>Target Amount</th>
                                        <th>Edit Page</th>
                                      </tr>

                                    <tr id="crm-report_0" class="odd-row crm-report" ng-repeat="pcp in personalCampaignPages.values.a{$myrow.civicrm_contact_id}" >
                                        <td>{literal}{{pcp.title}}{/literal}</td>
                                        <td>{literal}{{pcp.status}}{/literal}</td>
                                        <td>{literal}{{pcp.page_title}}{/literal}</td>
                                        <td>{literal}{{pcp.total_contribution}}{/literal}</td>
                                        <td>{literal}0{/literal}</td>
                                        <td>{literal}{{pcp.currency}} {{pcp.goal_amount}}{/literal}</td>
                                        <td>{literal}<span><a title="Edit Personal Campaign Page" class="action-item crm-hover-button" href="{{pcp.editlink}}">Edit</a><span>{/literal}</td>
                                    </tr>
                                    
                      
                                  </tbody>
                                </table>

                            </div>
                            
                            
                        {/if}
        {/foreach}

  <div class="report-pager">
            {include file="CRM/common/pager.tpl"}
        </div>
        <br />
        {if $grandStat}
            <table class="report-layout">
                <tr>
                    {foreach from=$columnHeaders item=header key=field}
                        <td>
                            <strong>
                                {if $header.type eq 1024}
                                    {$grandStat.$field|crmMoney}
                                {else}
                                    {$grandStat.$field}
                                {/if}
                            </strong>
                        </td>
                    {/foreach}
                </tr>
            </table>
        {/if}

        {if !$section }
            {*Statistics at the bottom of the page*}
            {include file="CRM/Report/Form/Statistics.tpl" bottom=true}
        {/if}
    {/if}
    {include file="CRM/Report/Form/ErrorMessage.tpl"}
    
    <span style="display: none;" class="baseurl">{php}echo CIVICRM_UF_BASEURL;{/php}</span>
    
    {literal}
    <script type="text/javascript">

        (function(){
                
            var app = angular.module('percampagesApp', []);
            
            
            app.controller('percampagesController', function($scope, $http) {
                
               
                
                var pcp_array = angular.element('table.report-layout.crm-report_contact_civireport');
                
                
                // get all ids of contact and store them into array
                var data_ids = [];
                angular.forEach(pcp_array, function(pcp, key) {
                    data_ids[key] = angular.element(pcp).attr('data-id');
                });
                
                // implode data_ids
                var data_ids_string = encodeURI(data_ids.join(','));
               
        
                
                //create base url with comma separated contact_id
                url = angular.element('span.baseurl').text() + 'civicrm/ajax/rest?json=1&debug=1&version=3&entity=percampages&action=getbycontact&contact_id=' + data_ids_string;
                
                //make ajax request to api
                $http.get(url).success(function(response){
                    console.log(response);
                    $scope.personalCampaignPages = response;
                });
                
                
                
                
                
                /*
                CRM.api3('percampages', 'get_by_contact', {contact_id:202})
                        .then(function(result){
                            //console.log($scope);
                    
                            $scope.here = 'I am here';
                            $scope.personalCampaignPages = result;
                        });
                */

            }  );
        })();

    </script>
    {/literal}
</div>
