var Comment = React.createClass({
  render: function() {
    var iconImg = `/images/user_icons/user${this.props.icon_number}.png`;
    return (
      <div>
        <img src={iconImg} alt="IconImage" width="20" height="20"></img>
        { this.props.user } said:
        <p>{ this.props.body }</p>
      </div>
    );
  }
});
