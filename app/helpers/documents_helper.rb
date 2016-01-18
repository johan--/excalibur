module DocumentsHelper


	def document_checklist(doc)
		if current_user.has_documents?(doc)
			content_tag(:span, "v", class: "badge badge-success", 
				:"data-toggle" => "tooltip", :"data-placement" => "left",
				:"title" => "sudah")
		else
			content_tag(:span, " ", class: "badge", 
				:"data-toggle" => "tooltip", :"data-placement" => "left",
				:"title" => "belum")			
		end
	end

	def docs_per_category(category)
		if category == 'identitas'
			return identity_docs
		elsif category == 'penghasilan'
			return earning_docs
		elsif category == 'pengeluaran'
			return expense_docs
		elsif category == 'kepemilikan'
			return collateral_docs
		end
	end

end