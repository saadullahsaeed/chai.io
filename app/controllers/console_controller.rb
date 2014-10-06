class ConsoleController < DashboardController
  include ChaiIo::Report

  #GET
  def index
    @active = 'console'
  end

  #POST
  def run
    query = console_params[:query]
    datasource = current_user.datasources.find console_params[:datasource_id]
    report = Report.new
    report.datasource = datasource
    report.cache_time = 0
    report.config = { 'query' => query }

    begin
      runner = ReportRunner.new(report, params)
      results = runner.run
      columns = runner.columns

      @data = { data: results, columns: columns }

    rescue Sequel::DatabaseError => e
     @data = { error: "Query Error: #{e.message}" }
    rescue Timeout::Error => e
     @data = { error: "Query timed out." }
    rescue => e
     @data = { error: "Unable to connect to database!" }
    end

    respond_to do |format|
       format.json { render :json => @data }
    end

  end


  private
    def console_params
      params.require(:console).permit(:query, :datasource_id)
    end

end
