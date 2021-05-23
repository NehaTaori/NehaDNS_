def get_command_line_argument
  # ARGV is an array that Ruby defines for us,
  # which contains all the arguments we passed to it
  # when invoking the script from the command line.
  # https://docs.ruby-lang.org/en/2.4.0/ARGF.html
  if ARGV.empty?
    puts "Usage: ruby lookup.rb <domain>"
    exit
  end
  ARGV.first
end

# `domain` contains the domain name we have to look up.
domain = get_command_line_argument

# File.readlines reads a file and returns an
# array of string, where each element is a line
# https://www.rubydoc.info/stdlib/core/IO:readlines
dns_raw = File.readlines("/home/ayush/Pupilfirst WD-201/Simple Data Types/DNS resolver/zone")

# ..
# ..
# FILL YOUR CODE HERE
# ..
# ..
def parse_dns(lines)
  records = []
  lines.each do |line|
    filtered_line = line.strip
    cols = filtered_line.split(",")
    if filtered_line.start_with? "#" or filtered_line.length == 0
      next
    elsif cols.length == 3
      record = {}
      record[:record_type] = [cols[0].strip]
      record[:domain] = [cols[1].strip]
      record[:address] = [cols[2].strip]
      records += [record]
    end
  end
  records
end

def resolve(dns_records, lookup_chain, domain)
  lookup = [domain]
  dns_records.each do |record|
    if record[:domain] == lookup_chain
      if record[:record_type] == ["A"]
        lookup += record[:address]
        return lookup
      elsif record[:record_type] == ["CNAME"]
        lookup += record[:address]
        return resolve(dns_records, record[:address], lookup)
      else
        lookup = ["Error: record not found for #{lookup_chain[0]} "]
      end
    end
  end

  lookup = ["Error: record not found for #{lookup_chain[0]}"]
end

# To complete the assignment, implement `parse_dns` and `resolve`.
# Remember to implement them above this line since in Ruby
# you can invoke a function only after it is defined.
dns_records = parse_dns(dns_raw)
lookup_chain = [domain]
lookup_chain = resolve(dns_records, lookup_chain, domain)
puts lookup_chain.join(" => ")
