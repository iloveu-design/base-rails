/* https://github.com/DiemenDesign/summernote-video-attributes */
(function (factory) {
  if (typeof define === 'function' && define.amd) {
    define(['jquery'], factory);
  } else if (typeof module === 'object' && module.exports) {
    module.exports = factory(require('jquery'));
  } else {
    factory(window.jQuery);
  }
}(function ($) {
  $.extend(true, $.summernote.lang, {
    'en-US': { /* English */
      videoAttributes: {
        dialogTitle: 'Video Attributes',
        tooltip: 'Video Attributes',
        pluginTitle: 'Video Attributes',
        href: 'URL',
        videoSize: 'Video size',
        videoOption0: 'Responsive',
        videoOption1: '1280x720',
        videoOption2: '853x480',
        videoOption3: '640x360',
        videoOption4: '560x315',
        alignment: 'Alignment',
        alignmentOption0: 'None',
        alignmentOption1: 'Left',
        alignmentOption2: 'Right',
        alignmentOption3: 'Initial',
        alignmentOption4: 'Inherit',
        suggested: 'Show Suggested videos when the video finishes',
        controls: 'Show player controls',
        autoplay: 'Autoplay',
        loop: 'Loop',
        note: 'Note: Not all options are available with all services...',
        ok: 'OK'
      }
    }
  });
  $.extend($.summernote.options, {
    videoAttributes: {
      icon: '<i class="note-icon"><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="14pt" height="14pt" viewBox="0 0 14 14" version="1.1"><g id="surface1"><path style=" stroke:none;fill-rule:nonzero;fill:rgb(0%,0%,0%);fill-opacity:1;" d="M 9.039062 2.820312 L 0.972656 2.820312 C 0.433594 2.820312 0 3.253906 0 3.792969 L 0 10.191406 C 0 10.726562 0.433594 11.160156 0.972656 11.160156 L 9.039062 11.160156 C 9.574219 11.160156 10.011719 10.726562 10.011719 10.191406 L 10.011719 3.792969 C 10.011719 3.253906 9.574219 2.820312 9.039062 2.820312 Z M 9.039062 2.820312 "/><path style=" stroke:none;fill-rule:nonzero;fill:rgb(0%,0%,0%);fill-opacity:1;" d="M 10.660156 8.320312 L 14 10.144531 L 14 3.855469 L 10.660156 5.679688 Z M 10.660156 8.320312 "/></g></svg></i>'
    }
  });
  $.extend($.summernote.plugins, {
    'videoAttributes': function (context) {
      var self = this,
        ui = $.summernote.ui,
        $editor = context.layoutInfo.editor,
        $editable = context.layoutInfo.editable,
        options = context.options,
        lang = options.langInfo;
      context.memo('button.videoAttributes', function () {
        var button = ui.button({
          contents: options.videoAttributes.icon,
          tooltip: lang.videoAttributes.tooltip,
          click: function (e) {
            context.invoke('saveRange');
            context.invoke('videoAttributes.show');
          }
        });
        return button.render();
      });
      this.initialize = function () {
        var $container = options.dialogsInBody ? $(document.body) : $editor;
        var body =
          '<div class="form-group">' +
          '  <div class="col-xs-3"></div>' +
          '  <div class="col-xs-9 help-block">' + lang.videoAttributes.note + '</div>' +
          '</div>' +
          '<div class="form-group">' +
          '  <label for="note-video-attributes-href" class="control-label col-xs-3">' + lang.videoAttributes.href + '</label>' +
          '  <div class="input-group col-xs-9">' +
          '    <input type="text" id="note-video-attributes-href" class="note-video-attributes-href form-control">' +
          '  </div>' +
          '</div>' +
          '<div class="form-group">' +
          '  <label for="note-video-attributes-video-size" class="control-label col-xs-3">' + lang.videoAttributes.videoSize + '</label>' +
          '  <div class="input-group col-xs-9">' +
          '    <select id="note-video-attributes-size" class="note-video-attributes-size form-control col-xs-6">' +
          '      <option value="0" selected>' + lang.videoAttributes.videoOption0 + '</option>' +
          '      <option value="1">' + lang.videoAttributes.videoOption1 + '</option>' +
          '      <option value="2">' + lang.videoAttributes.videoOption2 + '</option>' +
          '      <option value="3">' + lang.videoAttributes.videoOption3 + '</option>' +
          '      <option value="4">' + lang.videoAttributes.videoOption4 + '</option>' +
          '    </select>' +
          '  </div>' +
          '</div>' +
          '<div class="form-group">' +
          '  <label for="note-video-attributes-video-alignment" class="control-label col-xs-3">' + lang.videoAttributes.alignment + '</label>' +
          '  <div class="input-group col-xs-9">' +
          '    <select id="note-video-attributes-alignment" class="note-video-attributes-alignment form-control col-xs-6">' +
          '      <option value="none" selected>' + lang.videoAttributes.alignmentOption0 + '</option>' +
          '      <option value="left">' + lang.videoAttributes.alignmentOption1 + '</option>' +
          '      <option value="right">' + lang.videoAttributes.alignmentOption2 + '</option>' +
          '      <option value="initial">' + lang.videoAttributes.alignmentOption3 + '</option>' +
          '      <option value="inherit">' + lang.videoAttributes.alignmentOption4 + '</option>' +
          '    </select>' +
          '  </div>' +
          '</div>' +
          '<div class="form-group clearfix">' +
          '  <div class="control-label col-xs-3"></div>' +
          '  <div class="input-group col-xs-9">' +
          '    <div class="checkbox checkbox-success">' +
          '      <input type="checkbox" id="note-video-attributes-suggested-checkbox" class="note-video-attributes-suggested-checkbox" checked>' +
          '      <label for="note-video-attributes-suggested-checkbox">' + lang.videoAttributes.suggested + '</label>' +
          '    </div>' +
          '  </div>' +
          '</div>' +
          '<div class="form-group clearfix">' +
          '  <div class="control-label col-xs-3"></div>' +
          '  <div class="input-group col-xs-9">' +
          '    <div class="checkbox checkbox-success">' +
          '      <input type="checkbox" id="note-video-attributes-controls-checkbox" class="note-video-attributes-controls-checkbox" checked>' +
          '      <label for="note-video-attributes-controls-checkbox">' + lang.videoAttributes.controls + '</label>' +
          '    </div>' +
          '  </div>' +
          '</div>' +
          '<div class="form-group clearfix">' +
          '  <div class="control-label col-xs-3"></div>' +
          '  <div class="input-group col-xs-9">' +
          '    <div class="checkbox checkbox-success">' +
          '      <input type="checkbox" id="note-video-attributes-autoplay-checkbox" class="note-video-attributes-autoplay-checkbox">' +
          '      <label for="note-video-attributes-autoplay-checkbox">' + lang.videoAttributes.autoplay + '</label>' +
          '    </div>' +
          '  </div>' +
          '</div>' +
          '<div class="form-group clearfix">' +
          '  <div class="control-label col-xs-3"></div>' +
          '  <div class="input-group col-xs-9">' +
          '    <div class="checkbox checkbox-success">' +
          '      <input type="checkbox" id="note-video-attributes-loop-checkbox" class="note-video-attributes-loop-checkbox">' +
          '      <label for="note-video-attributes-loop-checkbox">' + lang.videoAttributes.loop + '</label>' +
          '    </div>' +
          '  </div>' +
          '</div>';
        this.$dialog = ui.dialog({
          title: lang.videoAttributes.dialogTitle,
          body: body,
          footer: '<button href="#" class="btn btn-primary note-video-attributes-btn">' + lang.videoAttributes.ok + '</button>'
        }).render().appendTo($container);
      };
      this.destroy = function () {
        ui.hideDialog(this.$dialog);
        this.$dialog.remove();
      };
      this.bindEnterKey = function ($input, $btn) {
        $input.on('keypress', function (e) {
          if (e.keyCode === 13) $btn.trigger('click');
        });
      };
      this.bindLabels = function () {
        self.$dialog.find('.form-control:first').focus().select();
        self.$dialog.find('label').on('click', function () {
          $(this).parent().find('.form-control:first').focus();
        });
      };
      this.show = function () {
        var $vid = $($editable.data('target'));
        var vidInfo = {
          vidDom: $vid,
          href: $vid.attr('href')
        };
        this.showLinkDialog(vidInfo).then(function (vidInfo) {
          ui.hideDialog(self.$dialog);
          var $vid = vidInfo.vidDom,
            $videoHref = self.$dialog.find('.note-video-attributes-href'),
            $videoSize = self.$dialog.find('.note-video-attributes-size'),
            $videoAlignment = self.$dialog.find('.note-video-attributes-alignment'),
            $videoSuggested = self.$dialog.find('.note-video-attributes-suggested-checkbox'),
            $videoControls = self.$dialog.find('.note-video-attributes-controls-checkbox'),
            $videoAutoplay = self.$dialog.find('.note-video-attributes-autoplay-checkbox'),
            $videoLoop = self.$dialog.find('.note-video-attributes-loop-checkbox'),
            url = $videoHref.val(),
            $videoHTML = $('<div/>');
          if ($videoSize.val() == 0) {
            $videoHTML.addClass('embed-responsive embed-responsive-16by9');
            $videoHTML.css({ 'float': $videoAlignment.val() });
            var videoWidth = 'auto',
              videoHeight = 'auto';
          }
          if ($videoSize.val() == 1) var videoWidth = '1280', videoHeight = '720';
          if ($videoSize.val() == 2) var videoWidth = '853', videoHeight = '480';
          if ($videoSize.val() == 3) var videoWidth = '640', videoHeight = '360';
          if ($videoSize.val() == 4) var videoWidth = '560', videoHeight = '315';
          var ytMatch = url.match(/^(?:https?:\/\/)?(?:www\.)?(?:youtu\.be\/|youtube\.com\/(?:embed\/|v\/|watch\?v=|watch\?.+&v=))((\w|-){11})(?:\S+)?$/);
          var igMatch = url.match(/(?:www\.|\/\/)instagram\.com\/p\/(.[a-zA-Z0-9_-]*)/);
          var vMatch = url.match(/\/\/vine\.co\/v\/([a-zA-Z0-9]+)/);
          var vimMatch = url.match(/\/\/(player\.)?vimeo\.com\/([a-z]*\/)*([0-9]{6,11})[?]?.*/);
          var dmMatch = url.match(/.+dailymotion.com\/(video|hub)\/([^_]+)[^#]*(#video=([^_&]+))?/);
          var youkuMatch = url.match(/\/\/v\.youku\.com\/v_show\/id_(\w+)=*\.html/);
          var mp4Match = url.match(/^.+.(mp4|m4v)$/);
          var oggMatch = url.match(/^.+.(ogg|ogv)$/);
          var webmMatch = url.match(/^.+.(webm)$/);
          var $video;
          var urlVars = '';
          if (ytMatch && ytMatch[1].length === 11) {
            if (!$videoSuggested.is(':checked')) urlVars += 'rel=0';
            if (!$videoControls.is(':checked')) urlVars += '&controls=0';
            if ($videoAutoplay.is(':checked')) urlVars += '&autoplay=1';
            if (!$videoLoop.is(':checked')) urlVars += '&loop=0';
            var youtubeId = ytMatch[1];
            $video = $('<iframe>')
              .attr('frameborder', 0)
              .attr('src', '//www.youtube.com/embed/' + youtubeId + '?' + urlVars)
              .attr('width', videoWidth)
              .attr('height', videoHeight);
          } else if (igMatch && igMatch[0].length) {
            $video = $('<iframe>')
              .attr('frameborder', 0)
              .attr('src', 'https://instagram.com/p/' + igMatch[1] + '/embed/')
              .attr('width', videoWidth)
              .attr('height', videoHeight)
              .attr('scrolling', 'no')
              .attr('allowtransparency', 'true');
          } else if (vMatch && vMatch[0].length) {
            $video = $('<iframe>')
              .attr('frameborder', 0)
              .attr('src', vMatch[0] + '/embed/simple')
              .attr('width', videoWidth)
              .attr('height', videoHeight)
              .attr('class', 'vine-embed');
          } else if (vimMatch && vimMatch[3].length) {
            if ($videoAutoplay.is(':checked')) urlVars += '&autoplay=1';
            if ($videoLoop.is(':checked')) urlVars += '&loop=1';
            $video = $('<iframe webkitallowfullscreen mozallowfullscreen allowfullscreen>')
              .attr('frameborder', 0)
              .attr('src', '//player.vimeo.com/video/' + vimMatch[3] + '?' + urlVars)
              .attr('width', videoWidth)
              .attr('height', videoHeight);
          } else if (dmMatch && dmMatch[2].length) {
            if (!$videoSuggested.is(':checked')) urlVars += 'related=1';
            if (!$videoAutoplay.is(':checked')) urlVars += 'autoplay=1'; else urlVars += 'autoplay=0';
            $video = $('<iframe>')
              .attr('frameborder', 0)
              .attr('src', '//www.dailymotion.com/embed/video/' + dmMatch[2])
              .attr('width', videoWidth)
              .attr('height', videoHeight);
          } else if (youkuMatch && youkuMatch[1].length) {
            $video = $('<iframe webkitallowfullscreen mozallowfullscreen allowfullscreen>')
              .attr('frameborder', 0)
              .attr('width', videoWidth)
              .attr('height', videoHeight)
              .attr('src', '//player.youku.com/embed/' + youkuMatch[1]);
          } else if (mp4Match || oggMatch || webmMatch) {
            $video = $('<video controls>')
              .attr('src', url)
              .attr('width', videoWidth)
              .attr('height', videoHeight);
          }
          if ($videoSize.val() == 0) $video.addClass('embed-responsive'); else $video.css({ 'float': $videoAlignment.val() });
          $video.addClass('note-video-clip');
          $videoHTML.html($video);
          context.invoke('restoreRange');
          context.invoke('editor.insertNode', $videoHTML[0]);
        });
      };
      this.showLinkDialog = function (vidInfo) {
        return $.Deferred(function (deferred) {
          var $videoHref = self.$dialog.find('.note-video-attributes-href');
          $editBtn = self.$dialog.find('.note-video-attributes-btn');
          ui.onDialogShown(self.$dialog, function () {
            context.triggerEvent('dialog.shown');
            $editBtn.click(function (e) {
              e.preventDefault();
              deferred.resolve({
                vidDom: vidInfo.vidDom,
                href: $videoHref.val()
              });
            });
            $videoHref.val(vidInfo.href).focus;
            self.bindEnterKey($editBtn);
            self.bindLabels();
          });
          ui.onDialogHidden(self.$dialog, function () {
            $editBtn.off('click');
            if (deferred.state() === 'pending') deferred.reject();
          });
          ui.showDialog(self.$dialog);
        });
      };
    }
  });
}));
