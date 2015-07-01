var Comment = React.createClass({
  render: function() {
    var iconImg = `/images/user_icons/user${this.props.icon_number}.png`;
    var rawMarkUp = marked(this.props.body.toString(), {sanitize: true});
    var nickname = this.props.user;
    return (
      <div>
        <img src={iconImg} alt="IconImage" width="20" height="20" title={nickname} ></img>
        <p dangerouslySetInnerHTML={{__html: rawMarkUp}} />
      </div>
    );
  }
});
