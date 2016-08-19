class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :edit, :paid, :refunded, :download, :destroy]

  # GET /invoices
  def index
    @invoices = Invoice.all
  end

  # GET /invoices/1
  def show
  end

  # GET /invoices/new
  def new
    @invoice = Invoice.new
    @invoice.line_items.build
  end


  # POST /invoices
  def create
    @invoice = Invoice.new(invoice_params)

    if @invoice.save
      redirect_to @invoice, notice: 'Invoice was successfully created.'
    else
      render :new
    end
  end

  # POST /invoices/1/paid
  def paid
    if @invoice.paid!
      redirect_to @invoice, notice: 'Invoice was successfully paid.'
    else
      render :show
    end
  end

  # POST /invoices/1/refunded
  def refunded
    if @invoice.refunded!
      redirect_to @invoice, notice: 'Invoice was successfully refunded.'
    else
      render :show
    end
  end

  # GET /invoices/1/download
  def download
    respond_to do |format|
      format.all do
        send_data @invoice.render_pdf, :filename => "Invoice #{@invoice.invoice_number}.pdf", :type => "application/pdf", :disposition => "inline"
      end
    end
  end

  # DELETE /invoices/1
  def destroy
    @invoice.destroy
    redirect_to invoices_url, notice: 'Invoice was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def invoice_params
      params.require(:invoice).permit(:due_at, :bill_to, line_items_attributes: [:description, :price])
    end
end
