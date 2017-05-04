require 'cgi'
require 'date'
require 'json'

require 'rubygems'
require 'sqlite3'

DATABASE_PATH = '/home/xlucas/.i3/i3.db'

class Storage
  def self.init
    unless File.exists?(DATABASE_PATH)
        db = SQLite3::Database.new(DATABASE_PATH)
        db.execute( %{
          CREATE TABLE foo
          (key varchar(100) PRIMARY KEY,
          value varchar(1000),
          modified timestamp(20))
        } )
    end
  end
  def self.get(key)
    db = SQLite3::Database.new(DATABASE_PATH)
    row = db.get_first_row( %{
      SELECT * FROM foo WHERE key='#{key}'
    } )
    if row != nil
      row[1]
    end
  end
  def self.set(key, val)
    db = SQLite3::Database.new(DATABASE_PATH)
    db.execute( %{
      REPLACE INTO foo
      (key, value, modified)
      VALUES ('%s', '%s', %d)
    } % [key, val, Time.now.to_i] )
  end
end

module I3BlockHandler

    COLOR_BLUE          =  "#2397fc"
    COLOR_LIGHT_BLUE    =  "#65e2eb"
    COLOR_CYAN          =  "#1a92ba"
    COLOR_DARK_CYAN     =  "#24596b"
    COLOR_GREEN         =  "#26bb73"
    COLOR_LIGHT_GREEN   =  "#3db325"
    COLOR_MID_GREEN     =  "#1a8a54"
    COLOR_DARK_GREEN    =  "#0f5433"
    COLOR_YELLOW        =  "#b8bb26"
    COLOR_ORANGE        =  "#fabd2f"
    COLOR_PURPLE        =  "#744ee6"
    COLOR_PINK          =  "#9d84e8"
    COLOR_RED           =  "#fb4934"

  def print_json(full_text, min_width, color = nil, short_text = nil, align = "left", urgent = false)
    block = {}
    method(__method__).parameters.map do |p|
      name = p[1]
      value = eval("#{name}")
      block[name] = value if value != nil
    end

    puts JSON.generate(block)
  end

  module_function :print_json


  def refresh_context(execname)
    key = File.basename(execname)
    key.slice!('.rb')

    Storage.init()
    new_date = DateTime.now
    old_date = DateTime.new(1970,1,1)

    date_str = Storage.get(key)

    if date_str
        old_date = DateTime.rfc3339(date_str)
    end

    Storage.set(key, new_date.rfc3339)

    return {
      :new => new_date,
      :old => old_date,
    }
  end

  module_function :refresh_context

  def notify(execname, title, body, urgency: 'low', display_time: 15, event_date: nil, context: nil)
    tag = File.basename(execname)
    tag.slice!(".rb")
    body = CGI.escapeHTML(body)
    title = CGI.escapeHTML(title)
    tag = CGI.escapeHTML(tag)
    if (not event_date and not context) or (event_date >= context[:old] and event_date < context[:new])
      %x(notify-send "[#{tag.upcase}] #{title}" "#{body}" -u "#{urgency}" -t "#{display_time * 1000}")
    end
  end

  module_function :notify

end
