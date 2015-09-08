<?php echo tpl_form(Filters::noXSS(CreateUrl('details', $task_details['task_id'])),null,null,null,'id="taskeditform"'); ?>
<div id="actionbar">
	<button class="button positive" type="submit" accesskey="s" onclick="return checkok('<?php echo Filters::noJsXSS($baseurl); ?>js/callbacks/checksave.php?time=<?php echo Filters::noXSS(time()); ?>&amp;task_id=<?php echo Filters::noXSS($task_details['task_id']); ?>', '<?php echo Filters::noJsXSS(L('alreadyedited')); ?>', 'taskeditform')"><?php echo Filters::noXSS(L('savedetails')); ?></button>
	<a class="button" href="<?php echo Filters::noXSS(CreateUrl('details', $task_details['task_id'])); ?>"><?php echo Filters::noXSS(L('canceledit')); ?></a>
	<div class="clear"></div>
</div>
<!-- Grab fields wanted for this project so we can only show those we want -->
<?php $fields = explode( ' ', $proj->prefs['visible_fields'] ); ?>
<div id="taskdetails">
<div>
	<input type="hidden" name="action" value="details.update" />
	<input type="hidden" name="edit" value="1" />
	<input type="hidden" name="task_id" value="<?php echo Filters::noXSS($task_details['task_id']); ?>" />
	<input type="hidden" name="edit_start_time" value="<?php echo Filters::noXSS(Req::val('edit_start_time', time())); ?>" />
	<div id="taskfields">
	<ul class="form_elements slim">
	<!-- Status -->
	<li<?php echo in_array('status', $fields)) ? '' : ' style="display:none"'; ?>>
		<label for="status"><?php echo Filters::noXSS(L('status')); ?></label>
		<select id="status" name="item_status" <?php echo tpl_disableif(!$user->perms('modify_all_tasks')); ?>>
		<?php echo tpl_options($proj->listTaskStatuses(), Req::val('item_status', ($user->perms('modify_all_tasks') ? $task_details['item_status'] : STATUS_UNCONFIRMED))); ?>
		</select>
	</li>
	<!-- Progress -->
	<li<?php echo in_array('progress', $fields) ? '' : ' style="display:none"'; ?>>
		<label for="percent"><?php echo Filters::noXSS(L('percentcomplete')); ?></label>
		<select id="percent" name="percent_complete" <?php echo tpl_disableif(!$user->perms('modify_all_tasks')) ?>>
		<?php $arr = array(); for ($i = 0; $i<=100; $i+=10) $arr[$i] = $i.'%'; ?>
		<?php echo tpl_options($arr, Req::val('percent_complete', $task_details['percent_complete'])); ?>
		</select>
	</li>
	<!-- Task Type-->
	<li<?php echo in_array('tasktype', $fields) ? '' : ' style="display:none"'; ?>>
		<label for="tasktype"><?php echo Filters::noXSS(L('tasktype')); ?></label>
		<select id="tasktype" name="task_type">
		<?php echo tpl_options($proj->listTaskTypes(), Req::val('task_type', $task_details['task_type'])); ?>
		</select>
	</li>
	<!-- Category -->
	<li<?php echo in_array('category', $fields) ? '' : ' style="display:none"'; ?>>
		<label for="category"><?php echo Filters::noXSS(L('category')); ?></label>
		<select id="category" name="product_category">
		<?php echo tpl_options($proj->listCategories(), Req::val('product_category', $task_details['product_category'])); ?>
		</select>
	</li>
	<!-- Assigned To-->
	<li<?php echo in_array('assignedto', $fields) ? '' : ' style="display:none"'; ?>>
		<label><?php echo Filters::noXSS(L('assignedto')); ?></label>
		<?php if ($user->perms('edit_assignments')): ?>
			<input type="hidden" name="old_assigned" value="<?php echo Filters::noXSS($old_assigned); ?>" />
		<?php $this->display('common.multiuserselect.tpl'); ?>
		<?php else: ?>
			<?php if (empty($assigned_users)): ?>
				<?php echo Filters::noXSS(L('noone')); ?>
			<?php else:
				foreach ($assigned_users as $userid): ?>
					<?php echo tpl_userlink($userid); ?><br />
				<?php endforeach;
			endif;
		endif; ?>
	</li>
	<!-- OS -->
	<li<?php echo in_array('os', $fields) ? '' : ' style="display:none"'; ?>>
		<label for="os"><?php echo Filters::noXSS(L('operatingsystem')); ?></label>
		<select id="os" name="operating_system">
		<?php echo tpl_options($proj->listOs(), Req::val('operating_system', $task_details['operating_system'])); ?>
		</select>
	</li>
	<!-- Severity -->
	<li<?php echo in_array('severity', $fields) ? '' : ' style="display:none"': ?>>
		<label for="severity"><?php echo Filters::noXSS(L('severity')); ?></label>
		<select id="severity" name="task_severity">
		 <?php echo tpl_options($fs->severities, Req::val('task_severity', $task_details['task_severity'])); ?>
		</select>
	</li>
	<!-- Priority -->
	<li<?php echo in_array('priority', $fields) ? '' : ' style="display:none"'; ?>>
		<label for="priority"><?php echo Filters::noXSS(L('priority')); ?></label>
		<select id="priority" name="task_priority" <?php echo tpl_disableif(!$user->perms('modify_all_tasks')) ?>>
		<?php echo tpl_options($fs->priorities, Req::val('task_priority', $task_details['task_priority'])); ?>
		</select>
	</li>
	<!-- Reported In -->
	<li<?php echo in_array('reportedin', $fields) ? '' : ' style="display:none"'; ?>>
		<label for="reportedver"><?php echo Filters::noXSS(L('reportedversion')); ?></label>
		<select id="reportedver" name="reportedver">
		<?php echo tpl_options($proj->listVersions(false, 2, $task_details['product_version']), Req::val('reportedver', $task_details['product_version'])); ?>
		</select>
	</li>
	<!-- Due Version -->
	<li<?php echo in_array('dueversion', $fields) ? '' : ' style="display:none"'; ?>>
		<label for="dueversion"><?php echo Filters::noXSS(L('dueinversion')); ?></label>
		<select id="dueversion" name="closedby_version" <?php echo tpl_disableif(!$user->perms('modify_all_tasks')) ?>>
		<option value="0"><?php echo Filters::noXSS(L('undecided')); ?></option>
		<?php echo tpl_options($proj->listVersions(false, 3), Req::val('closedby_version', $task_details['closedby_version'])); ?>
		</select>
	</li>
	<!-- Due Date -->
	<li<?php echo (in_array('duedate', $fields) && $user->perms('modify_all_tasks')) ? '' : ' style="display:none"'; ?>>
		<label for="duedate"><?php echo Filters::noXSS(L('duedate')); ?></label>
		<?php echo tpl_datepicker('due_date', '', Req::val('due_date', $task_details['due_date'])); ?>
	</li>
	<!-- Private -->
	<?php if ($user->can_change_private($task_details)): ?>
	<li><?php echo in_array('private', $fields) ? '' : ' style="display:none"'; ?>>
		<label for="private"><?php echo Filters::noXSS(L('private')); ?></label>
		<?php echo tpl_checkbox('mark_private', Req::val('mark_private', $task_details['mark_private']), 'private'); ?>
	</li>
	<?php endif; ?>

	<?php if ($proj->prefs['use_effort_tracking'] && $user->perms('view_estimated_effort'): ?>
	<li>
		<label for="estimatedeffort"><?php echo Filters::noXSS(L('estimatedeffort')); ?></label>
		<input id="estimated_effort" name="estimated_effort" class="text" type="text" size="5" maxlength="10" value="<?php echo Filters::noXSS(effort::SecondsToEditString($task_details['estimated_effort'], $proj->prefs['hours_per_manday'], $proj->prefs['estimated_effort_format'])); ?>" />
		<?php echo Filters::noXSS(L('hours')); ?>
	</li>
	<?php endif; ?>

	<!-- If no currently selected project is not there, push it on there so don't have to change things -->
	<?php
	$id = Req::val('project_id', $proj->id);
	$selected = false;
	foreach ($fs->projects as $value => $label) {
		if ($label[0] == $id) {
			$selected = true;
			break;
		}
	}

	if (! $selected) {
                $title = '---';
		$foo = array( $id, $title, 'project_id' => $id, 'project_title' => $title);
		array_unshift( $fs->projects,  $foo);
	}
	?>

	<!-- If there is only one choice of projects, then don't bother showing it -->
	<li<?php if (count($fs->projects) > 1) ? '' : ' style="display:none"'; ?>>
		<label for="tasktype"><?php echo Filters::noXSS(L('attachedtoproject')); ?></label>
		<select name="project_id">
		<?php echo tpl_options($fs->projects, Req::val('project_id', $proj->id)); ?>
		</select>
	</li>
	</ul>
	<div id="fineprint">
		  <?php echo Filters::noXSS(L('openedby')); ?> <?php echo tpl_userlink($task_details['opened_by']); ?>
		  - <span title="<?php echo formatDate($task_details['date_opened'], true); ?>"><?php echo formatDate($task_details['date_opened'], false); ?></span>
		  <?php if ($task_details['last_edited_by']): ?>
		  <br />
		  <?php echo Filters::noXSS(L('editedby')); ?>  <?php echo tpl_userlink($task_details['last_edited_by']); ?>
		  - <span title="<?php echo Filters::noXSS(formatDate($task_details['last_edited_time'], true)); ?>"><?php echo Filters::noXSS(formatDate($task_details['last_edited_time'], false)); ?></span>
		  <?php endif; ?>
	</div>
</div>
<div id="taskdetailsfull">
	<label for="item_summary" class="summary">FS#<?php echo Filters::noXSS($task_details['task_id']); ?> <?php echo Filters::noXSS(L('summary')); ?>:
		<input placeholder="<?php echo Filters::noXSS(L('summary')); ?>" type="text" name="item_summary" id="item_summary" maxlength="100" value="<?php echo Filters::noXSS(Req::val('item_summary', $task_details['item_summary'])); ?>" />
	</label>
	<label for="tags" title="<?php echo Filters::noXSS(L('taginfo')); ?>"><?php echo Filters::noXSS(L('tags')); ?>:
		<input placeholder="<?php echo Filters::noXSS(L('tags')); ?>" type="text" name="tags" id="tags" maxlength="100" value="<?php echo Filters::noXSS(Req::val('tags', $task_details['tags'])); ?>" />
	</label>
	<?php if (defined('FLYSPRAY_HAS_PREVIEW')): ?>
		<div class="hide preview" id="preview"></div>
	<?php endif; ?>
	<?php echo TextFormatter::textarea('detailed_desc', 15, 70, array('id' => 'details'), Req::val('detailed_desc', $task_details['detailed_desc'])); ?>
	<br />
	<?php if ($user->perms('add_comments') && (!$task_details['is_closed'] || $proj->prefs['comment_closed'])): ?><!--
              <button type="button" onclick="showstuff('edit_add_comment');this.style.display='none';"><?php echo Filters::noXSS(L('addcomment')); ?></button>
              <div id="edit_add_comment" class="hide">
              <label for="comment_text"><?php echo Filters::noXSS(L('comment')); ?></label>

              <?php if ($user->perms('create_attachments')): ?>
              <div id="uploadfilebox_c">
                <span style="display: none"><?php // this span is shown/copied in javascript when adding files ?>
                  <input tabindex="5" class="file" type="file" size="55" name="userfile[]" />
                    <a href="javascript://" tabindex="6" onclick="removeUploadField(this, 'uploadfilebox_c');"><?php echo Filters::noXSS(L('remove')); ?></a><br />
                </span>
              </div>
              <button id="uploadfilebox_c_attachafile" tabindex="7" type="button" onclick="addUploadFields('uploadfilebox_c')">
                <?php echo Filters::noXSS(L('uploadafile')); ?> (<?php echo Filters::noXSS(L('max')); ?> <?php echo Filters::noXSS($fs->max_file_size); ?> <?php echo Filters::noXSS(L('MiB')); ?>)
              </button>
              <button id="uploadfilebox_c_attachanotherfile" tabindex="7" style="display: none" type="button" onclick="addUploadFields('uploadfilebox_c')">
                 <?php echo Filters::noXSS(L('attachanotherfile')); ?> (<?php echo Filters::noXSS(L('max')); ?> <?php echo Filters::noXSS($fs->max_file_size); ?> <?php echo Filters::noXSS(L('MiB')); ?>)
              </button>
              <?php endif; ?>

              <textarea accesskey="r" tabindex="8" id="comment_text" name="comment_text" cols="50" rows="10"></textarea>
              </div>-->
	<?php endif; ?>
	<p class="buttons">
		<!--<button type="submit" accesskey="s" onclick="return checkok('<?php echo Filters::noJsXSS($baseurl); ?>js/callbacks/checksave.php?time=<?php echo Filters::noXSS(time()); ?>&amp;taskid=<?php echo Filters::noXSS($task_details['task_id']); ?>', '<?php echo Filters::noJsXSS(L('alreadyedited')); ?>', 'taskeditform')"><?php echo Filters::noXSS(L('savedetails')); ?></button>-->
		<?php if (defined('FLYSPRAY_HAS_PREVIEW')): ?>
		<button tabindex="9" type="button" onclick="showPreview('details', '<?php echo Filters::noJsXSS($baseurl); ?>', 'preview')"><?php echo Filters::noXSS(L('preview')); ?></button>
		<?php endif; ?>
		<button type="reset"><?php echo Filters::noXSS(L('reset')); ?></button>
	</p>

	<?php 
	$attachments = $proj->listTaskAttachments($task_details['task_id']);
	$this->display('common.editattachments.tpl', 'attachments', $attachments);
	if ($user->perms('create_attachments')): ?>
		<div id="uploadfilebox">
			<span style="display: none"><?php // this span is shown/copied in javascript when adding files ?>
				<input tabindex="5" class="file" type="file" size="55" name="usertaskfile[]" />
				<a href="javascript://" tabindex="6" onclick="removeUploadField(this);"><?php echo Filters::noXSS(L('remove')); ?></a><br />
			</span>
			<noscript>
				<input tabindex="5" class="file" type="file" size="55" name="usertaskfile[]" />
			</noscript>
		</div>
		<button id="uploadfilebox_attachafile" tabindex="7" type="button" onclick="addUploadFields()">
			<?php echo Filters::noXSS(L('uploadafile')); ?> (<?php echo Filters::noXSS(L('max')); ?> <?php echo Filters::noXSS($fs->max_file_size); ?> <?php echo Filters::noXSS(L('MiB')); ?>)
		</button>
		<button id="uploadfilebox_attachanotherfile" tabindex="7" style="display: none" type="button" onclick="addUploadFields()">
			<?php echo Filters::noXSS(L('attachanotherfile')); ?> (<?php echo Filters::noXSS(L('max')); ?> <?php echo Filters::noXSS($fs->max_file_size); ?> <?php echo Filters::noXSS(L('MiB')); ?>)
		</button>
	<?php endif; ?>

	<?php
	$links = $proj->listTaskLinks($task_details['task_id']);
	$this->display('common.editlinks.tpl', 'links', $links); ?>

	<?php if ($user->perms('create_attachments')): ?>
	<div id="addlinkbox">
		<span style="display: none">
		<input tabindex="8" class="text" type="text" maxlength="100" name="userlink[]" />
		<a href="javascript://" tabindex="9" onclick="removeLinkField(this, 'addlinkbox');"><?php echo Filters::noXSS(L('remove')); ?></a><br />
		</span>
		<noscript>
		<input tabindex="8" class="text" type="text" maxlength="100" name="userlink[]" />
		</noscript>
	</div>
	<button id="addlinkbox_addalink" tabindex="10" type="button" onclick="addLinkField('addlinkbox')"><?php echo Filters::noXSS(L('addalink')); ?></button>
	<button id="addlinkbox_addanotherlink" tabindex="10" style="display: none" type="button" onclick="addLinkField('addlinkbox')"><?php echo Filters::noXSS(L('addalink')); ?></button>
	<?php endif; ?>
</div>
</div>
<div class="clear"></div>
</div>
</form>
