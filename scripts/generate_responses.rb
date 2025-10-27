#!/usr/bin/env ruby
require 'csv'
require 'yaml'
require 'fileutils'

ROOT = File.expand_path('..', __dir__) # project root
DATA_DIR = File.join(ROOT, '_data')
YEARS = %w[2023 2025]

YEARS.each do |year|
  infile = File.join(DATA_DIR, "#{year}-candidate-q-and-a.csv")
  next unless File.exist?(infile)

  rows = CSV.read(infile, headers: true).map { |r| r.to_hash }
  groups = rows.group_by { |r| (r['esd'] || '').to_s.strip.empty? ? 'unknown' : r['esd'].to_s.strip }

  outdir = File.join(ROOT, year, 'response')
  FileUtils.mkdir_p(outdir)

  groups.each do |esd, items|
    safe_esd = esd.gsub(/[^0-9A-Za-z\-_]/, '_')
    filename = "#{safe_esd}.html"
    filepath = File.join(outdir, filename)

    front_matter = {
      'layout' => 'response',
      'title'  => "#{year} responses — ESD #{esd}",
      'nav'    => false,
      'items'  => items
    }

    File.open(filepath, 'w') do |f|
      f.puts '---'
      # ensure the YAML body does not include a leading document marker
      f.puts front_matter.to_yaml.sub(/\A---\s*\n/, '')
      f.puts '---'
      f.puts
    end

    puts "Wrote #{filepath}"
  end
end