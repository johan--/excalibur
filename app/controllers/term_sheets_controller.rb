class TermSheetsController < ApplicationController
  before_action :set_term_sheet, only: [:show, :edit, :update, :destroy]

  # GET /term_sheets
  # GET /term_sheets.json
  def index
    @term_sheets = TermSheet.all
  end

  # GET /term_sheets/1
  # GET /term_sheets/1.json
  def show
  end

  # GET /term_sheets/new
  def new
    @term_sheet = TermSheet.new
  end

  # GET /term_sheets/1/edit
  def edit
  end

  # POST /term_sheets
  # POST /term_sheets.json
  def create
    @term_sheet = TermSheet.new(term_sheet_params)

    respond_to do |format|
      if @term_sheet.save
        format.html { redirect_to @term_sheet, notice: 'Term sheet was successfully created.' }
        format.json { render :show, status: :created, location: @term_sheet }
      else
        format.html { render :new }
        format.json { render json: @term_sheet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /term_sheets/1
  # PATCH/PUT /term_sheets/1.json
  def update
    respond_to do |format|
      if @term_sheet.update(term_sheet_params)
        format.html { redirect_to @term_sheet, notice: 'Term sheet was successfully updated.' }
        format.json { render :show, status: :ok, location: @term_sheet }
      else
        format.html { render :edit }
        format.json { render json: @term_sheet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /term_sheets/1
  # DELETE /term_sheets/1.json
  def destroy
    @term_sheet.destroy
    respond_to do |format|
      format.html { redirect_to term_sheets_url, notice: 'Term sheet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_term_sheet
      @term_sheet = TermSheet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def term_sheet_params
      params[:term_sheet]
    end
end
