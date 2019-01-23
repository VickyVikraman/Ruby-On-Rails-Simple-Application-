class AdminController < ApplicationController

    skip_before_action :verify_authenticity_token
    before_action :authenticate_user!
    
    after_action :verify_authorized,except: :index 
    after_action :verify_policy_scoped,only: :create

    def index
        user = current_user
        authorize user
        @detail = Detail.all
    end

    def destroy
        @detail =  Detail.find(params[:id])
        @detail.destroy
        # render :json => { status: @detail}
    end

    def download 
        user = current_user
        authorize user
        require 'rubygems'
        require 'zip'

        # folder = "/home/vigraman/Documents/Tasks/Ruby on Rails/Crud with AngularJS and Rails/Crud/public/uploads/image/34"
        # folder = "../../public/uploads/detail/image/34"
        # folder = "/home/vigraman/Documents/Tasks/Ruby on Rails/Crud with AngularJS and Rails/Crud/public/uploads/detail/image/"
        folder = "/home/vigraman/Documents/Tasks/"
        input_filenames = ["1.jpg"]
        # binding.pry
        zipfile_name = "/home/vigraman/Desktop/#{Time.now}.zip"

        Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
            input_filenames.each do |filename|
                zipfile.add(filename, File.join(folder, filename))
            end
            zipfile.get_output_stream("myFile") { |f| f.write "myFile contains just this" }
        end
        file_name="/home/vigraman/Desktop/#{Time.now}.zip"
        send_file(
        "/home/vigraman/Desktop/#{Time.now}.zip",
        filename: "#{Time.now}.zip",
        type: "application/zip"
        )  
    end

    def show
        user = current_user
        authorize user
        pdf = WickedPdf.new
        @details = Detail.all
        pdf = render_to_string pdf: "",
                               template: "admin/show.html.erb",
                               background: true,
                               image: true,
                               layout: false, 
                               default_header: false,
                               encoding: "UTF   -8",
                               extra: '--no-stop-slow-scripts'
                               
            
        send_data pdf, :filename => "file.pdf", :type => "application/pdf", :disposition => "attachment"
    end

    def excel
        user = current_user
        authorize user
        p = Axlsx::Package.new
        p.workbook.add_worksheet(:name => "Basic_Worksheet") do |sheet|
            sheet.add_row ["First Column", "Second", "Third"]
            sheet.add_row [1, 2, 3]
        end
        p.use_shared_strings = true
        p.serialize('simple.xlsx')
        send_data p.to_stream.read, :filename => "simple.xlsx", :type => "application/vnd.ms-excel", :disposition => "attachment"
    end
end
