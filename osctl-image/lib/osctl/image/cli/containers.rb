require 'json'
require 'libosctl'
require 'osctl/image/cli/command'

module OsCtl::Image
  class Cli::Containers < Cli::Command
    FIELDS = %i(
      pool
      id
      type
      distribution
      version
    )

    def list
      if opts[:list]
        puts FIELDS.join("\n")
        return
      end

      cts = get_cts(OsCtldClient.new)

      fmt_opts = {
        layout: :columns,
        cols: opts[:output] ? opts[:output].split(',').map(&:to_sym) : FIELDS,
        sort: opts[:sort] && opts[:sort].split(',').map(&:to_sym),
        header: !opts['hide-header'],
      }

      OsCtl::Lib::Cli::OutputFormatter.print(cts, **fmt_opts)
    end

    def delete
      client = OsCtldClient.new
      cts = get_cts(client)
      cts.select! { |ct| ct[:type] == opts[:type] } if opts[:type]
      cts.select! { |ct| args.include?(ct[:id]) } if args.any?

      unless opts[:force]
        puts 'The following containers will be deleted:'
        cts.each { |ct| puts "  #{ct[:pool]}:#{ct[:id]}" }
        STDOUT.write('Continue? [y/N]: ')
        STDOUT.flush
        return if STDIN.readline.strip != 'y'
      end

      cts.each do |ct|
        client.delete_container(ct[:id])
      end
    end

    protected
    def get_cts(client)
      cts = client.list_containers.select do |ct|
        ct.has_key?(:'org.vpsadminos.osctl-image:type')
      end.map do |ct|
        ct[:type] = ct[:'org.vpsadminos.osctl-image:type']
        ct
      end
    end
  end
end
