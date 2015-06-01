var CommentList = React.createClass({
  render: function () {
    var commentNodes = this.props.comments.map(function ( comment ) {
      return <Comment icon_number= { comment.icon_number } user={ comment.author } body={ comment.body } key={ comment.id } />
    });

    return (
      <div className="comment-list">
        { commentNodes }
      </div>
    )
  }
});
