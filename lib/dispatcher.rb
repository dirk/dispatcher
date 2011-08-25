require 'pty'

module Dispatcher
  LIB_PATH        = File.dirname(__FILE__)
  DISPATCHER_PATH = LIB_PATH + '/dispatcher'
  
  #autoload :Application, "#{STEVIE}/application"
  #autoload :Page,        "#{STEVIE}/page"
  #autoload :Nest,        "#{STEVIE}/nest"
  #autoload :Templates,   "#{STEVIE}/templates"
  
  def self.version
    @version ||= File.open(File.join(File.dirname(__FILE__), '..', 'VERSION')) { |f| f.read.strip }
  end
  
  class << self
    def dispatch!
      # Current working directory
      @wd = Dir.getwd
      # List of defined services to start
      @defs = []
    
      guess = guess_sf
      #if valid_sf(guess)
        @sdesc = process_sf(guess)
      #else
        # TODO: Add condition to handle non-provided service file (sf)
      #end
      
      
      start!
    end #/self.dispatch!
    
    def start!
      @defs.each do |d|
        d.run!
      end
      
      sleep 1.0
      
      while all_running?
        sleep 0.1
      end
      
      puts "Dead process"
    end #/self.start!
    
    def all_running?
      @defs.map {|d| d.running }.include? false
    end
    
    def wd; @wd; end
    def defs; @defs; end
  
    def guess_sf
      @wd + '/Servicefile'
    end
  
    def valid_sf(sf)
      return false unless File.exist? sf
    
    end
  
    def process_sf(sf)
      service_data = File.read(sf)+"\n"
      
      defs = service_data.split("\n").map {|d| d.strip }
      
      defs.each do |d|
        @defs << Definition.new(d, self)
      end
    end
    
    
  end #/class << self
  
  class Definition
    attr_accessor :name, :dir, :cmd
    attr_reader :pid, :parent, :running
    
    def initialize(d, parent)
      @running = false
      @parent = parent
      @pid = nil
      parse!(d)
    end
    
    def parse!(d)
      matches = d.match(/([A-z]+)(\([^)]+\))?:\s+(.+)/).to_a
      
      @name = matches[1]
      @dir  = matches[2]
      if @dir.nil? and File.directory?(File.join @parent.wd, @name)
        @dir = File.join @parent.wd, @name
      else
        @dir = @dir.slice(1, @dir.length - 2)
      end
      @cmd  = matches[3]
    end
    
    def log_name
      max = @parent.defs.map {|d| d.name.length }.sort.last
      @name.ljust max
    end
    
    def run!
      #puts "[#{@name}] PTY launched; executing..."
      
      begin
        
        @thread = Thread.new {
          PTY.spawn("cd #{dir} && #{@cmd}") do |stdin, stdout, pid|
            @pid = pid
        
            trap("SIGTERM") { Process.kill("SIGTERM", pid) }
            until stdin.eof?
              #info stdin.gets, process
              @running = false
              
              puts "#{log_name} | "+stdin.gets
            end
          end
        }
        @running = true
        
      rescue PTY::ChildExited, Interrupt, Errno::EIO => e
        puts e.inspect
      end
      
        
      
      
      
=begin
      @fpid = Process.fork do
        PTY.spawn("cd #{dir} && #{@cmd}") do |stdin, stdout, pid|
          @pid = pid
      
          trap("SIGTERM") { Process.kill("SIGTERM", pid) }
          until stdin.eof?
            #info stdin.gets, process
            puts "[#{@name}] "+stdin.gets
          end
        end
      end
      
      trap("SIGTERM") { Process.kill("SIGTERM", @fpid) }
      
      # https://github.com/ddollar/foreman/blob/master/lib/foreman/engine.rb#L109
      def run(process)
        proctitle "ruby: foreman #{process.name}"
        trap("SIGINT", "IGNORE")
      
        begin
          Dir.chdir directory do
            PTY.spawn(runner, process.command) do |stdin, stdout, pid|
              trap("SIGTERM") { Process.kill("SIGTERM", pid) }
              until stdin.eof?
                info stdin.gets, process
              end
            end
          end
        rescue PTY::ChildExited, Interrupt, Errno::EIO
          begin
            info "process exiting", process
          rescue Interrupt
          end
        end
      end
      
      
      # http://stackoverflow.com/questions/1154846/continuously-read-from-stdout-of-external-process-in-ruby
      require 'pty'
      begin
        PTY.spawn( "ruby random.rb" ) do |stdin, stdout, pid|
          begin
            stdin.each { |line| print line }
          rescue Errno::EIO
          end
        end
      rescue PTY::ChildExited
        puts "The child process exited!"
      end
=end
    end
  end
end

#include Stevenson::Delegator