module CommentsHelper
    def render_comments(comments)
        comments.map do |comment, nested_comments|
            render partial: 'comments/comment', locals: { comment: comment, nested_comments: nested_comments }
        end.join.html_safe
    end
end