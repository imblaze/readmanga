<html>
  <head>
    <title>Загрузка манги</title>
    <meta name="keywords" content="Манга загрузить файл поделиться мангой показать всем"/>
    <meta name="description" content="ReadManga.ru создан для того, чтобы сделать чтение манги максимально простым и интересным занятием. Теперь вам не нужно скачивать архивы и мучатся с их комфортным просмотром. Мы периодически добавляем новые главы, так что вам всегда будет что почитать" />
    <p:javascript src="swfupload"/>
    <p:javascript src="swfupload.queue"/>
    <p:javascript src="fileprogress"/>
    <p:javascript src="handlers"/>
    <script language="JavaScript" type="text/javascript" >
      var swfu;
jQ(document).ready(function() {

var settings = {
				flash_url : "${createLinkTo(dir:'swf',file:'swfupload.swf')}",
				upload_url: "${createLink(controller:'upload',action:'uploadFile')}",
				post_params: {"PHPSESSID" : ""},      // Here are some POST values to send. These can be changed dynamically
				file_size_limit : "100 MB",
				file_types : "*.zip; *.rar",
				file_types_description : "All Files",
				file_upload_limit : 100,
				file_queue_limit : 0,
				custom_settings : {
					progressTarget : "fsUploadProgress",
					cancelButtonId : "btnCancel"
				},
				debug: false,

				// Button settings
				button_image_url: "${createLinkTo(dir:'images',file:'button1.png')}",
				button_width: "65",
				button_height: "18",
				button_placeholder_id: "spanButtonPlaceHolder",
				button_text: '<span class="theFont">Добавить</span>',
				button_text_style: ".theFont { color:#8B2F20; font-size:15pt}",
				button_text_left_padding: 0,
				button_text_top_padding: 0,
//               button_text_top_padding: 0,
//				button_text_left_padding: 18,

                button_window_mode: SWFUpload.WINDOW_MODE.TRANSPARENT,
				button_cursor: SWFUpload.CURSOR.HAND,

				// The event handler functions are defined in handlers.js
				file_queued_handler : fileQueued,
				file_queue_error_handler : fileQueueError,
				file_dialog_complete_handler : fileDialogComplete,
				upload_start_handler : uploadStart,
				upload_progress_handler : uploadProgress,
				upload_error_handler : uploadError,
				upload_success_handler : uploadSuccess,
				upload_complete_handler : uploadComplete,
				queue_complete_handler : queueComplete	// Queue plugin event
			};

			swfu = new SWFUpload(settings);
});
//                  post_params: {"PHPSESSID" : "<?php echo session_id(); ?>"},

        </script>
  </head>

<content tag="leftContent">
  <h1>Форма загрузки</h1>
  <form id="form1" method="post" enctype="multipart/form-data">
    <p>Эта страница служит для загрузки манги. Максимальный размер файла 100 Мб.</p>
    <p>Пожалуста, указывайте в имени файла название, том и номер главы манги.</p>
    <div class="fieldset flash" id="fsUploadProgress">
      <span class="legend">Очередь заргрузки</span>
    </div>
    <div id="divStatus">0 Файлов загружено</div>
    <div>
      <button style="padding:0" onclick="return false;"><span id="spanButtonPlaceHolder"></span></button>
      <button id="btnCancel" onclick="swfu.cancelQueue();" disabled="disabled">Cancel All Uploads</button>

    </div>

  </form>
</content>
<content tag="rightContent">
  <g:render template="/view/info"/>
</content>
</html>
