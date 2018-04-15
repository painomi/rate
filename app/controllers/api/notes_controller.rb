class Api::NotesController < ApplicationController

    # GET /Notes
    def index
      # 後々のため、更新順で返します
      @Notes = Note.order('updated_at DESC')
    end
  
    # POST /Notes
    def create
      @Note = Note.new(Note_params)
  
      if @Note.save
        render :show, status: :created
      else
        render json: @Note.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /Notes/1
    def update
      @Note = Note.find(params[:id])
      if @Note.update(Note_params)
        render :show, status: :ok
      else
        render json: @Note.errors, status: :unprocessable_entity
      end
    end
  
    private
      # Never trust parameters from the scary internet, only allow the white list through.
      def Note_params
        params.fetch(:Note, {}).permit(
            :rate, :memo
        )
      end
  end