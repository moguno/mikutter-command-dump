# coding: UTF-8

Plugin.create(:"mikutter-command-dump") {
  require "pp"

  command(:dump_message,
          :name => _("ダンプ"),
          :condition => lambda { |opt| Plugin::Command[:HasMessage] },
          :visible => true,
          :role => :timeline) { |opt|

    if !Plugin::GUI::Tab.cuscaded.has_key?(:dump)
      @debug_textview = Gtk::TextView.new.show_all
      debug_textview = @debug_textview

      tab(:dump, _("ダンプ")) {
        set_deletable(true)
        temporary_tab
        nativewidget(debug_textview)
      }
    end

    @debug_textview.buffer.text = opt.messages[0].to_hash.pretty_inspect
    Plugin::GUI::Tab.instance(:dump).active!
  }
}
