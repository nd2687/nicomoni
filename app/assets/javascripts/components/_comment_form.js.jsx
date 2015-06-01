var CommentForm = React.createClass({
  handleSubmit: function( event ) {
    event.preventDefault();

    var body = this.refs.body.getDOMNode().value.trim();

    if (!body) {
      return false;
    }

    var formData = $( this.refs.form.getDOMNode() ).serialize();
    this.props.onCommentSubmit( formData, this.props.form.action );

    this.refs.body.getDOMNode().value = "";
  },
  render: function() {
    return (
      <form ref="form" className="comment-form pure-form pure-form-stacked" action={ this.props.form.action } accept-charset="UTF-8" method="post" onSubmit={ this.handleSubmit }>
        <p><input type="hidden" name={ this.props.form.csrf_param } value={ this.props.form.csrf_token } /></p>
        <p><textarea ref="body" name="comment[body]" placeholder="Say something..." className="CommentFormTextArea" /></p>
        <p><button type="submit" className="pure-button">Post comment</button></p>
      </form>
    )
  }
});
