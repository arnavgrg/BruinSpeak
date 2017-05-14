class SignaturesController < ApplicationController
  def create
    @signature = Signature.new(signatureParams)
    if @signature.save
      redirect_to Petition.find(signatureParams[:petition_id]), :notice => "Your signature has been recorded"
    else
      redirect_to root_path, :notice => "Failed to create signature"
    end
  end

  def destroy
    @signature = Signature.find_by(user_id: params[:user_id])

    respond_to do |format|
      if @signature.destroy
        # TODO: make AJAX request instead of reloading page
        format.html { redirect_to(:back, notice: 'Signature was successfully removed') }
      else
        # TODO: If the comment fails to delete, pop up a notification
        format.html { redirect_to(:back) }
      end
    end
  end

  private

  def signatureParams
    params.require(:signature).permit(:id, :user_id, :petition_id, :reason)
  end
end
