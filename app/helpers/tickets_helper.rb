module TicketsHelper
  def toggle_watching_button(ticket)
    text = ticket.watchers.include?(current_user) ? "Unwatch" : "Watch"
    link_to text, watch_project_ticket_path(ticket.project, ticket), class: text.parameterize, method: :patch
  end
end
