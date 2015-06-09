var CommentBox = React.createClass({

  getInitialState: function() {
    return JSON.parse(this.props.presenter);
  },

  loadCommentsFromServer: function() {
    $.ajax({
      url: this.state.form.action + "/get_comment",
      type: "GET",
      dataType: "json",
      success: function( data ) {
        this.setState({ comments: data.reverse() });
      }.bind(this)
    });
  },

  handleCommentSubmit: function( formData, action ) {
    $.ajax({
      data: formData,
      url: action,
      type: "POST",
      dataType: "json",
      success: function( data ) {
        this.setState({ comments: data.reverse() });
      }.bind(this)
    });
  },

  componentDidMount: function() {
    this.loadCommentsFromServer();
    setInterval(this.loadCommentsFromServer, this.props.pollInterval);
  },

  render: function() {
    return (
      <div className="comment-box">
        <CommentForm form={ this.state.form } onCommentSubmit={ this.handleCommentSubmit } />
        <div className="comment-field">
          <CommentList comments={ this.state.comments } />
        </div>
      </div>
    )
  }
});
