var NewPoll = React.createClass({
  getInitialState: function() {
    return {
      options: [""]
    }
  },
  addOption: function(e) {
    e.preventDefault();
    this.state.options.push("")
    this.setState({
      options: this.state.options
    })
  },
  render: function() {
    var optionsInputs = this.state.options.map(function(option, index) {
      return (
        <div key={index}>
          <input key={index} id={index} name="poll[options]" type="text" />
          <br />
        </div>
      );
    });
    return (
      <div>
        <form action="/polls" id="new_poll" method="post">
          <label for="poll_title">Title</label>:
          <input id="poll_title" name="poll[title]" type="text" /><br />
          <label>Options:</label>
          <br />
          {optionsInputs}
          <button type="button" onClick={this.addOption}>add option</button>
          <input name="commit" type="submit" value="Create Poll" />
        </form>
      </div>
    )
  }
});