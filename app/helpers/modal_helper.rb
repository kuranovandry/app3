module ModalHelper
  def help_modal(id, title, &block)
    modal_options = {
      'id' => id, 'class' => 'modal fade', 'tabindex' => -1, 'data-toggle' => 'modal',
      'aria-hidden' => 'false', 'role' => 'dialog'
    }
    content_tag(:div, modal_options) do
      content_tag(:div, class: 'modal-dialog') do
        content_tag(:div, class: 'modal-content') do
          concat modal_header(title)
          concat capture(&block) if block_given?
        end
      end
    end
  end

  def modal_header(title)
    content_tag(:div, class: 'modal-header') do
      content_tag(:h3, title)
    end
  end
end
