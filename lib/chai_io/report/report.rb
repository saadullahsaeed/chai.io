module ChaiIo
  module Report

    private

      # Load report data - need to re-factor this
      def load_report_data(report)
        begin
          runner = ReportRunner.new(report, params)
          @data = runner.run
          @columns = runner.columns
          @query_params = runner.query_params
        rescue Sequel::DatabaseError => e
         @query_error = true
         flash.now[:error] = "Query Error: #{e.message}"
        rescue Timeout::Error => e
         @query_error = true
         flash.now[:error] = "Query timed out."
        rescue => e
         flash.now[:error] = "Error: #{e.message}"
         @connection_error = true
        end

        @data
      end

  end
end
