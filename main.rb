require 'gtk3'
Dir[File.dirname(__FILE__) + '/oop/*.rb'].each {|file| require "#{file}"}


class RubyApp < Gtk::Window

  attr_accessor :hash_with_data, :array, :array_cub, :array_hyp

  def initialize
    super

    @array = Array.new
    @hash_with_data = Hash.new
    @array_hyp = Array.new
    @array_cub = Array.new

    init_ui
  end


  def init_ui

    table = Gtk::Table.new 2, 2, true

    open = Gtk::Button.new :label => '1.Read'
    plot = Gtk::Button.new :label => '2.Plotting'
    save = Gtk::Button.new :label => '3.Save file'
    quit = Gtk::Button.new :label => 'Quit'

    open.signal_connect 'clicked' do
      on_open
    end

    plot.signal_connect 'clicked' do
      on_plot
    end

    save.signal_connect 'clicked' do
      on_save
    end

    quit.signal_connect 'clicked' do
      Gtk.main_quit
    end

    table.attach open, 0, 1, 0, 1
    table.attach plot, 1, 2, 0, 1
    table.attach save, 0, 1, 1, 2
    table.attach quit, 1, 2, 1, 2

    add table

    set_title 'Excel'

    signal_connect 'destroy' do
        Gtk.main_quit
    end

    set_default_size 300, 100
    set_window_position :center

    show_all

  end

  def on_open
    dialog = Gtk::FileChooserDialog.new :title => 'Read file',
                                     :parent => parent_window,
                                     :action => :open,
                                     :buttons => [[Gtk::Stock::OPEN, Gtk::ResponseType::ACCEPT],
                                                  [Gtk::Stock::CANCEL, Gtk::ResponseType::CANCEL]]

    if dialog.run == :accept
      ReadFromExcelFile.new(dialog.filename).open_sheet.each{|row| @array<<row}

      solid = WorkWithArray.new(array)
      hash_with_data[:head_data] = solid.header
      solid.sort_array!
      solid.average!
      hash_with_data[:row_data_with_id] = solid.array_to_hash
    end

    dialog.destroy
  end

  def on_plot
    window = Gtk::Window.new('Plotting')
    window.border_width = 0
    window.set_default_size 200, 300
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
    column = Gtk::TreeViewColumn.new('Select Gene',
                                     Gtk::CellRendererText.new, {text: 0})
    treeview = Gtk::TreeView.new(model)
    treeview.append_column(column)
    treeview.selection.set_mode(:single)
    scrolled_win.add_with_viewport(treeview)

    hash_with_data[:head_data].last.each do |v|
      if v[/CG/]
        iter = model.append
        iter[0] =  v
      end
    end

    button_hyp = Gtk::Button.new label: 'Plot hyperbola'
    button_hyp.can_focus=true

    button_cub = Gtk::Button.new label: 'Plot cubic parabola'
    button_cub.can_focus=true

    button_hyp.signal_connect 'clicked' do
      iter = treeview.selection.selected
      gene_id = model.get_value(iter, 0)

      plot_hyp(gene_id)
    end

    button_cub.signal_connect 'clicked' do
      iter = treeview.selection.selected
      gene_id = model.get_value(iter, 0)

      plot_cub(gene_id)
    end

    box2.pack_start(button_hyp, expand: false, fill: true, padding: 0)
    box2.pack_start(button_cub, expand: false, fill: true, padding: 0)

    separator = Gtk::Separator.new(:horizontal)

    box1.pack_start(separator, expand: false, fill: true, padding: 0)
    separator.show

    button = Gtk::Button.new :label => 'Back'
    button.signal_connect 'clicked' do
      window.destroy
    end
    box2.pack_start(button, expand: false, fill: true, padding: 0)
    button.can_default=true
    button.grab_default

    window.can_focus = true
    window.show_all
  end

  def on_save
    save = Gtk::FileChooserDialog.new title: 'Save as',
                                      parent: parent_window,
                                      action: :save,
                                      buttons: [[Gtk::Stock::SAVE_AS, Gtk::ResponseType::ACCEPT],
                                                   [Gtk::Stock::CANCEL, Gtk::ResponseType::CANCEL]]

    if save.run == :accept
      RecordToFile.new(save.filename, hash_with_data[:head_data].first,
                      array_hyp, array_cub).book_write
      puts "filename = #{save.filename}"
    end
    save.destroy
  end

  def plot_hyp(gene)
    hyperbola_equation = Hyperbola.new(hash_with_data[:row_data_with_id][hash_with_data[:head_data].last.first],
                                       hash_with_data[:row_data_with_id][gene])

    plot = PlotHyp.new(hyperbola_equation, gene)
    plot.plotting_equation
    @array_hyp << [gene] + plot.y
  end

  def plot_cub(gene)
    cubic_parabola_equation = CubicParabola.new(hash_with_data[:row_data_with_id][hash_with_data[:head_data].last.first],
                                                hash_with_data[:row_data_with_id][gene])

    plot = PlotCP.new(cubic_parabola_equation, gene)
    plot.plotting_equation
    @array_cub << [gene] + plot.y
  end

end


window = RubyApp.new
Gtk.main
