module CommentsHelper
    def render_comments(comments)
        # This renders: 
        # The individual comment(_comment.html.erb)
        # A reply form with parent: comment
        # The nested replies (nested-comments div)
        comments.map do |comment, nested_comments|
            render(partial: 'comments/comment', locals: { comment: comment }) + 
            render(partial: 'comments/form', locals: { post: comment.post, parent: comment } ) + 
            content_tag(:div, render_comments(nested_comments), class: "nested-comments")
        end.join.html_safe
    end
end