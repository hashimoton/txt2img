# coding: utf-8
# A Text Rasterizer

require 'optparse'
require 'chunky_png'
require 'rgb'


class Txt2ImgCommand
  
  DEFAULT_WIDTH = 200
  DEFAULT_HEIGHT = 1000
  DEFAULT_KEYWORDS = []
  DEFAULT_OUTPUT_FILE = 'txt2img.png'
  
  COLOR_NULL = RGB::Color.from_fractions(0, 0, 0.1).to_rgb
  COLOR_SP = RGB::Color.from_fractions(0, 0, 0.9).to_rgb
  COLOR_GUARD = RGB::Color.from_fractions(0, 0, 0.7).to_rgb
  
  COLOR_KEYWORDS =
  [
     RGB::Color.from_fractions(0.8, 1.0, 0.5).to_rgb,
     RGB::Color.from_fractions(0.9, 1.0, 0.5).to_rgb,
     RGB::Color.from_fractions(0.1, 1.0, 0.5).to_rgb,
     RGB::Color.from_fractions(0.5, 1.0, 0.5).to_rgb,
     RGB::Color.from_fractions(0.3, 1.0, 0.5).to_rgb
  ]
  
  
  def initialize()
  end
  
  
  def char2rgb(char)
    ord = char.ord
    
    case ord
    when 0x00
      # null -> black
      return COLOR_NULL
    when 0x01 ... 0x1F
      # control chars -> gray
      return RGB::Color.from_fractions(0, 0, (ord-0x01)*0.01+0.2).to_rgb
    when 0x7F
      # del -> gray
      return RGB::Color.from_fractions(0, 0, 31*0.01+0.2).to_rgb
    when 0x20
      # white space -> light gray
      return COLOR_SP
    when 0x30..0x39
      # numbers -> red
      return RGB::Color.from_fractions(0, 0.5, (ord-0x30)*0.02+0.4).to_rgb
    when 0x41..0x5A
      # A-Z  -> green
      return RGB::Color.from_fractions(0.4, 0.5, (ord-0x41)*0.01+0.2).to_rgb
    when 0x61..0x7A
      # a-z -> blue green
      return RGB::Color.from_fractions(0.45, 0.5, (ord-0x61)*0.01+0.2).to_rgb
    end
    
    if ord <= 0x7E
      # ascii symbols -> brown
      return RGB::Color.from_fractions(0.12, 0.5, (ord % 10)*0.02+0.1).to_rgb
    elsif ord >= 0x80
      # byond ascii -> blue
      return RGB::Color.from_fractions(0.65, 0.5, (ord % 10)*0.02+0.4).to_rgb
    end
    
    # exception
    return COLOR_GUARD
  end
  
  
  def opt_parse(argv)
    opts = {}
    
    OptionParser.new do |opt|
      begin
        opt.version = '1.0.0'
        opt.banner += " FILE [FILE...]"
        opt.separator("\nOptions:")
        opt.on('-w=WIDTH',
          'Width (default: 200)') {|v| opts[:w] = v}
        opt.on('-h=HEIGHT',
          'Height (default: 1000)') {|v| opts[:h] = v}
        opt.on('-k=KEYWORDS',
          'Keyword1,keyword2,... (no default)') {|v| opts[:k] = v}
        opt.on('-o=OUTPUT_FILE',
          'Output PNG file (default: txt2img.png)') {|v| opts[:o] = v}
        opt.parse!(ARGV)
      rescue => e
        $stderr.puts "ERROR: #{e}.\n#{opt}"
        exit 1
      end
    end
    
    return opts
  end
  
  
  def main(argv)
    opts = opt_parse(argv)
    width = (opts[:w] ? opts[:w] : DEFAULT_WIDTH).to_i
    height = (opts[:h] ? opts[:h] : DEFAULT_HEIGHT).to_i
    keywords = opts[:k] ? opts[:k].split(',') : DEFAULT_KEYWORDS
    output_file = opts[:o] ? opts[:o] : DEFAULT_OUTPUT_FILE
    
    png = ChunkyPNG::Image.new(width, height)
    line_count = 0
    py = 0
    
    ARGF.each_line do |line|
      line_count += 1
      px = 0
      if py >= height
        break
      end

      # char_count = 0
      line.chars.each do |char|
        # char_count += 1
        if px >= width
          px = 0
          break # no line fold
        end

        r, g, b = char2rgb(char)
        # puts "#{px},#{py}"
        png[px, py] = ChunkyPNG::Color.rgb(r, g, b)

        px += 1
      end
      
      # keywords
      keywords.each_with_index do |keyword, index|
        pos = 0
        while !(pos.nil? || (pos = line.index(keyword, keyword.size + pos)).nil?)
          kpx = pos
          while kpx < keyword.size + pos && kpx < width 
            kr, kg, kb = COLOR_KEYWORDS[index % COLOR_KEYWORDS.size]
            png[kpx, py] = ChunkyPNG::Color.rgb(kr, kg, kb)
            kpx += 1
          end
        end
      end
      
      py += 1
    end
    
    png.save(output_file)
  end
  
end


#### MAIN ####

if __FILE__ == $0
  Txt2ImgCommand.new.main(ARGV)
end

exit 0

# EOF
