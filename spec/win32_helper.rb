if (!(RUBY_PLATFORM =~ /mswin|mingw32|windows/))
  module Win32
    StatusStruct = Struct.new(
      'ServiceStatus',
      :current_state)

    class Service
      def self.exists?(service)
        false
      end

      def self.status(service)
        StatusStruct.new('unknown')
      end
    end
  end
  Win32::StatusStruct.new('ha')
end
