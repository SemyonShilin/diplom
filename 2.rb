path = File.expand_path(" . ")
require 'gtk3'
require "#{path}\\read_from_excel_file"
require "#{path}\\work_with_array"
require "#{path}\\record_to_file"
require "#{path}\\mnk_cubic_parabola"
require "#{path}\\mnk_hyperbola"
require "#{path}\\plot_cubic_parabola"
require "#{path}\\plot_hyperbola"

class RubyApp < Gtk::Window

	def initialize
		super

		@arr = Array.new
		@hash_with_data = Hash.new

		init_ui
	end

	def init_ui

		window = Gtk::Window.new("Excel")
		table = Gtk::Table.new 2, 2, true

		open = Gtk::Button.new :label => "Read"
		plot = Gtk::Button.new :label => "Plotting"
		save = Gtk::Button.new :label => "Save file"
		quit = Gtk::Button.new :label => "Quit"

		open.signal_connect "clicked" do
			on_open
		end

		plot.signal_connect "clicked" do
			on_plot
		end

		save.signal_connect "clicked" do
			on_save
		end

		quit.signal_connect "clicked" do
			Gtk.main_quit
		end

		table.attach open, 0, 1, 0, 1
		table.attach plot, 1, 2, 0, 1
		table.attach save, 0, 1, 1, 2
		table.attach quit, 1, 2, 1, 2

		window.add(table)

		signal_connect "destroy" do
				Gtk.main_quit
		end

		window.set_default_size 300, 100
		window.set_window_position :center

		window.show_all

	end

	def on_open
		dialog = Gtk::FileChooserDialog.new :title => "Read file",
                                     :parent => parent_window,
                                     :action => :open,
                                     :buttons => [[Gtk::Stock::OPEN, Gtk::ResponseType::ACCEPT],
                                    							[Gtk::Stock::CANCEL, Gtk::ResponseType::CANCEL]]

		if dialog.run == :accept
			ReadFromExcelFile.new(dialog.filename).open_sheet.each{|row| @arr<<row}
		end

		dialog.destroy
	end

	def on_plot
    window = Gtk::Window.new("Plotting")
    window.border_width = 0
    #window.set_default_size 300, 100
		window.set_window_position :center

		box1 = Gtk::Box.new(:vertical, 0)
		window.add(box1)

		box2 = Gtk::Box.new(:vertical, 10)
		box2.border_width = 10
		box1.pack_start(box2, expand: true, fill: true, padding: 0)

		scrolled_win = Gtk::ScrolledWindow.new
		scrolled_win.set_policy(:automatic,:automatic)
		box2.pack_start(scrolled_win, expand: true, fill: true, padding: 0)

		model = Gtk::ListStore.new(String)
		column = Gtk::TreeViewColumn.new("Gene",
		                                 Gtk::CellRendererText.new, {:text => 0})
		treeview = Gtk::TreeView.new(model)
		treeview.append_column(column)
		treeview.selection.set_mode(:single)
		scrolled_win.add_with_viewport(treeview)

		data.each do |v|
		  iter = model.append
		  iter[0] =  v
		end

    window.show_all
	end

	def on_save
		save = Gtk::FileChooserDialog.new :title => "Save as",
                                      :parent => parent_window,
                                      :action => :save,
                                      :buttons => [[Gtk::Stock::SAVE_AS, Gtk::ResponseType::ACCEPT],
                                    							 [Gtk::Stock::CANCEL, Gtk::ResponseType::CANCEL]]

		if save.run == :accept
		  puts "filename = #{save.filename}"
		end
		save.destroy
	end

	def work(arr)
		array = WorkWithArray.new(arr)
		@hash_with_data[head_data] = array.header
		#head_data = array.header
		array.sort_array!
		@hash_with_data[average_data] = array.average
		#average_data = array.average
		@hash_with_data[row_data_with_id] = array.array_to_hash
		row_data_with_id = array.array_to_hash
	end

end


window = RubyApp.new
Gtk.main
